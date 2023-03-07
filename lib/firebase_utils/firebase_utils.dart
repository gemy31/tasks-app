import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:to_do_app/model/task.dart';

CollectionReference<Task> getTaskCollection() {
  return FirebaseFirestore.instance.collection('task').withConverter<Task>(
        fromFirestore: (snapShot, option) => Task.fromJson(snapShot.data()!),
        toFirestore: (task, options) => task.toJson(),
      );
}

Future<void> addTaskToFirebase(Task task) {
  var collection = getTaskCollection();
  var docRef = collection.doc();
  task.id = docRef.id;
  return docRef.set(task);
}

Future<void> deleteTaskFromFireStore(Task task) {
  return getTaskCollection().doc(task.id).delete();
}
