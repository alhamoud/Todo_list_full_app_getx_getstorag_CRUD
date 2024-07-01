import 'package:get/get.dart';
import 'package:getx_todo_list_complete_app/app/data/provider/task/provider.dart';
import 'package:getx_todo_list_complete_app/app/data/services/storagefolder/repository.dart';
import 'package:getx_todo_list_complete_app/app/modules/home/controller.dart';

class HomeBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => 
    HomeController(
      taskRepository: TaskRepository(
          taskProvider:TaskProvider())));
  }
}