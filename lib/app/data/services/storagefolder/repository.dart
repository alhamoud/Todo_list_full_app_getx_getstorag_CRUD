
import 'package:getx_todo_list_complete_app/app/data/models/task.dart';
import 'package:getx_todo_list_complete_app/app/data/provider/task/provider.dart';

class TaskRepository{

TaskProvider taskProvider;

TaskRepository({required this.taskProvider});

List<Task> readTasks()=> taskProvider.readTasks();

void writeTasks(List<Task> tasks) => taskProvider.writeTasks(tasks);
}