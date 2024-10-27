import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../Controller/interestedUserController.dart';

class AdminTourDetails extends StatelessWidget {
  final Map<String, dynamic> tour;  // Accept the tour data as a parameter
  final Interestedusercontroller confirmTourController;

  AdminTourDetails({required this.tour, Key? key})
      : confirmTourController = Get.put(Interestedusercontroller(tour['uid'])),
        super(key: key);

  String formatDate(dynamic dateTime) {
    DateTime parsedDateTime;

    if (dateTime is Timestamp) {
      parsedDateTime = dateTime.toDate();
    } else if (dateTime is String) {
      parsedDateTime = DateTime.parse(dateTime);
    } else if (dateTime is DateTime) {
      parsedDateTime = dateTime;
    } else {
      throw Exception("Unsupported date format");
    }

    return DateFormat('MMMM dd, yyyy, h:mm a').format(parsedDateTime); // Format DateTime
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tour Details"),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            if (context.canPop()) {
              context.pop(); // Use GoRouter's pop if you're using GoRouter
            } else {
              context.go('/admin');
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Tour Details
            CachedNetworkImage(
              imageUrl: tour['cover_url'],
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              tour['title'] ?? 'No Title',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              "Description: ${tour['description']}",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "Price: ${tour['price']}",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "UID: ${tour['uid']} ",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "Start: ${formatDate(tour['startDate'])}",
              style: TextStyle(fontSize: 12),
            ),
            Text(
              "End: ${formatDate(tour['endDate'])}",
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 20),

            // Confirm Tour List (Matching tour_uid)
            Text(
              'Confirmed Users',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            Obx(() {
              if (confirmTourController.isLoading.value) {
                return CircularProgressIndicator();
              }

              if (confirmTourController.confirmTourList.isEmpty) {
                return Text('No users have confirmed this tour yet.');
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: confirmTourController.confirmTourList.length,
                itemBuilder: (context, index) {
                  var confirmTour = confirmTourController.confirmTourList[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: ListTile(
                      leading: CachedNetworkImage(
                        imageUrl: confirmTour['profile_image_url'],
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(confirmTour['name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Email: ${confirmTour['email']}'),
                          Text('Phone: ${confirmTour['phone']}'),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
