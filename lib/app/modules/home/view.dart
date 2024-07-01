import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_todo_list_complete_app/app/core/utils/extintions.dart';
import 'package:getx_todo_list_complete_app/app/data/models/task.dart';
import 'package:getx_todo_list_complete_app/app/modules/home/controller.dart';
import 'package:getx_todo_list_complete_app/app/modules/report/view.dart';
import 'package:getx_todo_list_complete_app/app/widgets/add_card.dart';
import 'package:getx_todo_list_complete_app/app/widgets/add_dialog.dart';
import 'package:getx_todo_list_complete_app/app/widgets/task_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        ()=> IndexedStack(
          index: controller.tapindex.value,
        
          children: [ SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(4.0.wp),
                  child: Text(
                    "MY LIST",
                    style: TextStyle(
                      fontSize: 12.0.sp, // 24.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      children: [
                        /* ... spreadout 
                         the spread operator (...) is used to include all elements of
                         a collection (like a list) into another collection.*/
            
                        ...controller.tasks
                            .map((element) => Draggable<Task>(
                                  data: element,
                                  onDragStarted: () =>
                                      controller.changeDeleting(true),
                                  onDragEnd: (_) =>
                                      controller.changeDeleting(false),
                                  onDraggableCanceled: (_, __) =>
                                      controller.changeDeleting(false),
                                  feedback: Opacity(
                                    opacity: 0.8,
                                    child: TaskCard(task: element),
                                  ),
                                  child: TaskCard(task: element),
                                ))
                            .toList(),
                        AddCard(), 
                        // Example of another widget you might include
                        // Add more widgets here if needed
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          ReportPage(),
          ],
        ),
      ),
      floatingActionButton: DragTarget<Task>(
        onAcceptWithDetails: (details) {
          Task task = details.data;
          controller.deleteTask(task);
          EasyLoading.showSuccess("Delete Success");
        },
        builder: (_, __, ___) => Obx(
          () => FloatingActionButton(
            onPressed: () {
              if(controller.tasks.isNotEmpty){
                 Get.to(() => AddDialog(), transition: Transition.downToUp);
             }else{
               EasyLoading.showInfo("PleaseCreat your task type");

              }
            },
            backgroundColor:
                controller.deleting.value ? Colors.red : Colors.blue,
            child: Icon(
              controller.deleting.value ? Icons.delete : Icons.add,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Obx(
          ()=> BottomNavigationBar(
            onTap: (int index){
              controller.ChangeTapIndex(index);
          
            },
            currentIndex: controller.tapindex.value,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
                BottomNavigationBarItem(
                label: "Home",
                icon:   Padding(
                  padding: EdgeInsets.only(right:15.0.wp),
                  child: Icon(Icons.apps),
                ),
                ),
                 BottomNavigationBarItem(
                label: "Report",
                icon:   Padding(
                  padding: EdgeInsets.only(left:15.0.wp),
                  child: Icon(Icons.data_usage),
                ),
                )
            ],
           ),
        ),
      ),
    );
  }
}
