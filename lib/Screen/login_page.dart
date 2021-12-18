import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_power/Controller/login_controller.dart';
import 'package:m_power/Dimension/dimension.dart';
import 'package:m_power/Packege/Loading_Button/loading_button.dart';
import 'package:m_power/Route/route.dart';
import 'package:m_power/Theme/themes.dart';
import 'package:m_power/Widgets/default_appbar.dart';
import 'package:m_power/Widgets/default_textfield.dart';
import 'package:m_power/main.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  LoginController controller = Get.put(LoginController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: controller,
      builder: (_) {
        return Scaffold(
          body: Form(key: controller.formKey, child: mainView()),
        );
      },
    );
  }

  Widget mainView() {
    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(
            left: Dimension.Padding, right: Dimension.Padding),
        children: [
          SizedBox(height: Dimension.Padding,),
          Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                'assets/logo.png', height: Get.height * 0.1,)
          ),
          Padding(
            padding: EdgeInsets.only(
                left: Dimension.Padding, right: Dimension.Padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height * 0.05,),
                Text(language.Sign_In,
                  style: Get.textTheme.headline1!.copyWith(
                      fontSize: Dimension.Size_20),),
                SizedBox(height: Get.height * 0.025,),
                DefaultTextField(
                    controller: controller.username,
                    label: language.Username_or_Email,
                    textInputType: TextInputType.emailAddress
                ),
                SizedBox(height: Dimension.Padding,),
                Obx(() {
                  return DefaultTextField(
                      controller: controller.password,
                      label: language.Password,
                      textInputType: TextInputType.visiblePassword,
                      obscureText: controller.obscureText.value,
                      suffixIcon: IconButton(
                          onPressed: () {
                            controller.obscureText(
                                !controller.obscureText.value);
                          },
                          icon: Icon(controller.obscureText.value ? Icons
                              .visibility_off_rounded : Icons
                              .visibility_rounded)
                      )
                  );
                }),
                SizedBox(height: Dimension.Size_20,),
                Obx(() =>
                    LoadingButton(
                      isLoading: controller.Loading.value,
                      onPressed: () => controller.requestLogin(),
                      buttonDecoration: ButtonDecoration.Shadow,
                      backgroundColor: Themes.Primary,
                      child: Container(
                          margin: EdgeInsets.only(top: Dimension.Size_10,
                              bottom: Dimension.Size_10),
                          alignment: Alignment.center,
                          width: Get.width * 0.7,
                          child: Text(language.Sign_In.toUpperCase(),
                            style: Get.textTheme.headline1!.copyWith(
                                color: Themes.White),
                          )
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

}
