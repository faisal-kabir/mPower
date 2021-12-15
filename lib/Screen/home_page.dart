
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_power/Controller/home_controller.dart';
import 'package:m_power/Dimension/dimension.dart';
import 'package:m_power/Theme/themes.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  HomeController controller= Get.put(HomeController());

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
            title: Image.asset('assets/mPower.jpeg',),
            centerTitle: true,
            backgroundColor: Themes.White,
          ),
          body: mainView(),
        );
      },
    );
  }

  Widget mainView() {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding),
      children: [

      ],
    );
  }

}
