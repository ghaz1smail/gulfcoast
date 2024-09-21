import 'package:get/get.dart';
import 'package:gulfcoast/view/admin/admin_acreen.dart';
import 'package:gulfcoast/view/admin/users/add_user_screen.dart';
import 'package:gulfcoast/view/register/forget_screen.dart';
import 'package:gulfcoast/view/register/register_screen.dart';
import 'package:gulfcoast/view/user/cars/auction_cars.dart';
import 'package:gulfcoast/view/user/cars/filter/filter_screen.dart';
import 'package:gulfcoast/view/user/user_screen.dart';

class AppRoutes {
  List<GetPage<dynamic>>? pagesRoutes = [
    GetPage(name: '/', page: () => const RegisterScreen()),
    GetPage(name: '/guest', page: () => const AuctionCars()),
    GetPage(name: '/filter', page: () => const FilterScreen()),
    GetPage(name: '/home', page: () => const UserScreen()),
    GetPage(name: '/admin', page: () => const AdminScreen()),
    GetPage(name: '/fogot-password', page: () => const ForgetScreen()),
    GetPage(name: '/add-user', page: () => const AddUserScreen()),
  ];
}
