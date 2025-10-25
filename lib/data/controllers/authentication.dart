import 'package:hospital_management_system/data/config/database.dart';
import 'package:hospital_management_system/domain/staff.dart';

class AuthenticationController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<Administrator?> getAdministratorByUsername(String username) async {
    try {
      final db = await _dbHelper.database;

      final result = db.select(
        '''
        SELECT *
        FROM administrators
        WHERE username = ?
        ''', 
        [username]
      );

      if (result.isEmpty) return null;

      final row = result.first;

      return Administrator.fromDatabase(
        staffId: row['staff_id'] is int ? row['staff_id'] as int : (int.tryParse(row['staff_id']?.toString() ?? '') ?? 0),
        username: row['username'].toString(),
        password: row['password'].toString(),
        department: row['department'].toString(),
        isLocked: row['is_locked'] is int ? row['is_locked'] as int : (int.tryParse(row['is_locked']?.toString() ?? '') ?? 0),
      );
    } catch (error) {
      print('Error fetching administrator: $error');
      return null;
    }
  }

  Future<Administrator?> authenticateAdmin(String username, String password) async {
    final admin = await getAdministratorByUsername(username);

    if (admin == null) return null;

    if (admin.isLocked == 1) {
      print('Account is locked.');
      return null;
    }

    // Verify password
    if (admin.password == password) {
      await _updateLastLogin(admin.id!);
      return admin;
    }

    return null;
  }

  Future<void> _updateLastLogin(int administratorId) async {
    final db = await _dbHelper.database;

    db.execute('''
      UPDATE administrators
      SET last_login = ?
      WHERE staff_id = ?
    ''', [DateTime.now().toIso8601String(), administratorId]);
  }
}