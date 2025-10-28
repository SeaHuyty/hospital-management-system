class Department {
  final int? _id;
  final String _name;

  Department({int? id, required String name}) : _id = id, _name = name;

  int? get id => _id;
  String get name => _name;

  // Convert from database row (Map) to Department object
  factory Department.fromMap(Map<String, dynamic> d) {
    return Department(id: d['id'] as int?, name: d['name']);
  }

  // Convert Department to Map (for inserting/updating in DB)
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }
}

class RoomType {
  final int? _id;
  final String _name;
  final double _price;
  final String? _description;

  RoomType({
    int? id,
    required String name,
    required double price,
    String? description,
  }) : _id = id,
       _name = name,
       _price = price,
       _description = description;

  int? get id => _id;
  String get name => _name;
  double get price => _price;
  String? get description => _description;

  factory RoomType.fromMap(Map<String, dynamic> roomType) {
    return RoomType(
      id: roomType['id'] as int?,
      name: roomType['name'],
      price: roomType['price'] as double,
      description: roomType['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'price': price, 'description': description};
  }
}

class Bed {
  final int? _id;
  final int? _roomId;
  final bool _isOccupied;

  Bed({int? id, int? roomId, required bool isOccupied})
    : _id = id,
      _roomId = roomId,
      _isOccupied = isOccupied;

  int? get id => _id;
  int? get roomId => _roomId;
  bool get isOccupied => _isOccupied;

  factory Bed.fromMap(Map<String, dynamic> bed) {
    return Bed(
      id: bed['id'] as int?,
      roomId: bed['room_id'],
      isOccupied: bed['is_occupied'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'room_id': roomId, 'is_occupied': isOccupied ? 1 : 0};
  }

  // Future<bool> isRoomAvailable(Database db, Room room) async {
  //   // Get the room type
  //   final roomTypeResult = await db.query(
  //     'room_types',
  //     where: 'id = ?',
  //     whereArgs: [room.roomTypeId],
  //   );

  //   if (roomTypeResult.isEmpty) return false;

  //   final roomType = RoomType.fromMap(roomTypeResult.first);

  //   // 🏠 For private/VIP rooms — check isOccupied flag
  //   if (roomType.name.toLowerCase() == 'private' ||
  //       roomType.name.toLowerCase() == 'vip') {
  //     return !room.isOccupied;
  //   }

  //   // 🛏️ For shared/public rooms — check bed availability
  //   final beds = await db.query(
  //     'beds',
  //     where: 'room_id = ? AND is_occupied = 0',
  //     whereArgs: [room.id],
  //   );

  //   // Room is available if there's at least one free bed
  //   return beds.isNotEmpty;
  //}
}

class Room {
  final int? _roomNumber;
  final int? _roomTypeId;
  final int _capacity;
  final int? _departmentId;
  final bool _isOccupied;

  Room({
    int? roomNumber,
    int? roomTypeId,
    required capacity,
    int? departmentId,
    required bool isOccupied,
  }) : _roomNumber = roomNumber,
       _roomTypeId = roomTypeId,
       _capacity = capacity,
       _departmentId = departmentId,
       _isOccupied = isOccupied;

  int? get roomId => _roomNumber;
  int? get roomTypeId => _roomTypeId;
  int get capacity => _capacity;
  int? get departmentId => _departmentId;
  bool get isOccupied => _isOccupied;

  factory Room.fromMap(Map<String, dynamic> room) {
    return Room(
      roomNumber: room['id'] as int?,
      roomTypeId: room['room_type_id'] as int?,
      capacity: room['capacity'],
      departmentId: room['department_id'] as int?,
      // SQLite uses 0/1 for booleans to convert manually
      isOccupied: (room['is_occupied'] == 1),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': roomId,
      'room_type_id': roomTypeId,
      'department_id': departmentId,
      'is_occupied': isOccupied ? 1 : 0,
    };
  }
}
