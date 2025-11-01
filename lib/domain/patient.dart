class Patient {
  final int? _id;
  final String _name;
  final int _age;
  final String _gender;
  final String _nationality;
  final String _commune;
  final String _district;
  final String _city;
  final int _roomId;
  final int? _bedId;

  Patient({
    int? id,
    required String name,
    required int age,
    required String gender,
    required String nationality,
    required String commune,
    required String district,
    required String city,
    required int roomId,
    int? bedId,
  }) : _id = id,
       _name = name,
       _age = age,
       _gender = gender,
       _nationality = nationality,
       _commune = commune,
       _district = district,
       _city = city,
       _roomId = roomId,
       _bedId = bedId;

  int? get id => _id;
  String get name => _name;
  int get age => _age;
  String get gender => _gender;
  String get nationality => _nationality;
  String get commune => _commune;
  String get district => _district;
  String get city => _city;
  int get roomId => _roomId;
  int? get bedId => _bedId;

  // Convert Map to Object for retrieving from db
  factory Patient.fromMap(Map<String, dynamic> p) {
    return Patient(
      id: p['id'],
      name: p['name'],
      age: p['age'],
      gender: p['gender'],
      nationality: p['nationality'],
      commune: p['commune'],
      district: p['district'],
      city: p['city'],
      roomId: p['room_id'],
      bedId: p['bed_id'],
    );
  }
}