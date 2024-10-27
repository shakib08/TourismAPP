import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/tourboodedController.dart';

class BookedTourScreen extends StatelessWidget {
  final TourBookedController controller = Get.put(TourBookedController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Tours'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.tourList.isEmpty) {
          return Center(child: Text('No tours found.'));
        }

        return ListView.builder(
          itemCount: controller.tourList.length,
          itemBuilder: (context, index) {
            var tour = controller.tourList[index];
            return Card(
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tour cover image
                  Image.network(
                    tour['tourcoverimage'],
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      tour['tourtitle'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Tour ID: ${tour['tour_uid']}'),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
