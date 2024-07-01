import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_todo_list_complete_app/app/core/utils/extintions.dart';
import 'package:getx_todo_list_complete_app/app/core/values/colors.dart';
import 'package:getx_todo_list_complete_app/app/data/models/task.dart';
import 'package:getx_todo_list_complete_app/app/modules/home/controller.dart';
import 'package:getx_todo_list_complete_app/app/modules/home/widgets/icons.dart';

class AddCard extends StatelessWidget {
  final homCtrl = Get.find<HomeController>();
  AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    final icons = getIcon();
    var squareWidth = Get.width - 12.0.wp;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
          onTap: () async {
            await Get.defaultDialog(
              backgroundColor: Colors.white,
              titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
              radius: 5,
              title: "Task Type",
              content: Form(
                  key: homCtrl.formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                        child: TextFormField(
                          controller: homCtrl.editController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Title",
                          ),
                          validator: (Value) {
                            if (Value == null || Value.trim().isEmpty) {
                              return "Please enter your task title";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 5.0.wp,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0.wp),
                        child: Wrap(
                          spacing: 1.0.wp,
                          runSpacing: 1.0.wp,
                          children: icons
                              .map((e) => Obx(() {
                                    final index = icons.indexOf(e);
                                    return ChoiceChip(
                                      avatar: null,
                                      side: BorderSide(
                                        color: Colors.white,
                                      ),
                                      elevation: 5,
                                      pressElevation: 0,
                                      selectedColor: Colors.grey[200],
                                      backgroundColor: Colors.white,
                                      label: e,
                                      selected:
                                          homCtrl.chipIndex.value == index,
                                      onSelected: (bool selected) {
                                        homCtrl.chipIndex.value =
                                            selected ? index : 0;
                                      },
                                    );
                                  }))
                              .toList(),
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              minimumSize: Size(150, 40)),
                          onPressed: () {
                            if (homCtrl.formKey.currentState!.validate()) {
                              int icon = icons[homCtrl.chipIndex.value]
                                  .icon!
                                  .codePoint;
                              String color =
                                  icons[homCtrl.chipIndex.value].color!.toHex();

                              var task = Task(
                                  title: homCtrl.editController.text,
                                  color: color,
                                  icon: icon);

                              Get.back();
                              homCtrl.addTask(task)
                                  ? EasyLoading.showSuccess("Creat sucess")
                                  : EasyLoading.showError("Duplicated Task");
                            }
                          },
                          child: Text(
                            "Confirm",
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  )),
            );
            homCtrl.editController.clear();
            homCtrl.changeChipIndex(0);
          },
          child: DottedBorder(
              color: Colors.grey[400]!,
              dashPattern: const [8, 4],
              child: Center(
                  child: Icon(
                Icons.add,
                size: 10.0.wp,
                color: Colors.grey,
              )))),
    );
  }
}
