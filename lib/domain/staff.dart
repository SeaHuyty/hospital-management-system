enum StaffType { doctor, nurse, security, cleaner, administrator }
enum EmploymentStatus {
  active('active'),
  leave('leave'),
  terminated('terminated');

  const EmploymentStatus(this.status);
  final String status;
}

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
  }) : _id = id,
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

  void printDetails() {
    print('Staff ID: $_id');
    print('Name: $_firstName $_lastName');
    print('DOB: $_dateOfBirth');
    print('Gender: $_gender');
    print('Phone: $_phone');
    (_email == null) ? {print('Email: Blank')} : {'Email: $_email'};
    (_address == null) ? {print('Address: Blank')} : {print('Address: $_address')};
    (_emergencyContactName == null && _emergencyContactPhone == null) ?
      print('Emergency Contact: Blank') : print('Emergency Contact: $_emergencyContactName - $_emergencyContactPhone');
    print('Hire Date: $_hireDate');
    print('Employment Status: $_employmentStatus');
    print('Shift: $_shift');
    print('Salary: $_salary');
    print('Staff Type: $_staffType');
    print('Created At: $_createdAt');
    print('Updated At: $_updatedAt');
  }
}

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
    required String qualification
  }) :  _specialization = specialization,
        _licenseNumber = licenseNumber,
        _qualification = qualification,
        super(staffType: StaffType.doctor);

  Doctor.fromDatabase({
    required String specialization,
    required String licenseNumber,
    required String qualification,
    required int staffId
  }) : _specialization = specialization,
       _licenseNumber = licenseNumber,
       _qualification = qualification,
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
        staffType: StaffType.doctor
       );

  @override
  void printDetails() {
    print('Staff ID: $_id');
    print('Specialization: $_specialization');
    print('License Number: $_licenseNumber');
    print('Qualification: $_qualification');
  }
}

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
    required String certification
  }) : _department = department,
       _certification = certification,
       super(staffType: StaffType.nurse);

  Nurse.fromDatabase({
    required String department,
    required String certification,
    required int staffId
  }) : _department = department,
       _certification = certification,
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
        staffType: StaffType.nurse
       );

  @override
  void printDetails() {
    print('Staff ID: $_id');
    print('Department: $_department');
    print('Certification: $_certification');
  }
}

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
    required String assignedArea
  }) : _title = title,
       _assignedArea = assignedArea,
       super(staffType: StaffType.security);

  Security.fromDatabase({
    required String title,
    required String assignedArea,
    required int staffId,
  }) : _title = title,
       _assignedArea = assignedArea,
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
        staffType: StaffType.security
       );
  
  @override
  void printDetails() {
    print('Staff ID: $_id');
    print('Title: $_title');
    print('Assigned Area: $_assignedArea');
  }
}

class Cleaner extends Staff {
  final String _title;
  final String _assignedDepartment;
  final String _assignedArea;

  Cleaner({
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
    required String assignedDepartment,
    required String assignedArea
  }) : _title = title,
       _assignedArea = assignedArea,
       _assignedDepartment = assignedDepartment,
       super(staffType: StaffType.cleaner);

  Cleaner.fromDatabase({
    required int staffId,
    required String title,
    required String assignedArea,
    required String assignedDepartment,
  }) : _title = title,
       _assignedArea = assignedArea,
       _assignedDepartment = assignedDepartment,
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
        staffType: StaffType.cleaner
       );

  @override
  void printDetails() {
    print('Staff ID: ');
    print('Title: $_title');
    print('Assigned Department: $_assignedDepartment');
    print('Title: $_assignedArea');
  }
}

class Administrator extends Staff {
  final String _username;
  final String _password;
  final String _department;

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
    required String department
  }) : _username = username,
       _password = password,
       _department = department,
       super(staffType: StaffType.administrator);

  Administrator.fromDatabase({
    required int staffId,
    required String username,
    required String password,
    required String department
  }) : _username = username,
       _password = password,
       _department = department,
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
        staffType: StaffType.administrator
       );

  @override
  void printDetails() {
    print('Staff ID: $_id');
    print('Username: $_username');
    print('Password: $_password');
    print('Department: $_department');
  }
}