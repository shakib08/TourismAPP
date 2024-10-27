import 'package:flutter/material.dart';
import '../controller/usercontroller.dart';

class UserDetailsScreen extends StatelessWidget {
  final UserModel user;

  UserDetailsScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name), // Use user name as the title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.profileImageUrl),
              backgroundColor: Colors.grey[200],
            ),
            SizedBox(height: 16),
            Text('Name: ${user.name}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Email: ${user.email}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Phone: ${user.phone}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Division: ${user.division}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('District: ${user.district}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Address: ${user.address}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Occupation: ${user.occupation}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Institution: ${user.institution}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
