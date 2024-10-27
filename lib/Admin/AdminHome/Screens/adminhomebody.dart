import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tuition_media/Utils/Constant/colors.dart';
import 'package:tuition_media/Utils/Widgets/customButtonWithIcon.dart';
import 'package:get/get.dart';

import '../AdminHomeController/admincontroller.dart';

class AdminHomeBody extends StatelessWidget {
  final CollectionController collectionController = Get.put(CollectionController());
  AdminHomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(child: Obx(() {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,  // Centering the entire row
              children: [
                // Column for Total Verified Users
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${collectionController.collectionCount.value}",
                        style: const TextStyle(fontSize: 24),
                      ),
                      const Text("Total Verified Users"),
                    ],
                  ),
                ),

                // Column for Total Active Tours
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                       context.go('/admin_tour'); 
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${collectionController.tourCount.value}",
                          style: const TextStyle(fontSize: 24),
                        ),
                        const Text("Total Active Tours"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.2,
            ),
            CustomButtonWithIcon(
                icon: Icons.logout,
                text: "Logout",
                backgroundColor: customIndigoColor,
                width: size.width * 0.9,
                textColor: Colors.white,
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  context.go('/login');
                })
          ],
        );
      })),
    );
  }
}
