import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_power/Controller/home_controller.dart';
import 'package:m_power/Dimension/dimension.dart';
import 'package:m_power/Model/application_list.dart';
import 'package:m_power/Route/route.dart';
import 'package:m_power/Theme/themes.dart';
import 'package:m_power/URL/url.dart';
import 'package:m_power/Widgets/application_skeleton.dart';
import 'package:m_power/Widgets/circular_progress.dart';
import 'package:m_power/Widgets/default_dialog.dart';
import 'package:m_power/Widgets/grid_animation.dart';
import 'package:m_power/Widgets/image_placeholder.dart';
import 'package:m_power/Widgets/list_animation.dart';
import 'package:m_power/Widgets/swipe_refresh.dart';

import '../main.dart';


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
            actions: [
              IconButton(
                onPressed: () =>  logOut(),
                icon: Icon(Icons.power_settings_new,color: Themes.Primary,)
              )
            ],
          ),
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
            color: index%2==0 ? Themes.TextFieldBackground : Colors.white,
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
    ) : ApplicationSkeleton();
  }

  singleApplication(ApplicationData applicationData, int position){
    return InkWell(
      onTap: () => controller.goDetails(applicationData),
      child: Container(
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
      ),
    );
  }


  void logOut(){
    Get.dialog(
        DefaultDialog(
          title: language.LogOut,
          enableCloseButton: true,
          child: Text(language.Are_you_sure_you_want_to_logout,style: Theme.of(context).textTheme.bodyText1,),
          onButtonClick: (state){
            if(!state) {
              Get.back();
            } else{
              prefs!.clear();
              Get.offAllNamed(LOGIN);
            }
          },
        )
    );
  }

}
