import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:tuition_media/Profile/Controller/profileController.dart';
import 'package:tuition_media/Utils/Constant/colors.dart';
import 'package:tuition_media/Utils/Widgets/customButtonWithIcon.dart';

class UserProfileScreen extends StatelessWidget {
  final ProfileController userController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // Retrieve 'extra' from the route settings
    final Object? extra = ModalRoute.of(context)?.settings.arguments;
    bool fromDrawer = false;
    if (extra != null && extra is Map<String, dynamic>) {
      fromDrawer = extra['fromDrawer'] ?? false;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        centerTitle: true,
        // Manually add a back button if navigated from drawer
        leading: fromDrawer
            ? IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        )
            : null, // Do not show back button if accessed from bottom navigation bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image (Circular Avatar)
            Obx(() {
              return CircleAvatar(
                radius: 60,
                backgroundImage: userController.profileImageUrl.value.isNotEmpty
                    ? NetworkImage(userController.profileImageUrl.value)
                    : AssetImage('assets/default_avatar.png') as ImageProvider,
              );
            }),
            SizedBox(height: 20),

            // Name
            Obx(() => Text(
                  userController.name.value,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                )),

            SizedBox(height: 10),

            // User Details
            Obx(() => UserInfoRow(
                  label: 'Email Address',
                  value: userController.email.value,
                )),
            Obx(() => UserInfoRow(
                  label: 'Phone Number',
                  value: userController.phone.value,
                )),
            Obx(() => UserInfoRow(
                  label: 'District',
                  value: userController.district.value,
                )),
            Obx(() => UserInfoRow(
                  label: 'Division',
                  value: userController.division.value,
                )),
            Obx(() => UserInfoRow(
                  label: 'Address',
                  value: userController.address.value,
                )),
            Obx(() => UserInfoRow(
                  label: 'Occupation',
                  value: userController.occupation.value,
                )),
            Obx(() => UserInfoRow(
                  label: 'Institution',
                  value: userController.institution.value,
                )),
         SizedBox(height: size.height*0.04,),
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
        ),
      ),
    );
  }
}

class UserInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const UserInfoRow({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
