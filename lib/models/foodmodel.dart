class food {
  final int? id;
  final String name;
  final int ccal;
  final int b;
  final int j;
  final int u;

  food({this.id,
    required this.name,
    required this.ccal,
    required this.j,
    required this.b,
    required this.u
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': name,
      'ccal': ccal,
      'b': b,
      'j': j,
      'u': u
    };

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  static food fromMap(Map<String, dynamic> map) {
    return food(
      id: map['id'],
      name: map['name'],
      ccal: map['ccal'],
      b: map['b'],
      j: map['j'],
      u: map['u'],
    );
  }
}