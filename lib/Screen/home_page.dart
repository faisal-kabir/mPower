import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_power/Controller/home_controller.dart';
import 'package:m_power/Dimension/dimension.dart';
import 'package:m_power/Model/application_list.dart';
import 'package:m_power/Theme/themes.dart';
import 'package:m_power/URL/url.dart';
import 'package:m_power/Widgets/circular_progress.dart';
import 'package:m_power/Widgets/grid_animation.dart';
import 'package:m_power/Widgets/image_placeholder.dart';
import 'package:m_power/Widgets/list_animation.dart';
import 'package:m_power/Widgets/swipe_refresh.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: controller,
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Image.asset('assets/logo.png',),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Themes.White,
          ),
          backgroundColor: Color(0xFFF9BABC),
          body: SwipeRefresh(
            controller: controller.refreshController,
            onRefresh: controller.onRefresh,
            children: [
              mainView()
            ]
          )
        );
      },
    );
  }

  Widget mainView() {
    return controller.applicationList!=null ? ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: controller.applicationList!.types!.length,
      itemBuilder: (context,index){
        return ListAnimation(
          index: index,
          child: Card(
            margin: EdgeInsets.only(top: Dimension.Padding),
            color: index%2==0 ? Color(0xFFFCDFDD) : Colors.white,
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: Dimension.Size_10,top: Dimension.Size_5),
                  child: Text(controller.applicationList!.types![index],style: Get.textTheme.headline1!.copyWith(color: Themes.Primary),),
                ),
                Container(
                  height: 165,
                  margin: EdgeInsets.only(top: Dimension.Size_10),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.applicationList!.typeWiseData![controller.applicationList!.types![index]]!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,position){
                      return GridAnimation(
                        column: controller.applicationList!.typeWiseData![controller.applicationList!.types![index]]!.length,
                        index: position,
                        child: singleApplication(controller.applicationList!.typeWiseData![controller.applicationList!.types![index]]![position],position)
                      );
                    }
                  ),
                )
              ],
            ),
          ),
        );
      },
    ) : CircularProgress();
  }

  singleApplication(ApplicationData applicationData, int position){
    return Container(
      margin: EdgeInsets.only(left: Dimension.Size_10),
      width: Get.width/3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(Dimension.Size_10),
              child: CachedNetworkImage(
                imageUrl: '${URL.Main_Url}${applicationData.logoImg}',
                height: 90,
                width: 90,
                fit: BoxFit.cover,
                placeholder: (context, url) => ImagePlaceHolder(height: 90),
                errorWidget: (context, url, error) => ImagePlaceHolder(height: 90),
              ),
            ),
          ),
          Text(applicationData.applicantName!,style: Get.textTheme.bodyText2!.copyWith(color: Themes.Primary),textAlign: TextAlign.center,)
        ],
      ),
    );
  }

}
