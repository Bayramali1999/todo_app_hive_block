import 'package:hive/hive.dart';
import 'package:todo_app_hive_block/modal/user.dart';

class AuthenticationService {
  late Box<User> _users;

  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    _users = await Hive.openBox<User>('userBox');
  }

  Future<String?> authenticationUser(
      final String username, final String password) async {
    final success = _users.values.any((element) =>
        element.username == username && element.password == password);

    if (success) {
      // final user = _users.values.firstWhere((element) =>
      // element.username == username && element.password == password);
      return username;
    } else {
      return null;
    }
  }

  Future<UserCreationRules> createUser(
      final String username, final String password) async {
    final alreadyExist = _users.values.any(
        (element) => element.username.toLowerCase() == username.toLowerCase());

    if (alreadyExist) {
      return UserCreationRules.already_exists;
    }
    try {
      await _users.add(User(username, password));
      return UserCreationRules.success;
    } on Exception catch (e) {
      return UserCreationRules.failed;
    }
  }

// Future<void> logoutUser(final String username, final String password) async {
//   final user = _users.values.firstWhere((element) =>
//   element.username.toLowerCase() == username.toLowerCase() &&
//       element.password == password);
//
//   int index = user.key as int;
//   _users.put(index, User(username, password, false));
// }
}

enum UserCreationRules { success, failed, already_exists }
