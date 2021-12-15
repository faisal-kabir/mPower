import 'package:flutter/material.dart';
import 'package:m_power/Theme/themes.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

Widget SwipeRefresh({required RefreshController controller,required VoidCallback onRefresh,required List<Widget> children}){
  return SmartRefresher(
    child:ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      children: children,
    ),
    onRefresh: onRefresh,
    //header: AppConstant.swipeIndicator,
    header: WaterDropMaterialHeader(backgroundColor: Themes.Primary,),
    enablePullDown: true,
    enablePullUp: false,
    controller: controller,
  );
}
