import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tuition_media/Admin/Tours/Controller/activeTourList.dart';

import 'activeTourlistDetails.dart';

class AdminToursScreen extends StatelessWidget {
  final AdminToursController controller = Get.put(AdminToursController());

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

    return DateFormat('MMMM dd, yyyy, h:mm a')
        .format(parsedDateTime); // Format DateTime
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tours List'),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            if (context.canPop()) {
              context.pop(); // Use GoRouter's pop if you're using GoRouter
            }else{
              context.go('/admin');
            }
          },
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.toursList.length,
          itemBuilder: (context, index) {
            var tour = controller.toursList[index];
            return GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminTourDetails(tour: controller.toursList[index]),
                  ),
                );
              },
              child: Card(
                elevation: 4,
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // First Row: Cover Image
                      CachedNetworkImage(
                        imageUrl: tour['cover_url'],
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10),

                      // Second Row: Title and Start Date
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            tour['title'].length > 14
                                ? tour['title'].substring(0, 14) + '...'
                                : tour['title'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines:
                                1, // Ensures the text stays on a single line
                            overflow: TextOverflow
                                .ellipsis, // Adds the ellipsis if text is longer than maxLines
                          ),
                          Text(
                            "Start: ${formatDate(tour['startDate'])}", // Format start date
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                      // Third Row: Price and End Date
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$${tour['price']}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          Text(
                            "Start: ${formatDate(tour['endDate'])}",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
