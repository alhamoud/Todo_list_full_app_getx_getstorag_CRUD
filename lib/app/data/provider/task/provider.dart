import 'dart:convert';

import 'package:get/get.dart';
import 'package:getx_todo_list_complete_app/app/core/utils/keys.dart';
import 'package:getx_todo_list_complete_app/app/data/models/task.dart';
import 'package:getx_todo_list_complete_app/app/data/services/storagefolder/services.dart';

class TaskProvider {
  
final StorageService _storage = Get.find<StorageService>();



/*format we store in database
{'tasks':[
  {'title':'Work',
    'color':"#ff123456",
    'icon':0xe123},]
    };
*/

List<Task> readTasks(){
  var tasks=<Task>[];
  jsonDecode(_storage.read(taskKey).toString())
        .forEach((e)=>
          tasks.add(Task.fromJson(e)));
  
  return tasks;
}

void writeTasks(List<Task> tasks){
  _storage.write(taskKey, jsonEncode(tasks));

}



/**
 *  void writeTasks(List<Task> tasks) {
    // Convert each Task object to a JSON-encodable map
    List<Map<String, dynamic>> taskMaps = tasks.map((task) => task.toJson()).toList();
    _storage.write(taskKey, jsonEncode(taskMaps));
  }
 */

}