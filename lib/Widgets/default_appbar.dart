import 'package:m_power/Theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar DefaultAppbar ({String title='',bool returnData=false,Widget? action,Color? color,PreferredSizeWidget? bottom,bool centerTitle=true}){
  return AppBar(
    title: Text(title,style: TextStyle(color: Themes.Primary2),),
    centerTitle: centerTitle,
    backgroundColor: color ?? Themes.White,
    leading: BackButton(
      color: Themes.Primary2,
      onPressed: (){
        Get.back(result: returnData);
      },
    ),
    actions: [
      action ?? Container()
    ],
    bottom: bottom,
  );
}
