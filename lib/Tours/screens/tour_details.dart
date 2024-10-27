import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX package for state management
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tuition_media/Utils/Widgets/customButton.dart';
import '../../Utils/Constant/colors.dart';
import '../controllers/confirmtourcontroller.dart';
import 'confirmdialog.dart'; // Import the custom dialog

class TourDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> tour;

  // Initialize the ConfirmTourController using Get.put to ensure it's managed by GetX
  final ConfirmTourController _confirmTourController =
      Get.put(ConfirmTourController());

  TourDetailsScreen({super.key, required this.tour}) {
    // Call checkBookingStatus when the screen is initialized
    _confirmTourController.checkBookingStatus(tour['uid']);
  }

  // Function to format date
  String formatDateTime(dynamic dateTime) {
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

    return DateFormat('MMMM dd, yyyy, h:mm a')
        .format(parsedDateTime); // Format DateTime
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(tour['title']),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.canPop(context)) {
              context.pop(); // Go back using GoRouter
            } else {
              context
                  .go('/home'); // Navigate to the home screen or another route
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Displaying the cover image
            Image.network(
              tour['cover_url'],
              fit: BoxFit.cover,
              height: 250,
            ),
            const SizedBox(height: 20),
            // Tour Details
            Text('UID: ${tour['uid']}', style: const TextStyle(fontSize: 18)),
            SizedBox(height: size.height * 0.02),
            Text('Title: ${tour['title']}',
                style: const TextStyle(fontSize: 18)),
            SizedBox(height: size.height * 0.02),
            Text('Start Date: ${formatDateTime(tour['startDate'])}',
                style: const TextStyle(fontSize: 18)),
            SizedBox(height: size.height * 0.02),
            Text('End Date: ${formatDateTime(tour['endDate'])}',
                style: const TextStyle(fontSize: 18)),
            SizedBox(height: size.height * 0.02),
            Text('Price: ${tour['price']}',
                style: const TextStyle(fontSize: 18)),
            SizedBox(height: size.height * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Description:', style: TextStyle(fontSize: 18)),
                Text('${tour['description']}',
                    style: const TextStyle(fontSize: 18)),
              ],
            ),
            SizedBox(height: size.height * 0.08),

            // Book Now button with the confirmation dialog
            Obx(() => CustomButton(
                  backgroundColor:
                      _confirmTourController.isBookingConfirmed.value
                          ? Colors.black
                          : customIndigoColor,
                  text: _confirmTourController.isBookingConfirmed.value
                      ? "Booking Confirmed"
                      : "Book Now",
                  textColor: Colors.white,
                  width: size.width * 0.9,
                  onPressed: _confirmTourController.isBookingConfirmed.value
                      ? () {} // Use an empty function to disable the button
                      : () {
                          // Call the custom confirmation dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ConfirmDialog(
                                onConfirm: () {
                                  _confirmTourController.confirmTour(
                                      tour['uid'],
                                      tour['title'],
                                      tour['price'].toString(),
                                      tour['cover_url']);
                                },
                              );
                            },
                          );
                        },
                )),
          ],
        ),
      ),
    );
  }
}
