import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:m_power/URL/api_client.dart';
import 'package:m_power/URL/url.dart';

class HomeController extends GetxController{
  RxBool Loading=false.obs;
  Api_Client api_client=Api_Client();

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
        onSuccess: (data){

        },
        onError: (data){
        }
    );
    Loading.value=false;
    update();
  }
}
