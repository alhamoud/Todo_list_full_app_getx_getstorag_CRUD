import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_todo_list_complete_app/app/core/utils/extintions.dart';
import 'package:getx_todo_list_complete_app/app/modules/home/controller.dart';
import 'package:getx_todo_list_complete_app/app/widgets/doing_list.dart';
import 'package:getx_todo_list_complete_app/app/widgets/done_List.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class DetailPAge extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  DetailPAge({super.key});

  @override
  Widget build(BuildContext context) {
     print("test  from detail page");
    print(homeCtrl.doingTodos);
    print(homeCtrl.doneTodos);

    var task = homeCtrl.task.value!;
    var color = HexColor.fromHex(task.color);
    return PopScope(
      canPop: false,
      child: Scaffold(
          body: Form(
            key: homeCtrl.formKey,
            child: ListView(
                  children: [
            Padding(
              padding:   EdgeInsets.all( 3.0.wp),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                       homeCtrl.updateTodos();
                        homeCtrl.changeTask(null);
                      homeCtrl.editController.clear();
                       Get.back();
                        print("after  Get.back(); from detail page");
    print(homeCtrl.doingTodos);
    print(homeCtrl.doneTodos);


                    },
                    icon: Icon(Icons.arrow_back),
                  ),          
                ],
               ),
            ),
             Padding(
                     padding:   EdgeInsets.symmetric(horizontal: 8.0.wp),
                     child: Row(
                      children: [
                        Icon(
                          IconData(task.icon, fontFamily: "MaterialIcons"),
                          color: color,
                        ),
                        SizedBox(width:3.0.wp),
                        Text(task.title,
                        style: TextStyle(
                          fontSize: 12.0.sp, 
                          fontWeight: FontWeight.bold               ),)
                      ],
                                   ),
                   ),
                   Obx((){
                     var totalTodos= homeCtrl.doneTodos.length +  homeCtrl.doingTodos.length;
                    return Padding(
                      padding: EdgeInsets.only(
                        left:16.0.wp,
                        top:3.0.wp,
                        right:16.0.wp),
                      child: Row(
                        children: [
                          Text("$totalTodos Tasks",
                          style: TextStyle(
                            fontSize: 12.0.sp,
                            color: Colors.grey,
                          ),
                      
                          ),
                          SizedBox(width:3.0.wp),
                          Expanded(
                            child: StepProgressIndicator(
                              totalSteps: totalTodos == 0 ? 1 : totalTodos,
                              currentStep: homeCtrl.doneTodos.length ,
                              size: 5,
                              padding: 0,
                              selectedGradientColor: LinearGradient(
                                begin:Alignment.topLeft,
                                end:Alignment.bottomRight ,
                                colors: [color.withOpacity(0.5),color]),
                              unselectedGradientColor: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomLeft,
                                colors: [const Color.fromARGB(255, 98, 74, 74)!,Colors.grey[300]!],
                                ) ,)
                              )
                          
                        ],
                      ),
                    );
                   }),
                   Padding(
                     padding:  EdgeInsets.symmetric(
                      vertical: 2.0.wp,
                      horizontal: 5.0.wp ,),
                     child: TextFormField(
                      controller: homeCtrl.editController,
                      autofocus: true,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey[400]!,
                          )
                        ),
                        prefixIcon: Icon(Icons.check_box_outline_blank,
                        color: Colors.grey[400],),
                        suffixIcon: IconButton(
                          onPressed: (){
                            if(homeCtrl.formKey.currentState!.validate()){
                                var  success = 
                                homeCtrl.addTodo(homeCtrl.editController.text);
                                if(success){
                                  EasyLoading.showSuccess("Todo Item add successfuly");
                                }else{
                                  EasyLoading.showError("Todo Item allready exist");
                                }
                                homeCtrl.editController.clear();
                            }
                          },
                           icon: Icon(Icons.done),),
                      ),
                      validator:(value){
                        if(value ==null || value.trim().isEmpty){
                          return "Please enter your todo item";
                        }
                        return null;
                      } ,
                     ),
                   ),
      
                   DoingList(), 
                   DoneList(),
      
                   
            
            
                  ],
                ),
          )),
    );
  }
}
