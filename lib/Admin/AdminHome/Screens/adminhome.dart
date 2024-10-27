import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuition_media/Utils/Constant/colors.dart';


import '../../CreateTour/screens/createtourscreen.dart';
import '../../Users/screen/userlist.dart';
import '../../utils/bottomNavbar.dart';
import 'adminhomebody.dart';

class AdminHomePage extends StatelessWidget {
  final Bottomnavbar _controller = Get.put(Bottomnavbar());

  final List<Widget> _screens = [
    AdminHomeBody(),    // Home screen widget
    CreateTourScreen(),     // Add Tours screen widget
    UserListScreen(),        // Users screen widget
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _screens[_controller.selectedIndex.value]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        backgroundColor: customIndigoColor, // Set background color to purple
        currentIndex: _controller.selectedIndex.value,  // Observe the index from the controller
        onTap: (index) {
          _controller.changeIndex(index);  // Update the index in the controller
        },
        selectedItemColor: Colors.white, // Color for selected icon
        unselectedItemColor: Colors.grey.withOpacity(0.8), // Color for unselected icon with opacity
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Tours',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Users',
          ),
        ],
      )),
    );
  }
}
