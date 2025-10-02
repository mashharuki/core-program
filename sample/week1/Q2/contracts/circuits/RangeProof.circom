pragma circom 2.1.4;

include "../../node_modules/circomlib/circuits/comparators.circom";

template RangeProof(n) {
  assert(n <= 252);

  signal input in;       // 範囲内であることを証明したい値
  signal input range[2]; // [下限, 上限]
  signal output out;

  component lt = LessEqThan(n);
  component gt = GreaterEqThan(n);

  // 値が下限以上であることを確認
  gt.in[0] <== in;
  gt.in[1] <== range[0];
  
  // 値が上限以下であることを確認
  lt.in[0] <== in;
  lt.in[1] <== range[1];
  
  // 両方の条件が満たされることを確認（1 AND 1 = 1）
  out <== gt.out * lt.out;
}

component main { public [ range ] } = RangeProof(32);