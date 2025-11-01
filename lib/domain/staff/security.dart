import 'staff.dart';

class Security extends Staff {
  final String _title;
  final String _assignedArea;

  Security({
    super.id,
    required super.firstName,
    required super.lastName,
    required super.dateOfBirth,
    required super.gender,
    required super.phone,
    super.email,
    super.address,
    super.emergencyContactName,
    super.emergencyContactPhone,
    required super.hireDate,
    required super.employmentStatus,
    required super.shift,
    required super.salary,
    super.createdAt,
    super.updatedAt,
    required String title,
    required String assignedArea,
  }) : // Validation
       assert(title.trim().isNotEmpty, 'Title cannot be empty'),
       assert(assignedArea.trim().isNotEmpty, 'Assign Area cannot be empty'),
       _title = title,
       _assignedArea = assignedArea,
       super(staffType: StaffType.security);

  factory Security.fromMap(Map<String, dynamic> map) {
    return Security(
      id: map['id'] as int?,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      dateOfBirth: DateTime.parse(map['date_of_birth'] as String),
      gender: map['gender'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String?,
      address: map['address'] as String?,
      emergencyContactName: map['emergency_contact_name'] as String?,
      emergencyContactPhone: map['emergency_contact_phone'] as String?,
      hireDate: DateTime.parse(map['hire_date'] as String),
      employmentStatus: map['employment_status'] as String,
      shift: map['shift'] as String,
      salary: map['salary'] as double,
      title: map['title'] as String,
      assignedArea: map['assigned_area'] as String,
    );
  }

  // Getter methods
  String get title => _title;
  String get assignedArea => _assignedArea;
}
