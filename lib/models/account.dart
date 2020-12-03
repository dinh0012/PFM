import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference myCollectionSetting =
    Firestore.instance.collection('account');

class Account {
  String title;
  String description;
  int percent;

  Account({this.title, this.description, this.percent});

  Stream<QuerySnapshot> getAccountInfo() {
    Stream<QuerySnapshot> snapshots = myCollectionSetting.orderBy('percent', descending: true ).snapshots();
    return snapshots;
  }

  Future<void> updateBaseSettingData(data) {
    return myCollectionSetting.document('base_setting').updateData(data);
  }

  Account fromMap(Map<String, dynamic> map) {
    return new Account(
        title: map['title'],
        description: map['description'],
        percent: map['percent']
    );
  }
}
