import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuition_media/Admin/CreateTour/createControllers/tourstorecontroller.dart';
import 'package:tuition_media/Admin/CreateTour/widgets/largetextfield.dart';
import 'package:tuition_media/Admin/CreateTour/widgets/smalltextfield.dart';
import 'package:tuition_media/Utils/Constant/colors.dart';
import 'package:tuition_media/Utils/Widgets/customButton.dart';
import '../createControllers/createcontroller.dart';

class CreateTourScreen extends StatelessWidget {
  final CreateTourController controller = Get.put(CreateTourController());
  final TourStorageController tour = Get.put(TourStorageController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Tour'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Start Date Picker
              Obx(() => GestureDetector(
                onTap: () => controller.selectStartDate(context),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Start Date: ${controller.startDate.value.toLocal()}'.split(' ')[0],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )),
              SizedBox(height: 16),
              // End Date Picker
              Obx(() => GestureDetector(
                onTap: () => controller.selectEndDate(context),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'End Date: ${controller.endDate.value.toLocal()}'.split(' ')[0],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )),
              SizedBox(height: size.height*0.03,),
              SmallTextField(
                  hintText: "Title",
                  width: size.width*0.9,
                  controller: controller.title,
                  inputType: TextInputType.text),
              SmallTextField(
                  hintText: "Price",
                  width: size.width*0.9,
                  controller: controller.price,
                  inputType: TextInputType.number),
              LargeTextField(
                  hintText: "Description",
                  width: size.width*0.9,
                  controller: controller.description,
                  inputType: TextInputType.text
              ),
              SizedBox(height: size.height*0.02,),
              Container(
                width: size.width * 0.9,
                child: Row(
                  children: [
                    CustomButton(
                        backgroundColor: Colors.white,
                        text: "Cover Photo",
                        textColor: customIndigoColor,
                        width: size.width * 0.9 * 0.4,
                        onPressed: controller.pickImage),

                    // Display the image file name
                    Obx(() {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            controller.selectedImagePath.value.isNotEmpty
                                ? controller.selectedImagePath.value
                                .split('/')
                                .last // Extract file name from path
                                : "No image selected", // Default text
                            style: TextStyle(
                              fontSize: 16,
                              color: controller
                                  .selectedImagePath.value.isNotEmpty
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                            overflow:
                            TextOverflow.ellipsis, // Truncate if too long
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              SizedBox(height: size.height*0.03,),
              CustomButton(
                  backgroundColor: customIndigoColor,
                  text: "Create",
                  textColor: Colors.white,
                  width: size.width*0.9,
                  onPressed: ()async{
                    try{
                      await tour.saveTour(controller);
                      print("Tour added successfully");
                    }catch(e){
                      print("An error occured. which is $e");
                    }
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
