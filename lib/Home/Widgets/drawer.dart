import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:go_router/go_router.dart';
import 'package:tuition_media/Home/controller/homeController.dart';
import 'package:tuition_media/Utils/Constant/colors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Homecontroller homeController =
        Get.find<Homecontroller>(); // Retrieve the existing HomeController

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: customIndigoColor, // Purple background for the header
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Use Obx to observe changes in the profileImageUrl
                Obx(() => ClipOval(
                      child: Container(
                        width: 80, // Width of the CircleAvatar
                        height: 80, // Height of the CircleAvatar
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: homeController.profileImageUrl.value.isNotEmpty
                              ? DecorationImage(
                                  image: NetworkImage(
                                      homeController.profileImageUrl.value),
                                  fit: BoxFit
                                      .cover, // Use BoxFit.cover for proper fitting
                                )
                              : null,
                        ),
                        child: homeController.profileImageUrl.value.isEmpty
                            ? Icon(Icons.person,
                                size: 40,
                                color: Colors.white) // Default icon if no image
                            : null,
                      ),
                    )),

                SizedBox(height: 10),
                Text(
                  '${homeController.name.value}',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
             context.go('/profile', extra: {'fromDrawer': true});  // Navigate to Profile screen
            },
          ),
          ListTile(
            leading: Icon(Icons.airplanemode_active),
            title: Text('Tours'),
            onTap: () {
              // Navigate to Tours screen
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              context.go('/login');
            },
          ),
        ],
      ),
    );
  }
}
