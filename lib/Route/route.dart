import 'package:get/get.dart';
import 'package:m_power/Screen/home_page.dart';
import 'package:m_power/Screen/login_page.dart';
import 'package:m_power/Screen/splash.dart';


const String HOME = "/home";
const String DEMO = "/demo";
const String SPLASH_SCREEN = "/";
const String LOGIN = "/login";
const String REGISTRATION = "/registration";


List<GetPage> appRoutes()=>[
  GetPage(name: SPLASH_SCREEN, page: () => Splash()),
  GetPage(name: HOME, page: () => HomePage()),
  GetPage(name: LOGIN, page: () => LoginPage()),
];
