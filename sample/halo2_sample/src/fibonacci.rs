/*

  このコードは、フィボナッチ数列（1, 1, 2, 3, 5, 8, 13...）を、ゼロ知識証明の制約として表現しています。
  各行で「elem_1 + elem_2 = elem_3」という関係が成り立つことを証明します。

    1, 1, 2, 3, 5, 8, 13, ...

    | elem_1 | elem_2 | sum | q_fib
    --------------------------------
    |    1   |    1   |  2  |   1
    |    1   |    2   |  3  |   1
    |    2   |    3   |  5  |   1
    |        |        |     |   0

    q_fib * (elem_1 + elem_2 - elem_3) = 0

*/

use halo2_proofs::circuit::{Value, Layouter, AssignedCell};
use halo2_proofs::poly::Rotation;
use halo2_proofs::{plonk::*};
use halo2_proofs::arithmetic::Field;

#[derive(Clone, Debug, Copy)]
struct Config {
    elem_1: Column<Advice>, // フィボナッチ数列のn番目
    elem_2: Column<Advice>, // フィボナッチ数列のn+1番目
    elem_3: Column<Advice>, // フィボナッチ数列のn+2番目
    q_fib: Selector,        // この制約を有効にするスイッチ
    instance: Column<Instance>, // パブリック入力用のカラム
}

impl Config {
    // configure関数
    // 回路の制約（ルール）を定義します：
    fn configure<F: Field>(
        cs: &mut ConstraintSystem<F>
    ) -> Self {
        let elem_1 = cs.advice_column();
        cs.enable_equality(elem_1);
        
        let elem_2 = cs.advice_column();
        cs.enable_equality(elem_2);

        let elem_3 = cs.advice_column();
        cs.enable_equality(elem_3);
        let q_fib = cs.selector();

        let instance = cs.instance_column();
        cs.enable_equality(instance);

        // 制約を満たすゲートを作成
        cs.create_gate("fibonacci", |virtual_cells| {
            let q_fib = virtual_cells.query_selector(q_fib);
            let elem_1 = virtual_cells.query_advice(elem_1, Rotation::cur());
            let elem_2 = virtual_cells.query_advice(elem_2, Rotation::cur());
            let elem_3 = virtual_cells.query_advice(elem_3, Rotation::cur());

            vec![
                // 回路の制約（ルール）を定義
                // q_fib * (elem_1 + elem_2 - elem_3) = 0
                q_fib * (elem_1 + elem_2 - elem_3),
            ]
        });

        Self { elem_1, elem_2, elem_3, q_fib, instance }
    }

    // 初期化メソッド
    fn init<F: Field>(
        &self,
        mut layouter: impl Layouter<F>,
        elem_1: Value<F>,
        elem_2: Value<F>,
    ) -> Result<(
        AssignedCell<F, F>, // elem_2
        AssignedCell<F, F> // elem_3
    ), Error> {
        layouter.assign_region(|| "init Fibonacci", |mut region| {
            let offset = 0;

            // Enable q_fib
            self.q_fib.enable(&mut region, offset)?;

            // Assign elem_1
            region.assign_advice(|| "elem_1", self.elem_1, offset, || elem_1)?;

            // Assign elem_2
            let elem_2 = region.assign_advice(|| "elem_2", self.elem_2, offset, || elem_2)?;

            // elem_3 = elem_1 + elem_2
            let elem_3 = elem_1 + elem_2.value_field().evaluate();
            // Assign elem_3
            let elem_3 = region.assign_advice(|| "elem_3", self.elem_3, offset, || elem_3)?;

            // 次の計算のためにelem_2とelem_3を返す
            Ok((
                elem_2,
                elem_3
            ))

        })
    }

    // 継続的なフィボナッチ数列の計算する関数
    fn assign<F: Field>(
        &self,
        mut layouter: impl Layouter<F>,
        elem_2: AssignedCell<F, F>,
        elem_3: AssignedCell<F, F>,
    ) -> Result<(
        AssignedCell<F, F>, // elem_2
        AssignedCell<F, F> // elem_3
    ), Error> {
        layouter.assign_region(|| "steady-state Fibonacci", |mut region| {
            let offset = 0;

            // Enable q_fib
            self.q_fib.enable(&mut region, offset)?;

            // Copy elem_1 (which is the previous elem_2)
            // copy_advice：前の計算結果を次の行で再利用（値が同じであることを証明）
            // Selector：制約のオン/オフを制御し、回路の柔軟性を高める
            let elem_1 = elem_2.copy_advice(|| "copy elem_2 into current elem_1", &mut region, self.elem_1, offset)?;

            // Copy elem_2 (which is the previous elem_3)
            let elem_2 = elem_3.copy_advice(|| "copy elem_3 into current elem_2", &mut region, self.elem_2, offset)?;

            let elem_3 = elem_1.value_field().evaluate() + elem_2.value_field().evaluate();
            // Assign elem_3
            let elem_3 = region.assign_advice(|| "elem_3", self.elem_3, offset, || elem_3)?;

            Ok((
                elem_2,
                elem_3
            ))

        })
    }

    // パブリックとして計算結果を公開する関数
    fn expose_public<F: Field>(
        &self,
        mut layouter: impl Layouter<F>,
        cell: &AssignedCell<F, F>,
        row: usize,
    ) -> Result<(), Error> {
        layouter.constrain_instance(cell.cell(), self.instance, row)
    }
}

