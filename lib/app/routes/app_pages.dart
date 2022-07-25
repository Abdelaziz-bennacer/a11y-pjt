import 'package:get/get.dart';

import '../modules/adminCalendar/bindings/admin_calendar_binding.dart';
import '../modules/adminCalendar/views/admin_calendar_view.dart';
import '../modules/adminUsers/bindings/admin_users_binding.dart';
import '../modules/adminUsers/views/admin_users_view.dart';
import '../modules/base/bindings/base_binding.dart';
import '../modules/base/views/base_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/managerCalendar/bindings/manager_calendar_binding.dart';
import '../modules/managerCalendar/views/manager_calendar_view.dart';
import '../modules/unknown_route_page/unknown_route_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  //static const HOME = Routes.HOME;
  static const LOGIN = Routes.LOGIN;
  static const BASE = Routes.BASE;
  static const ADMIN_USERS = Routes.ADMIN_USERS;
  static const ADMIN_CALENDAR = Routes.ADMIN_CALENDAR;
  static const MANAGER_CALENDAR = Routes.MANAGER_CALENDAR;

  static final unknownRoutePage = GetPage(
    name: _Paths.UNKNOWN,
    page: () => UnknownRoutePage(),
    //transition: _defaultTransition,
  );

  static final routes = [
    unknownRoutePage,
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      //binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.BASE,
      page: () => const BaseView(),
      binding: BaseBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_USERS,
      page: () => AdminUsersView(),
      binding: AdminUsersBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_CALENDAR,
      page: () => const ManagerCalendar(),
      binding: AdminCalendarBinding(),
    ),
    GetPage(
      name: _Paths.MANAGER_CALENDAR,
      page: () => EventCalendar(),
      binding: ManagerCalendarBinding(),
    ),
  ];
}
