import 'staff.dart';

class Administrator extends Staff {
  final String _username;
  final String _password;
  final String _department;
  final int _isLocked;
  final String? _lastLogin;

  Administrator({
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
    required String username,
    required String password,
    required String department,
  }) : // Validation
       assert(username.trim().isNotEmpty, 'Username cannot be empty'),
       assert(password.trim().isNotEmpty, 'Password cannot be empty'),
       assert(department.trim().isNotEmpty, 'Department cannot be empty'),
       _username = username,
       _password = password,
       _department = department,
       _isLocked = 0,
       _lastLogin = 'Never',
       super(staffType: StaffType.administrator);

  Administrator.fromDatabase({
    required int staffId,
    required String username,
    required String password,
    required String department,
    required int isLocked,
    String? lastLogin,
  }) : _username = username,
       _password = password,
       _department = department,
       _isLocked = isLocked,
       _lastLogin = lastLogin,
       super(
         id: staffId,
         firstName: '',
         lastName: '',
         dateOfBirth: DateTime.now(),
         gender: '',
         phone: '',
         hireDate: DateTime.now(),
         employmentStatus: '',
         shift: '',
         salary: 0.0,
         staffType: StaffType.administrator,
       );

  factory Administrator.fromMap(Map<String, dynamic> map) {
    return Administrator(
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
      username: map['username'] as String,
      password: map['password'] as String,
    );
  }

  // Getter methods
  String get username => _username;
  int get isLocked => _isLocked;
  String get password => _password;
  String get department => _department;
  String? get lastLogin => _lastLogin;
}
