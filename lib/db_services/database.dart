import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future addPersonalTask(
      Map<String, dynamic> userPersonalMap, String id) async {
    await FirebaseFirestore.instance
        .collection("Personal")
        .doc(id)
        .set(userPersonalMap);
  }

  Future addCollegeTask(Map<String, dynamic> userPersonalMap, String id) async {
    await FirebaseFirestore.instance
        .collection("College")
        .doc(id)
        .set(userPersonalMap);
  }

  Future addOfficeTask(Map<String, dynamic> userPersonalMap, String id) async {
    await FirebaseFirestore.instance
        .collection("Office")
        .doc(id)
        .set(userPersonalMap);
  }

  Future<Stream<QuerySnapshot>> getTask(String task) async {
    return FirebaseFirestore.instance.collection(task).snapshots();
  }

  tickMethod(String id, String task) async {
    return FirebaseFirestore.instance
        .collection(task)
        .doc(id)
        .update({"Yes": true});
  }

  removeMethod(String id, String task) async {
    return FirebaseFirestore.instance.collection(task).doc(id).delete();
  }
}
