import 'package:hive/hive.dart';
import 'package:todo_app_hive_block/modal/user.dart';

class AuthenticationService {
  late Box<User> _users;

  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    _users = await Hive.openBox<User>('userBox');
  }

  Future<UserCreationRules> logout(final String username) async {
    final user = _users.values.firstWhere(
        (element) => element.username == username,
        orElse: () => User('', '', false));
    if (user.login) {
      print('${user.username} logout');
      int key = user.key;
      await _users.put(key, User(user.username, user.password, false));
      return UserCreationRules.success;
    } else {
      return UserCreationRules.failed;
    }
  }

  Future<String?> initialScreenDetector() async {
    final user = _users.values.firstWhere((element) => element.login,
        orElse: () => User('', '', false));

    if (!user.login) {
      return null;
    } else {
      print('login ${user.username}');
      return user.username;
    }
  }

  Future<String?> authenticationUser(
      final String username, final String password) async {
    final success = _users.values.firstWhere(
        (element) =>
            element.username == username && element.password == password,
        orElse: () => User('', '', false));

    if (success.username == '' && password == '') {
      return null;
    } else {
      int key = success.key;
      await _users.put(key, User(username, password, true));
      return username;
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
      await _users.add(User(username, password, true));
      return UserCreationRules.success;
    } on Exception catch (e) {
      return UserCreationRules.failed;
    }
  }
}

enum UserCreationRules { success, failed, already_exists }
