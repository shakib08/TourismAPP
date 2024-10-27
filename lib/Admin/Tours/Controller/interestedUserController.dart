import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Interestedusercontroller extends GetxController {
  var isLoading = true.obs;
  var confirmTourList = [].obs;
  final String tourUid;

  Interestedusercontroller(this.tourUid);

  @override
  void onInit() {
    fetchConfirmTourData();
    super.onInit();
  }

  void fetchConfirmTourData() async {
    try {
      isLoading(true);
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('confirmtour')
          .where('tour_uid', isEqualTo: tourUid)
          .get();
      confirmTourList.value = snapshot.docs.map((doc) => doc.data()).toList();
    } finally {
      isLoading(false);
    }
  }
}
