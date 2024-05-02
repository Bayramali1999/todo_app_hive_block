import 'package:hive/hive.dart';
part 'task.g.dart';
@HiveType(typeId: 2)
class Task extends HiveObject {
  @HiveField(0)
  final String username;
  @HiveField(1)
  final String task;
  @HiveField(2)
  final bool completed;

  Task(this.username, this.task, this.completed);
}
