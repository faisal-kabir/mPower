import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:m_power/Model/application_list.dart';
import 'package:m_power/URL/api_client.dart';
import 'package:m_power/URL/url.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController{
  RxBool Loading=false.obs;
  Api_Client api_client=Api_Client();
  RefreshController refreshController=RefreshController();

  ApplicationList? applicationList;

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
        onSuccess: (data){
          applicationList=ApplicationList.fromJson(data);
          applicationList!.typeWiseData!.forEach((key, value) {
            print('key = $key / value = ${value.length}');
          });
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
}
