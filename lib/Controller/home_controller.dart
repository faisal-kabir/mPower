import 'dart:async';
import 'dart:io';
import 'package:device_apps/device_apps.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:m_power/AppHelper/helper.dart';
import 'package:m_power/Model/application_list.dart';
import 'package:m_power/Route/route.dart';
import 'package:m_power/URL/api_client.dart';
import 'package:m_power/URL/url.dart';
import 'package:m_power/Widgets/show_message.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../main.dart';

class HomeController extends GetxController{
  RxBool Loading=false.obs;
  Api_Client api_client=Api_Client();
  RefreshController refreshController=RefreshController();

  ApplicationList? applicationList;
  String isApp='https://play.google.com/store/apps/details?id=';

  @override
  void onInit() {
    super.onInit();
    getAllApplication();
  }

  @override
  void onClose() {
    super.onClose();
    api_client.close();
  }



  Future getAllApplication() async {
    Loading.value=true;
    update();
    await api_client.Request(
        url: URL.Application_List,
        method: Method.POST,
        onSuccess: (Map data){
          if(data.containsKey('detail')) {
            ErrorMessage(message: data['detail'],then: (){
              prefs!.clear();
              Get.offAllNamed(LOGIN);
            });
          } else {
            applicationList = ApplicationList.fromJson(data);
          }
        },
        onError: (data){
        }
    );
    refreshController.refreshCompleted();
    Loading.value=false;
    update();
  }

  void onRefresh() {
    applicationList=null;
    Loading.value=true;
    update();
    getAllApplication();
  }

  void goDetails(ApplicationData data) async {
    if (Platform.isAndroid && data.weblink!.contains(isApp)) {
      String packageName=data.weblink!.replaceAll(isApp, '');
      bool isInstalled = await DeviceApps.isAppInstalled(packageName);
      if (isInstalled) {
        DeviceApps.openApp(packageName);
      } else {
        Helper.goBrowser(data.weblink!);
      }
    } else {
      Helper.goBrowser(data.weblink!);
    }
  }
}
