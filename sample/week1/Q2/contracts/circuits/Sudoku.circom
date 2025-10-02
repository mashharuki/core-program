pragma circom 2.1.4;

include "../../node_modules/circomlib-matrix/circuits/matAdd.circom";
include "../../node_modules/circomlib-matrix/circuits/matElemMul.circom";
include "../../node_modules/circomlib-matrix/circuits/matElemSum.circom";
include "../../node_modules/circomlib-matrix/circuits/matElemPow.circom";
include "../../node_modules/circomlib/circuits/poseidon.circom";
include "../../node_modules/circomlib/circuits/comparators.circom";

// 範囲内に収まることを証明する回路
template RangeProof(n) {
  assert(n <= 252);

  signal input in;       // 範囲内であることを証明したい値
  signal input min;      // 下限
  signal input max;      // 上限
  signal output out;

  component gte = GreaterEqThan(n);
  component lte = LessEqThan(n);

  // 値が下限以上であることを確認 (in >= min)
  gte.in[0] <== in;
  gte.in[1] <== min;
  
  // 値が上限以下であることを確認 (in <= max)
  lte.in[0] <== in;
  lte.in[1] <== max;
  
  // 両方の条件が満たされることを確認（1 AND 1 = 1）
  out <== gte.out * lte.out;
}

// 0〜9の範囲をチェックする専用テンプレート
template SudokuRangeProof() {
  signal input in;
  signal output out;

  // RangeProofコンポーネントをインスタンス化
  component rangeCheck = RangeProof(4); // 4ビットで0-15まで表現可能
  // 確認したい値、下限、上限を代入する
  rangeCheck.in <== in;
  rangeCheck.min <== 0;
  rangeCheck.max <== 9;
  // 出力を設定(範囲内に収まっていれば1を返す)
  out <== rangeCheck.out;
}

// sudoku回路
template sudoku() {
    signal input puzzle[9][9]; // 0  where blank
    signal input solution[9][9]; // 0 where original puzzle is not blank
    signal output out;

    // 各マスが0〜9の範囲内であることをRangeProofで確認
    component puzzleRangeProof[9][9];
    component solutionRangeProof[9][9];
    
    for (var i=0; i<9; i++) {
        for (var j=0; j<9; j++) {
            // パズルの値が0-9の範囲内であることを証明するため、SudokuRangeProofのインスタンス化
            puzzleRangeProof[i][j] = SudokuRangeProof();
            puzzleRangeProof[i][j].in <== puzzle[i][j]; // パズルの値を入力
            puzzleRangeProof[i][j].out === 1; // パズルの値が範囲内であることを確認
            
            // 解の値が0-9の範囲内であることを証明
            solutionRangeProof[i][j] = SudokuRangeProof();
            solutionRangeProof[i][j].in <== solution[i][j];
            solutionRangeProof[i][j].out === 1; // 解の値が範囲内であることを確認
        }
    }

    // check whether the solution is zero everywhere the puzzle has values (to avoid trick solution)
    component mul = matElemMul(9,9);
    
    // 全ての入力を設定
    for (var i=0; i<9; i++) {
        for (var j=0; j<9; j++) {
            mul.a[i][j] <== puzzle[i][j];
            mul.b[i][j] <== solution[i][j];
        }
    }
    
    // 出力をチェック
    for (var i=0; i<9; i++) {
        for (var j=0; j<9; j++) {
            mul.out[i][j] === 0;
        }
    }

    // sum up the two inputs to get full solution and square the full solution

    component add = matAdd(9,9);
    
    for (var i=0; i<9; i++) {
        for (var j=0; j<9; j++) {
            add.a[i][j] <== puzzle[i][j];
            add.b[i][j] <== solution[i][j];
        }
    }

    component square = matElemPow(9,9,2);

    for (var i=0; i<9; i++) {
        for (var j=0; j<9; j++) {
            square.a[i][j] <== add.out[i][j];
        }
    }

    // check all rows and columns and blocks sum to 45 and sum of sqaures = 285

    component row[9];
    component col[9];
    component block[9];
    component rowSq[9];
    component colSq[9];
    component blockSq[9];


    for (var k=0; k<9; k++) {
        row[k] = matElemSum(1,9);
        col[k] = matElemSum(1,9);
        block[k] = matElemSum(3,3);

        rowSq[k] = matElemSum(1,9);
        colSq[k] = matElemSum(1,9);
        blockSq[k] = matElemSum(3,3);

        for (var i=0; i<9; i++) {
            row[k].a[0][i] <== add.out[k][i];
            col[k].a[0][i] <== add.out[i][k];

            rowSq[k].a[0][i] <== square.out[k][i];
            colSq[k].a[0][i] <== square.out[i][k];
        }
        var x = 3*(k%3);
        var y = 3*(k\3);
        for (var i=0; i<3; i++) {
            for (var j=0; j<3; j++) {
                block[k].a[i][j] <== add.out[x+i][y+j];
                blockSq[k].a[i][j] <== square.out[x+i][y+j];
            }
        }
        row[k].out === 45;
        col[k].out === 45;
        block[k].out === 45;

        rowSq[k].out === 285;
        colSq[k].out === 285;
        blockSq[k].out === 285;
    }

    // Poseidonを用いてパズルのハッシュを計算（行ごとにハッシュして最後に統合）
    component rowHash[9];
    component finalHash;
    
    // 各行をハッシュ化（9要素ずつ）
    for (var i=0; i<9; i++) {
        rowHash[i] = Poseidon(9);
        for (var j=0; j<9; j++) {
            rowHash[i].inputs[j] <== puzzle[i][j];
        }
    }
    
    // 各行のハッシュを統合
    finalHash = Poseidon(9);
    for (var i=0; i<9; i++) {
        finalHash.inputs[i] <== rowHash[i].out;
    }

    out <== finalHash.out;
}

component main = sudoku();