import 'package:get/get.dart';
import 'package:rapidoclone/view/screens/home_screen.dart';
import 'package:rapidoclone/view/screens/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String booking = '/booking';
  static const String rideDetails = '/ride-details';
  static const String payment = '/payment';
  static const String history = '/history';

  static final List<GetPage> pages = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
    ),
  ];
}
