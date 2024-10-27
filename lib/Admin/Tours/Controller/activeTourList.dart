import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminToursController extends GetxController {
  var isLoading = true.obs;
  var toursList = [].obs;

  @override
  void onInit() {
    fetchTours();
    super.onInit();
  }

  void fetchTours() async {
    try {
      isLoading(true);
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('tours').get();
      toursList.value = snapshot.docs.map((doc) => doc.data()).toList();
    } finally {
      isLoading(false);
    }
  }
}
