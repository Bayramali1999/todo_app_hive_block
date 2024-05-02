import 'package:hive/hive.dart';
import 'package:todo_app_hive_block/modal/task.dart';

class TodoService {
  late Box<Task> _tasks;

  Future<void> init() async {
    Hive.registerAdapter(TaskAdapter());
    _tasks = await Hive.openBox<Task>('tasks');
  }

  List<Task> getTasks(final String username) {
    final task = _tasks.values.where((element) => element.username == username);
    return task.toList();
  }

  void addTask(final String task, final String username) {
    _tasks.add(Task(username, task, false));
  }

  Future<void> removeTask(final String task, final String username) async {
    final _task = _tasks.values.firstWhere(
        (element) => element.task == task && element.username == username);
    await _task.delete();
  }

  Future<void> updateTask(final String task, final String username,
      {bool? completed}) async {
    final taskEdit = _tasks.values.firstWhere(
        (element) => element.username == username && element.task == task);
    final index = taskEdit.key as int;
    await _tasks.put(index, Task(username, task, !taskEdit.completed));
  }
}
