import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_list_complete_app/app/data/services/storagefolder/services.dart';
import 'package:getx_todo_list_complete_app/app/modules/home/binding.dart';
import 'package:getx_todo_list_complete_app/app/modules/home/view.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';




main() async {
  await GetStorage.init();
  await Get.putAsync (()=> StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      title: 'Todo List Using Getx',
      debugShowCheckedModeBanner: false,
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),
      home: const HomePage(),
    );
  }
}
