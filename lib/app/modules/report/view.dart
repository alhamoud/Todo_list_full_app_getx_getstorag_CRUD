import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:getx_todo_list_complete_app/app/core/utils/extintions.dart';
import 'package:getx_todo_list_complete_app/app/modules/home/controller.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ReportPage extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
                  var createdTasks = homeCtrl.getTotaltask();
                  var completedTasks = homeCtrl.getTotalDoneTask();
                  var liveTask= createdTasks-completedTasks;
                  var percent = (completedTasks/createdTasks*100).toStringAsFixed(0);
                  return ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4.0.wp),
                        child: Text("My report",
                        style: TextStyle(
                          fontSize: 20.0.sp,
                          fontWeight: FontWeight.bold,
                        
                        ),),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                        child: Text(DateFormat.yMMMMd().format(DateTime.now()),
                        style: TextStyle(
                          fontSize: 14.0.sp,
                          color: Colors.grey,
                        ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.0.wp,
                          vertical: 3.0.wp,
                          
                        ),
                        child: Divider(thickness: 2,),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(
                          vertical: 3.0.wp,
                          horizontal: 5.0.wp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildStatus(Colors.green, liveTask, "Live Tasks"),
                            _buildStatus(Colors.orange, completedTasks, "Completed"),
                            _buildStatus(Colors.blue, createdTasks, "Created"),
                        
                          ],
                        ),
                      ),
                      SizedBox(height: 8.0.wp,),
                      UnconstrainedBox(
                        child: SizedBox(
                          height:70.0.wp,
                          width: 70.0.wp,
                          child:  CircularStepProgressIndicator(
                          totalSteps: createdTasks==0 ? 1 : createdTasks ,
                          currentStep: completedTasks,
                          stepSize: 10,
                          selectedColor: Colors.green,
                          unselectedColor: Colors.grey[200],
                          padding: 0,
                          width: 150,
                          height: 150,
                          selectedStepSize: 20,
                          roundedCap: (_,__)=>true,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${createdTasks == 0 ? 0 : percent } % ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0.sp,
                              ),),
                              
                              SizedBox(height: 4.0.wp,),

                              Text("Efficiency",
                              style: TextStyle(
                                color:Colors.grey,
                                fontSize: 12.0.sp,
                                fontWeight: FontWeight.bold,
                              ),),
                            ],
                          ),

                        ),),
                      ),
                    ],
                  );

        }
        )
      )
    );
  }
  
  Row _buildStatus(Color color, int number, String text) {
    return Row(
      children: [
        Container(
          height: 3.0.wp,
          width: 3.0.wp,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 0.5.wp,
              color: color,
            )
          ),
         ),
      SizedBox(width: 3.0.wp),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$number",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0.sp,
          ),),
          SizedBox(height: 2.0.wp),
          Text(text,
          style: TextStyle(
            fontSize: 12.0.sp,
            color: Colors.grey,
            
          ),)
        ],
      )
      ],);
  }
}