// テストコード
#[cfg(test)]
mod tests {
    use halo2_proofs::{circuit::SimpleFloorPlanner, pasta::Fp, dev::MockProver};

    use super::*;

/*
    1, 1, 2, 3, 5, 8, 13, ...

    | elem_1 | elem_2 | sum | q_fib
    --------------------------------
    |    1   |    1   |  2  |   1
    |    1   |    2   |  3  |   1
    |    2   |    3   |  5  |   1
    |        |        |     |   0



*/

    // テスト用の回路を定義
    #[derive(Default)]
    struct MyCircuit<F: Field> {
        elem_1: Value<F>, // 1
        elem_2: Value<F>, // 1
        iterations: usize, // フィボナッチ数列の計算回数
    }

    // テスト用の回路を定義
    impl<F: Field> Circuit<F> for MyCircuit<F> {
        type Config = Config;

        type FloorPlanner = SimpleFloorPlanner;

        fn without_witnesses(&self) -> Self {
            Self {
                elem_1: Value::unknown(),
                elem_2: Value::unknown(),
                iterations: self.iterations,
            }
        }

        // ルール(制約)を定義
        fn configure(meta: &mut ConstraintSystem<F>) -> Self::Config {
            Self::Config::configure(meta)
        }
        // フィボナッチ数列の計算を実行
        fn synthesize(&self, config: Self::Config, mut layouter: impl Layouter<F>) -> Result<(), Error> {
            // elem_2 = 1, elem_3 = 2
            // まず初期化するために init メソッドを呼び出す
            let (mut elem_2, mut elem_3) = config.init(layouter.namespace(|| "init"), self.elem_1, self.elem_2)?;
            
            // フィボナッチ数列を指定回数計算する
            // 初期値: 1, 1 → 2
            // 1回目: 1, 2 → 3  
            // 2回目: 2, 3 → 5
            // 3回目: 3, 5 → 8
            for i in 0..self.iterations {
              // assign メソッドを呼び出して、フィボナッチ数列の次の値を計算
                let (new_elem_2, new_elem_3) = config.assign(
                    layouter.namespace(|| format!("fibonacci step {}", i + 1)), 
                    elem_2, 
                    elem_3
                )?;
                elem_2 = new_elem_2;
                elem_3 = new_elem_3;
            }

            // 計算結果をパブリックとして公開
            config.expose_public(layouter, &elem_3, 0)?;

            Ok(())
        }
    }

    // 実際に実行されるテストコード
    #[test]
    fn test_fib() {
        // サーキットインスタンスを生成
        let circuit = MyCircuit {
            // 1と1から始める
            elem_1: Value::known(Fp::one()),
            elem_2: Value::known(Fp::one()),
            iterations: 3, // 3回計算する
        };

        // 期待されるパブリック入力（フィボナッチ数列の6番目の値、つまり8）
        let instance = Fp::from(8); 
        let public_input = vec![instance];

        // 4回計算するので最終的には8になるはず
        // 8はフィボナッチ数列の6番目
        // フィボナッチ数列の制約を満たしていることを検証する
        let prover = MockProver::run(4, &circuit, vec![public_input]).unwrap();
        prover.assert_satisfied();
    }

    // 異なる計算回数のテストケース
    #[test]
    fn test_fib_different_iterations() {
        // 5回計算する場合（フィボナッチ数列の8番目の値、つまり21）
        let circuit = MyCircuit {
            elem_1: Value::known(Fp::one()),
            elem_2: Value::known(Fp::one()),
            iterations: 5,
        };

        let instance = Fp::from(21); // フィボナッチ数列: 1,1,2,3,5,8,13,21
        let public_input = vec![instance];

        let prover = MockProver::run(6, &circuit, vec![public_input]).unwrap();
        prover.assert_satisfied();
    }

    // 1回だけ計算する場合
    #[test]
    fn test_fib_single_iteration() {
        let circuit = MyCircuit {
            elem_1: Value::known(Fp::one()),
            elem_2: Value::known(Fp::one()),
            iterations: 1,
        };

        let instance = Fp::from(3); // フィボナッチ数列: 1,1,2,3
        let public_input = vec![instance];

        let prover = MockProver::run(4, &circuit, vec![public_input]).unwrap();
        prover.assert_satisfied();
    }

    // 7回計算する場合
    #[test]
    fn test_fib_seven_iterations() {
        let circuit = MyCircuit {
            elem_1: Value::known(Fp::one()),
            elem_2: Value::known(Fp::one()),
            iterations: 7,
        };

        // 3回→8, 5回→21のパターンから、7回→55と推定
        let instance = Fp::from(55); // フィボナッチ数列: 1,1,2,3,5,8,13,21,34,55
        let public_input = vec![instance];

        let prover = MockProver::run(8, &circuit, vec![public_input]).unwrap();
        prover.assert_satisfied();
    }

    // 10回計算する場合
    #[test]
    fn test_fib_ten_iterations() {
        let circuit = MyCircuit {
            elem_1: Value::known(Fp::one()),
            elem_2: Value::known(Fp::one()),
            iterations: 10,
        };

        // 10回計算の場合は233と推定
        let instance = Fp::from(233); // フィボナッチ数列を10回計算
        let public_input = vec![instance];

        let prover = MockProver::run(11, &circuit, vec![public_input]).unwrap();
        prover.assert_satisfied();
    }
}