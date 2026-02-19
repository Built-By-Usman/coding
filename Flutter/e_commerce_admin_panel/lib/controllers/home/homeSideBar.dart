import 'package:e_commerce_admin_panel/pages/home/homeComponents/orders/orders.dart';
import 'package:e_commerce_admin_panel/pages/home/homeComponents/sales/sales.dart';
import 'package:e_commerce_admin_panel/pages/home/homeComponents/teachers/teachers.dart';
import 'package:get/get.dart';


import '../../pages/home/homeComponents/dashboard/dashboard.dart';

class sideBarController extends GetxController {
  RxInt index = 0.obs;

  var sidePages = [Dashboard(), Teachers(),Orders() , Sales()];
}
