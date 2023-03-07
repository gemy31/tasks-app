import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../firebase_utils/firebase_utils.dart';
import '../model/task.dart';

class ListProvider extends ChangeNotifier {
  List<Task> taskList = [];
  DateTime selectedDate = DateTime.now();

  getTaskFromFireStore() async {
    QuerySnapshot<Task> querySnapshot = await getTaskCollection().get();
    // get all tasks
    taskList = querySnapshot.docs.map((docs) {
      return docs.data();
    }).toList();
    // filer tasks (selected date)
    taskList = taskList.where((task) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(task.date);
      if (dateTime.day == selectedDate.day &&
          dateTime.month == selectedDate.month &&
          dateTime.year == selectedDate.year) {
        return true;
      }
      return false;
    }).toList();

    //sort tasks
    taskList.sort((Task task1, Task task2) {
      DateTime dateTime1 = DateTime.fromMillisecondsSinceEpoch(task1.date);
      DateTime dateTime2 = DateTime.fromMillisecondsSinceEpoch(task2.date);
      return dateTime1.compareTo(dateTime2);
    });

    notifyListeners();
  }

  changeSelectedDate(DateTime newDate) {
    selectedDate = newDate;
    notifyListeners();
  }
}
