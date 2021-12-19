import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_power/Dimension/dimension.dart';
import 'package:m_power/Theme/themes.dart';
import 'package:m_power/Widgets/list_animation.dart';
import 'package:skeletons/skeletons.dart';

Widget ApplicationSkeleton({int count = 5}){
  return ListView.builder(
    itemCount: count,
    shrinkWrap: true,
    itemBuilder: (context,index){
      return ListAnimation(
        index: index,
        child: SkeletonItem(
            child: Container(
              margin: EdgeInsets.all(Dimension.Size_10).copyWith(bottom: 0),
              padding: EdgeInsets.all(Dimension.Size_10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2,color: Themes.Grey)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: Dimension.Text_Size_Big,
                    width: Get.width*0.5,
                    decoration: BoxDecoration(
                      color: Themes.White,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(height: Dimension.Size_10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [1,2,3].asMap().map((index,item)=>MapEntry(index,
                        Column(
                          children: [
                            Container(
                              height: Get.width*0.28,
                              width: Get.width*0.28,
                              decoration: BoxDecoration(
                                color: Themes.White,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Container(
                              height: Dimension.Text_Size,
                              width: Get.width*0.28,
                              margin: EdgeInsets.only(top: Dimension.Size_10),
                              decoration: BoxDecoration(
                                color: Themes.White,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                    )).values.toList(),
                  )
                ],
              ),
            )
        )
      );
    }
  );
}