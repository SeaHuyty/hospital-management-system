import 'package:hospital_management_system/data/controllers/room_type_controller.dart';
import 'package:hospital_management_system/domain/hospital_room.dart';

Future<void> seedRoomTypes() async {
  RoomTypeController roomTypeController = RoomTypeController();

  final roomTypes = [
    RoomType(name: 'Shared', price: 10.0, description: 'Shared room with multiple beds'),
    RoomType(name: 'Private', price: 20.0, description: 'Private room for one patient and family'),
    RoomType(name: 'VIP', price: 50.0, description: 'Luxury private room with premium service'),
  ];

  for (var rt in roomTypes) {
    await roomTypeController.insertRoomType(rt);
  }

  print('Room types seeded successfully!');
}