import 'package:hospital_management_system/data/controllers/room_controller.dart';
import 'package:hospital_management_system/domain/hospital_room.dart';

Future<void> seedRooms() async {
  RoomController roomController = RoomController();

  final rooms = [
      Room(
        roomTypeId: 1,           
        capacity: 3,
        departmentId: 1,        
        isOccupied: false,
      ),
      Room(
        roomTypeId: 1,
        capacity: 3,
        departmentId: 2,        
        isOccupied: false,
      ),
      Room(
        roomTypeId: 2,           
        capacity: 1,
        departmentId: 3,        
        isOccupied: false,
      ),
      Room(
        roomTypeId: 2,         
        capacity: 1,
        departmentId: 4,        
        isOccupied: false,
      ),
      Room(
        roomTypeId: 3,          
        capacity: 1,
        departmentId: 5,     
        isOccupied: false,
      ),
    ];

    for (var room in rooms) {
      await roomController.insertRoom(room);
    }

    print('Rooms seeded successfully!');
}