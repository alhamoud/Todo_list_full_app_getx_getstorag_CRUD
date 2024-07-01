import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_list_complete_app/app/core/utils/extintions.dart';
import 'package:getx_todo_list_complete_app/app/modules/home/controller.dart';

class DoingList extends StatelessWidget {
  DoingList({super.key});
  final homeCtrl= Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
     () => homeCtrl.doingTodos.isEmpty && 
            homeCtrl.doneTodos.isEmpty
            ? Column(
              children: [
                
                Image.asset("assets/images/task.jpg",
                
                fit: BoxFit.cover,
                width: 20.0.wp,),
                Text( "Add Task" ,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0.sp,
                ),
                )
              ],
            )
            :  ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                ...homeCtrl.doingTodos
                .map((element) => 
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 3.0.wp,
                    horizontal: 9.0.hp),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Checkbox(
                          fillColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.grey[300]),
                          value: element["done"],
                           onChanged: (value ){
                            homeCtrl.DoneTodo(element['title']);
                  
                           }),
                      ),
                  
                      Padding(
                        padding:   EdgeInsets.symmetric(
                          horizontal: 4.0.wp),
                        child: Text(element["title"],
                        overflow: TextOverflow.ellipsis,
                        ),
                      )
                          
                  
                    ],
                  ),
                ))
                .toList(),
                if(homeCtrl.doingTodos.isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.0.wp),
                  child: const Divider(
                    thickness: 2,
                  ),
                ),
               


              ],
            ),
            
    );
  }
}