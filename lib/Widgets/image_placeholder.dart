import 'package:flutter/material.dart';
import 'package:m_power/Theme/themes.dart';

Widget ImagePlaceHolder({required double height}){
  return Container(
    color: Themes.White,
    child: Image.asset('assets/empty.png',fit: BoxFit.cover,height: height,),
  );
}