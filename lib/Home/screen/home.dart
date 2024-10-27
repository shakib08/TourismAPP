import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuition_media/Home/Widgets/drawer.dart';
import 'package:tuition_media/Home/screen/body.dart';
import 'package:tuition_media/Utils/Constant/colors.dart';
import 'package:tuition_media/Home/controller/homeController.dart'; // Import the HomeController

class HomeScreen extends StatelessWidget {
  final Homecontroller homeController =
      Get.put(Homecontroller()); // Initialize the controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customIndigoColor,
        title: Text(
          "SR Travel Agency",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme:
            IconThemeData(color: Colors.white), // Set icon color to white
      ),
      drawer: CustomDrawer(), // Use the CustomDrawer
      body: Body(),
    );
  }
}
