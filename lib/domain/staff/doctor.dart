import 'staff.dart';

class Doctor extends Staff {
  final String _specialization;
  final String _licenseNumber;
  final String _qualification;

  Doctor({
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
    required String specialization,
    required String licenseNumber,
    required String qualification,
  }) : // Validation
       assert(
         specialization.trim().isNotEmpty,
         'Specialization cannot be empty',
       ),
       assert(
         licenseNumber.trim().isNotEmpty,
         'License Number cannot be empty',
       ),
       assert(qualification.trim().isNotEmpty, 'Qualification cannot be empty'),
       // Initialize fields
       _specialization = specialization,
       _licenseNumber = licenseNumber,
       _qualification = qualification,
       super(staffType: StaffType.doctor);

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
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
      specialization: map['specialization'] as String,
      licenseNumber: map['license_number'] as String,
      qualification: map['qualification'] as String,
    );
  }

  // Getter methods
  String get specialization => _specialization;
  String get licenseNumber => _licenseNumber;
  String get qualification => _qualification;
}
