import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_financial_management/task.dart';

final CollectionReference myCollection = Firestore.instance.collection('todolist');

class FirestoreService {
  
  Future<Task> createTODOTask(String taskname, String taskdetails,String taskdate,String tasktime,String tasktype) async {
      final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(myCollection.document());

      final Task task = new Task(taskname, taskdetails,taskdate,tasktime,tasktype);
      final Map<String, dynamic> data = task.toMap();
      await tx.set(ds.reference, data);
      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Task.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getTaskList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = myCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }

  Stream<QuerySnapshot> getSettingData({int offset, int limit}) {
    final CollectionReference myCollectionSetting = Firestore.instance.collection('setting');
    Stream<QuerySnapshot> snapshots = myCollectionSetting.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }
  
}
