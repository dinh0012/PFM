import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference myCollectionSetting = Firestore.instance.collection('setting');

class Setting {
  final String salary;
  final String periodSalary;
  Setting({this.salary, this.periodSalary});

  Stream<DocumentSnapshot> getBaseSettingData() {
    Stream<DocumentSnapshot> snapshots = myCollectionSetting.document('base_setting').snapshots();
    return snapshots;
  }

  Future<void> updateBaseSettingData(data) {
    return myCollectionSetting.document('base_setting').updateData(data);
  }
}
