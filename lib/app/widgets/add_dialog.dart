import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_todo_list_complete_app/app/core/utils/extintions.dart';
import 'package:getx_todo_list_complete_app/app/modules/home/controller.dart';

class AddDialog extends StatelessWidget {
  final homCtrl = Get.find<HomeController>();

    AddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
       child: Scaffold(
          body: Form(
        key: homCtrl.formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                        homCtrl.editController.clear();
                        homCtrl.changeTask(null);
                      },
                      icon: const Icon(Icons.close)),
                  TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                            Colors.transparent), //stop the default slash effect
                      ),
                      onPressed: () {
                                if(homCtrl.formKey.currentState!.validate()){
                                  if(homCtrl.task.value== null){
                                      EasyLoading.showError("Please Enter Task type");
                                  }else{
                                    var success= homCtrl.updateTask(
                                      homCtrl.task.value!,
                                      homCtrl.editController.text);
                                    if (success){
                                      EasyLoading.showSuccess("Todo Item add success");
                                      Get.back();
                                      homCtrl.changeTask(null);
                                    }else{
                                      EasyLoading.showError("Todo item already in List");
                                    }
                                    homCtrl.editController.clear();
                                  }
                                }
      
                      },
                      child: Text(
                        "Done",
                        style: TextStyle(
                          fontSize: 14.0.sp,
                        ),)
                      ),])),
      
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                    child: Text(
                      "New Task",
                      style: TextStyle(
                        fontSize: 20.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                      child: TextFormField(
                        autofocus: true,
                        controller: homCtrl.editController,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[400]!),
                          ),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 5.0.wp,
                      left: 5.0.wp,
                      right: 5.0.wp,
                      bottom: 2.0.wp,
                    ),
                    child: Text(
                      "Add_to",
                      style: TextStyle(
                        fontSize: 14.0.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  ...homCtrl.tasks
                      .map((element) => Obx(
                      ()=>InkWell(
                          onTap: ()=> homCtrl.changeTask(element),
                          child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 3.0.wp, horizontal: 5.0.wp),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                         Icon(
                                      IconData(
                                        element.icon,
                                        fontFamily: "MaterialIcons",
                                      ),
                                      color: HexColor.fromHex(element.color),
                                    ),
                                    SizedBox(
                                      width: 3.0.wp,
                                    ),
                                    Text(
                                      element.title,
                                      style: TextStyle(
                                        fontSize: 12.0.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                      ],
                                    )
                                   ,
                                    if(homCtrl.task.value == element)
                                    const Icon(Icons.check,color:Colors.blue ,) 
                                  ],
                                ),
                              ),
                        ),
                      ))
                      .toList(),
                ],
              ),
            ),
          
        ),
    );
     
  }
}
