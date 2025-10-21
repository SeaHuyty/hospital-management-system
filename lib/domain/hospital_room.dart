import 'package:hospital_management_system/domain/patient.dart';

enum RoomType { private, public }
enum RoomCondition { fan, aircon }

class Bed {
  final int _bedNumber;
  Patient? _patient;

  Bed(this._bedNumber);

  int get bedNumber => _bedNumber;
  bool get isAvailable => _patient == null;

  void assignPatient(Patient patient) {
    if (!isAvailable) throw StateError('Bed $bedNumber is already occupied.');
    _patient = patient;
  }

  void vacate() {
    _patient = null; // free the bed
  }
}

class Room {
  static int _counter = 0;
  final int _roomNumber;
  final RoomType _roomType;
  final RoomCondition _roomCondition;
  final List<Bed> _beds;
  final double _pricePerDay;

  Room(this._roomType, this._roomCondition) 
    : _roomNumber = ++_counter,
      _beds = List.generate(_roomType == RoomType.private ? 2 : 4, (i) => Bed(i + 1)),
      _pricePerDay = (() {
        if (_roomType == RoomType.public) return 20000.0;
        if (_roomType == RoomType.private && _roomCondition == RoomCondition.fan) return 30000.0;
        if (_roomType == RoomType.private && _roomCondition == RoomCondition.aircon) return 60000.0;
        return 0.0;
      }());

  int get roomId => _roomNumber;
  RoomType get roomType => _roomType;
  RoomCondition get roomConditon => _roomCondition;
  List<Bed> get beds => _beds;
  double get pricePerDay => _pricePerDay;

  bool get isAvailable => _beds.any((bed) => bed.isAvailable);
  String get status => isAvailable ? "Available" : "Occupied";

  @override
  String toString() {
    return 'Room ID: $roomId | Type: $roomType | Condition: $roomConditon | Price/Day: \$$pricePerDay | Status: $status';
  }
}