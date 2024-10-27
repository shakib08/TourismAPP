import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class Bottomnavbar extends GetxController {
  // This will hold the selected index of the bottom navigation bar
  var selectedIndex = 0.obs;

  // This method updates the selected index
  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
