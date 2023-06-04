// ignore_for_file: constant_identifier_names
import 'package:get/get.dart';
import 'package:rick_and_morty/modules/home/home_binding.dart';

import '../modules/home/home.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const Home(),
      binding: HomeBinding(),
    ),
  ];
}
