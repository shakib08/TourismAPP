import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For formatting dates
import '../controllers/tourcontroller.dart';

class TourListScreen extends StatelessWidget {
  final TourController tourController = Get.put(TourController());

  TourListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch tours once the screen is built
    tourController.fetchTours();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tours'),
      ),
      body: Obx(() {
        // Loading indicator while data is fetched
        if (tourController.tours.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: tourController.tours.length,
          itemBuilder: (context, index) {
            var tour = tourController.tours[index];

            // Convert startDate and endDate, handling both Timestamp and String
            DateTime? startDate;
            DateTime? endDate;

            // Safely handle the startDate
            if (tour['startDate'] != null) {
              if (tour['startDate'] is Timestamp) {
                startDate = (tour['startDate'] as Timestamp).toDate();
              } else if (tour['startDate'] is String) {
                try {
                  startDate = DateTime.parse(tour['startDate']);
                } catch (e) {
                  startDate = null;
                }
              }
            }

            // Safely handle the endDate
            if (tour['endDate'] != null) {
              if (tour['endDate'] is Timestamp) {
                endDate = (tour['endDate'] as Timestamp).toDate();
              } else if (tour['endDate'] is String) {
                try {
                  endDate = DateTime.parse(tour['endDate']);
                } catch (e) {
                  endDate = null;
                }
              }
            }

            // Handle null and invalid date cases
            String formattedStartDate = startDate != null
                ? DateFormat('dd MMM yyyy').format(startDate)
                : 'Unknown start date';
            String formattedEndDate = endDate != null
                ? DateFormat('dd MMM yyyy').format(endDate)
                : 'Unknown end date';

            return GestureDetector(
              onTap: () => tourController.goToDetails(context, tour),
              child: Card(
                elevation: 5,
                shadowColor: Colors.purple,
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    // Cover image with a fallback in case the URL is invalid or missing
                    tour['cover_url'] != null && tour['cover_url'].toString().isNotEmpty
                        ? Image.network(
                      tour['cover_url'],
                      fit: BoxFit.cover,
                      height: 200,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.broken_image,
                          size: 200,
                          color: Colors.grey,
                        );
                      },
                    )
                        : const Icon(
                      Icons.broken_image,
                      size: 200,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          // Title and Start Date
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(tour['title'] ?? 'No title', style: const TextStyle(fontSize: 18)),
                              Text(formattedStartDate, style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                          // Price and End Date
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Price: ${tour['price'] ?? 'Unknown price'}', style: const TextStyle(fontSize: 16)),
                              Text('End: $formattedEndDate', style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
