import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CollectionController extends GetxController {
  RxInt collectionCount = 0.obs;
  RxInt tourCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    countCollections();
    TourCount ();
  }

  // Fetch and count collections from Firestore
  Future<void> countCollections() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // List all collections in Firestore
      final collections = await firestore.collection('users').get();

      // Count number of documents in the collection
      collectionCount.value = collections.size;
    } catch (e) {
      print('Error counting collections: $e');
    }
  }
  
  Future <void> TourCount () async {
    FirebaseFirestore firestore = FirebaseFirestore.instance; 
    try{
      final tourcount = await firestore.collection('tours').get();
      tourCount.value = tourcount.size;
    }catch(e){
      print('$e');
    }
  }
  
  
}