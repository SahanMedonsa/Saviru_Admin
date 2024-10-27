import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, Map<String, int>>> getVegetableTotalsByDate() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Map<String, Map<String, int>> totalsByDate = {};

  QuerySnapshot farmerSnapshot = await firestore.collection('farmer').get();

  for (var farmerDoc in farmerSnapshot.docs) {
    CollectionReference dailyCollectionRef = farmerDoc.reference.collection('Daily Collection');
    QuerySnapshot dailyCollectionSnapshot = await dailyCollectionRef.get();

    for (var dailyDoc in dailyCollectionSnapshot.docs) {
      String date = dailyDoc['CollectedDate'];
      String vegetable = dailyDoc['vege'];
      int amount = int.tryParse(dailyDoc['amount']) ?? 0;

      if (!totalsByDate.containsKey(date)) {
        totalsByDate[date] = {};
      }

      if (!totalsByDate[date]!.containsKey(vegetable)) {
        totalsByDate[date]![vegetable] = 0;
      }

      totalsByDate[date]![vegetable] = totalsByDate[date]![vegetable]! + amount;
    }
  }

  return totalsByDate;
}
