import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_todo_list_complete_app/app/core/utils/extintions.dart';
import 'package:getx_todo_list_complete_app/app/data/models/task.dart';
import 'package:getx_todo_list_complete_app/app/modules/details/view.dart';
import 'package:getx_todo_list_complete_app/app/modules/home/controller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class TaskCard extends StatelessWidget {
  final homCtrl=Get.find<HomeController>();
  final Task task;
  TaskCard({Key? key, required this.task}):super(key:key);

  @override
  Widget build(BuildContext context) {


    print("from task card");
          print(homCtrl.doingTodos);
          print(homCtrl.doneTodos);
    var color = HexColor.fromHex(task.color);
    var squareWidth = Get.width - 12.0.wp;
    return GestureDetector(
      onTap: (){
          
        homCtrl.changeTask(task);
        homCtrl.changTodos(task.todos ?? []); 
        
    print("from task card befor          Get.to(()=>DetailPAge());");
          print(homCtrl.doingTodos);
          print(homCtrl.doneTodos);
         Get.to(()=>DetailPAge());
           
      },
      child: Container(
        width: squareWidth/2,
        height: squareWidth/2,
        margin: EdgeInsets.all(3.0.wp),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 7,
              offset: Offset(0,7),
            )]
        ),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StepProgressIndicator(
                //TODO chane after finishe todo CRUD
               totalSteps: homCtrl.isTodosEmpty(task)? 1 : task.todos!.length,
               
                currentStep:homCtrl.isTodosEmpty(task)? 0 : homCtrl.getDoneTodo(task),
                 size: 5,
                padding: 0,
                selectedGradientColor: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color.withOpacity(0.5),color]
                  ),
                  unselectedGradientColor: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white,Colors.white]
                  ),
                ),
                
                Padding(
                  padding:  EdgeInsets.all(5.0.wp),
                  child: Icon(
                    IconData(task.icon,fontFamily: "MaterialIcons"),
                  color: color,),
                ),
                Padding(
                  padding:  EdgeInsets.all(5.0.wp),
                  child: Column(
                    children: [
                      Text(task.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0.sp,
                      ),
                      overflow: TextOverflow.ellipsis,),
                      
                      SizedBox(height: 2.0.wp),
                      
                      Text("${task.todos?.length ?? 0} task",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}