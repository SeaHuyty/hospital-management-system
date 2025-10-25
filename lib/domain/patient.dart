class Address {
  final String _commune;
  final String _district;
  final String _city;

  Address(this._commune, this._district, this._city);

  String get commune => _commune;
  String get district => _district;
  String get city => _city;

  @override
  String toString() {
    return "Sangkat: $commune, Khan: $district, Krong/Khet: $city";
  }
}

class Patient {
  final int? _id;
  final String _name;
  final int _age;
  final String _gender;
  final String _nationality;
  final Address _address;
  final int _roomId;

  Patient({
    int? id,
    required String name,
    required int age,
    required String gender,
    required String nationality,
    required Address address,
    required int roomId,
  }) : _id = id,
       _name = name,
       _age = age,
       _gender = gender,
       _nationality = nationality,
       _address = address,
       _roomId = roomId;

  int? get id => _id;
  String get name => _name;
  int get age => _age;
  String get gender => _gender;
  String get nationality => _nationality;
  Address get address => _address;
  int get roomId => _roomId;

  // Convert Map to Object for retrieving from db
  factory Patient.fromMap(Map<String, dynamic> p) {
    return Patient(
      id: p['id'],
      name: p['name'],
      age: p['age'],
      gender: p['gender'],
      nationality: p['nationality'],
      address: p['address'],
      roomId: p['room_id'],
    );
  }
}