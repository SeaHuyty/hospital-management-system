enum StaffType { doctor, nurse, security, cleaner, administrator }

// Base Staff class
class Staff {
  final int? _id;
  final String _firstName;
  final String _lastName;
  final DateTime _dateOfBirth;
  final String _gender;
  final String _phone;
  final String? _email;
  final String? _address;
  final String? _emergencyContactName;
  final String? _emergencyContactPhone;
  final DateTime _hireDate;
  final String _employmentStatus;
  final String _shift;
  final double _salary;
  final StaffType _staffType;
  final DateTime? _createdAt;
  final DateTime? _updatedAt;

  Staff({
    int? id,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    required String gender,
    required String phone,
    String? email,
    String? address,
    String? emergencyContactName,
    String? emergencyContactPhone,
    required DateTime hireDate,
    required String employmentStatus,
    required String shift,
    required double salary,
    required StaffType staffType,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : // Validation
       assert(firstName.trim().isNotEmpty, 'Firstname cannot be empty'),
       assert(lastName.trim().isNotEmpty, 'Lastname cannot be empty'),
       assert(phone.trim().isNotEmpty, 'Phone cannot be empty'),
       assert(salary > 0, 'Salary must be positive'),
       assert(
         dateOfBirth.isBefore(DateTime.now()),
         'Date of birth cannot be in the future',
       ),
       assert(
         hireDate.isBefore(DateTime.now().add(Duration(days: 1))),
         'Hire date cannot be in the future',
       ),
       assert(shift.trim().isNotEmpty, 'Shift cannot be empty'),
       assert(employmentStatus.trim().isNotEmpty, 'Employment cannot be empty'),
       // Initialize fields
       _id = id,
       _firstName = firstName,
       _lastName = lastName,
       _dateOfBirth = dateOfBirth,
       _gender = gender,
       _phone = phone,
       _email = email,
       _address = address,
       _emergencyContactName = emergencyContactName,
       _emergencyContactPhone = emergencyContactPhone,
       _hireDate = hireDate,
       _employmentStatus = employmentStatus,
       _shift = shift,
       _salary = salary,
       _staffType = staffType,
       _createdAt = createdAt,
       _updatedAt = updatedAt;

  factory Staff.fromMap(Map<String, dynamic> map) {
    // Helper to parse dates stored as ISO strings
    DateTime parseDate(dynamic date) {
      if (date == null) throw FormatException('Missing date field');
      return DateTime.parse(date as String);
    }

    return Staff(
      id: map['id'] as int?,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      dateOfBirth: parseDate(map['date_of_birth']),
      gender: map['gender'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String?,
      address: map['address'] as String?,
      emergencyContactName: map['emergency_contact_name'] as String?,
      emergencyContactPhone: map['emergency_contact_phone'] as String?,
      hireDate: parseDate(map['hire_date']),
      employmentStatus: map['employment_status'] as String,
      shift: map['shift'] as String,
      salary: map['salary'] as double,
      staffType: StaffType.values.firstWhere(
        (e) => e.toString().split('.').last == map['staff_type'],
      ),
      createdAt: parseDate(map['created_at']),
      updatedAt: parseDate(map['updated_at']),
    );
  }

  // Getter methods
  int? get id => _id;
  String get firstName => _firstName;
  String get lastName => _lastName;
  DateTime get dateOfBirth => _dateOfBirth;
  String get gender => _gender;
  String get phone => _phone;
  String? get email => _email;
  String? get address => _address;
  String? get emergencyContactName => _emergencyContactName;
  String? get emergencyContactPhone => _emergencyContactPhone;
  DateTime get hireDate => _hireDate;
  String get employmentStatus => _employmentStatus;
  String get shift => _shift;
  double get salary => _salary;
  StaffType get staffType => _staffType;
  DateTime? get createdAt => _createdAt;
  DateTime? get updatedAt => _updatedAt;
}
