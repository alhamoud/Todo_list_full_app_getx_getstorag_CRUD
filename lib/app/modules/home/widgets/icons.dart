import 'package:flutter/material.dart';
import 'package:getx_todo_list_complete_app/app/core/values/colors.dart';
import 'package:getx_todo_list_complete_app/app/core/values/icons.dart';

List<Icon> getIcon(){
return const[

  Icon(IconData(personIcon,fontFamily: "MaterialIcons"),color: purple,),
  Icon(IconData(workIcon,fontFamily: "MaterialIcons"),color: pink,),
  Icon(IconData(movieIcon,fontFamily: "MaterialIcons"),color: green,),
  Icon(IconData(sportIcon,fontFamily: "MaterialIcons"),color: yellow,),
  Icon(IconData(travelIcon,fontFamily: "MaterialIcons"),color: deepPink,),
  Icon(IconData(sportIcon,fontFamily: "MaterialIcons"),color: lightBlue,),
  
];
}