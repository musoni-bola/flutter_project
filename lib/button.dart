enum Btn {
  del('D'),
  clr('C'),
  per('%'),
  multiply('×'),
  divide('÷'),
  add('+'),
  subtract('-'),
  calculate('='),
  dot('.'),
  n0('0'),
  n1('1'),
  n2('2'),
  n3('3'),
  n4('4'),
  n5('5'),
  n6('6'),
  n7('7'),
  n8('8'),
  n9('9');

  final String value;

  const Btn(this.value);
}

class BtnValues {
  static const List<Btn> buttonValues = [
    Btn.del,
    Btn.clr,
    Btn.per,
    Btn.multiply,
    Btn.divide,
    Btn.subtract,
    Btn.add,
    Btn.calculate,
    Btn.n7,
    Btn.n8,
    Btn.n9,
    Btn.n4,
    Btn.n5,
    Btn.n6,
    Btn.n1,
    Btn.n2,
    Btn.n3,
    Btn.n0,
    Btn.dot,
  ];
}
