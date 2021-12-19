import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:m_power/Theme/themes.dart';
import 'package:m_power/URL/app_constant.dart';
import 'package:m_power/Widgets/show_message.dart';
import 'package:m_power/main.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

enum ServerDateTime { Date, Time}


class Helper{
  static goBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  static makeCall(String number) async {
    if (await canLaunch('tel:$number')) {
      await launch('tel:$number');
    } else {
      throw 'Could not launch $number';
    }
  }
}