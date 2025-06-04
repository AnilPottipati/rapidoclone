import 'package:get/get.dart';
import 'package:rapidoclone/screens/splash/splash_screen.dart';
import 'package:rapidoclone/screens/auth/login_screen.dart';
import 'package:rapidoclone/screens/auth/otp_screen.dart';
import 'package:rapidoclone/screens/home/home_screen.dart';

abstract class Routes {
  static const SPLASH = '/splash';
  static const LOGIN = '/login';
  static const OTP = '/otp';
  static const HOME = '/home';
}

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: Routes.OTP,
      page: () => const OtpScreen(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
    ),
  ];
}
