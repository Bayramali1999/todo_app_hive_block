import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  final String username;
  @HiveField(1)
  final String password;

  @HiveField(2)
  final bool login;

  User(this.username, this.password, this.login);
}
