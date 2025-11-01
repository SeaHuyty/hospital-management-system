import 'staff.dart';

class Nurse extends Staff {
  final String _department;
  final String _certification;

  Nurse({
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
    required String department,
    required String certification,
  }) : // Validation
       assert(department.trim().isNotEmpty, 'Department cannot be empty'),
       assert(certification.trim().isNotEmpty, 'Certification cannot be empty'),
       _department = department,
       _certification = certification,
       super(staffType: StaffType.nurse);

  factory Nurse.fromMap(Map<String, dynamic> map) {
    return Nurse(
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
      department: map['department'] as String,
      certification: map['certification'] as String,
    );
  }

  // Getter methods
  String get department => _department;
  String get certification => _certification;
}
