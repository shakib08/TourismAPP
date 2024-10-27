import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuition_media/Home/controller/bottomNavbar.dart';
import 'package:tuition_media/Utils/Constant/colors.dart';

import '../../BookedTours/screens/tourbookedScreen.dart';
import '../../Profile/screens/profileScreen.dart';
import '../../Tours/screens/tour_list.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final BottomNavController bottomNavController =
    Get.put(BottomNavController());

    // List of widgets to display for each tab
    final List<Widget> pages = [
      Center(child: Text('Home Screen')),
      TourListScreen(),
      BookedTourScreen(),
      UserProfileScreen(),
    ];

    return Scaffold(
      body: Obx(() => pages[bottomNavController.selectedIndex.value]), // Display the selected page
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        backgroundColor: Colors.purple, // Set background color to always purple
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore), // Use explore icon for Tours
            label: 'Tours',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark), // Use bookmark icon for Booked
            label: 'Booked',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: bottomNavController.selectedIndex.value, // Set the current index
        selectedItemColor: customIndigoColor, // Color of the selected item
        unselectedItemColor: Colors.black, // Color of unselected items
        onTap: bottomNavController.changeIndex, // Update index using the controller
        selectedIconTheme: IconThemeData(color: customIndigoColor), // Selected icon color
        unselectedIconTheme: IconThemeData(color: Colors.black), // Unselected icon color
      )),
    );
  }
}
