import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_todo_list_complete_app/app/data/models/task.dart';
import 'package:getx_todo_list_complete_app/app/data/services/storagefolder/repository.dart';

class HomeController extends GetxController{
 
 TaskRepository taskRepository;
  HomeController({required this.taskRepository });
  final formKey = GlobalKey<FormState>();
  final editController=TextEditingController();
  final chipIndex=0.obs;
  final deleting=false.obs;
  final tasks = <Task>[].obs;
  final task = Rx<Task?>(null);
  final doingTodos= <dynamic>[].obs;
  final doneTodos= <dynamic>[].obs;
  final tapindex=0.obs;
  
  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }


  @override
  void onClose() {
    editController.dispose();
    super.onClose();
  }

  void changeChipIndex(int value){//this function to reset or clear the value
    chipIndex.value=value;
  }
  void changeDeleting(bool value){
      deleting.value=value;
  }
  
  void changeTask(Task? selected){
    task.value=selected;
  }

  void changTodos(List<dynamic> selected){
      print("from heart of function change todo");
      print("doing");
      print(doingTodos);
      print("doneTodos");
      print(doneTodos);
    doingTodos.clear();
    doneTodos.clear();
    for(int i=0 ; i < selected.length ; i++){
      var todo = selected[i];
      var status = todo['done'];
      if(status==true){
        doneTodos.add(todo);       
      }else{
        doingTodos.add(todo);}
    }

  }

  bool addTask(Task task){
    if(tasks.contains(task)){
      return false;
    }
    tasks.add(task);
    return true;
  }
  
  void deleteTask(Task task){
    tasks.remove(task);
  }

  updateTask(Task task , String title){
      var todos = task.todos ?? [] ;
      if(ContainTodo(todos,title)){
        return false;
      }
      var todo={"title": title, "done":false};
      todos.add(todo);
      var newTask=task.copyWith(todos: todos);
      int oldIndx= tasks.indexOf(task);
      tasks[oldIndx]=newTask;
      tasks.refresh();
      return true;


  }
  bool ContainTodo(List todos , String title){
      return todos.any((element) => element['title']==title);
  }

  bool addTodo(String title){
      var todo = {"title": title,"done":false};
      if( doingTodos.any((element) => mapEquals<String, dynamic>(todo, element))){
        return false;
      } 
        var donetodo = {"title": title,"done":true};
        if(doneTodos.any((element) => mapEquals<String, dynamic>(donetodo, element))){
          return false;
        }
        doingTodos.add(todo);
         
        return true;
       
  }

  void updateTodos(){
      var newtodos= < Map<String, dynamic>>[];
      newtodos.addAll([
        ...doingTodos,
        ...doneTodos,
      ]);        

      var newtask= task.value!.copyWith(todos: newtodos);
      int oldindex= tasks.indexOf(task.value);
      tasks[oldindex]= newtask;
      tasks.refresh();
       }

  void DoneTodo(String title) {
    var doingTode={"title": title , "done": false};
    int Index =  doingTodos.indexWhere((element) => mapEquals<String, dynamic>(doingTode, element));
    doingTodos.removeAt(Index);
    
    var doneTode={"title": title , "done": true};
    doneTodos.add(doneTode);
    doingTodos.refresh();
    doneTodos.refresh();}

  void deletDoneTodo(dynamic donetodo) {

    int index= doneTodos.indexWhere((element) => 
    mapEquals<String, dynamic>(donetodo, element));
    doneTodos.removeAt(index);
    doneTodos.refresh();
  }

  bool isTodosEmpty(Task task){
    return task.todos == null || task.todos!.isEmpty ;
  
  }

  int getDoneTodo(Task task){
    var res=0;
    for(int i =0; i<task.todos!.length;i++){
      if(task.todos![i]['done'] == true){
        res+=1;
      }
    }
    return res;
  }


  void ChangeTapIndex(int index){
    tapindex.value=index;

  }
 int getTotaltask(){
    var res =0;
    for (int i=0;i<tasks.length;i++){
      if(tasks[i].todos !=null){
        res += tasks[i].todos!.length;
      }
    }
      return res;
 }
 
 int getTotalDoneTask(){
  var res =0 ;
  for(int i =0; i< tasks.length;i++){
    if(tasks[i].todos !=null){
      for(int j=0; j<tasks[i].todos!.length;j++){
          if(tasks[i].todos![j]['done']==true){
            res +=1;
          }
      }
    }
  }
  return res;
}

}

/*another version of  void   {

void doneTodo(String title) {
  // Find the todo item by title
  var todo = doingTodos.firstWhere(
    (element) => element['title'] == title,
    orElse: () => null,
  );
  // If the todo item is found and its 'done' status is false
  if (todo != null && todo['done'] == false) {
    doingTodos.remove(todo);    
    todo['done'] = true;
    doneTodos.add(todo);
    doingTodos.refresh();
    doneTodos.refresh();
  }
}
 */