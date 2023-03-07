import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/firebase_utils/firebase_utils.dart';
import 'package:to_do_app/model/task.dart';
import 'package:to_do_app/provider/setting_provider.dart';
import 'package:to_do_app/utils/utils.dart';

import 'my_theme.dart';

class EditTaskScreen extends StatefulWidget {
  static const String Route_Name = 'edit';

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late Task taskargs;

  var formKey = GlobalKey<FormState>();
  late String title;

  late String des;

  late DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    taskargs = ModalRoute.of(context)!.settings.arguments as Task;
    title = taskargs.title;
    des = taskargs.description;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWedith = MediaQuery.of(context).size.width;
    selectedDate = DateTime.fromMillisecondsSinceEpoch(taskargs.date);
    return Scaffold(
      backgroundColor: provider.appTheme == ThemeMode.light
          ? MyThemeData.background
          : MyThemeData.primarydark,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        title: const Text(
          'To Do List',
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: screenHeight * .1,
            color: Colors.blue,
          ),
          Container(
            margin: EdgeInsets.only(left: .1, top: screenHeight * .02),
            width: screenWedith * .8,
            height: screenHeight * .7,
            decoration: BoxDecoration(
                color: provider.appTheme == ThemeMode.light
                    ? Colors.white
                    : MyThemeData.backgroundDark,
                borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.all(15),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text(
                    'Edit Task',
                    style: TextStyle(
                        color: provider.appTheme == ThemeMode.light
                            ? MyThemeData.blackColor
                            : MyThemeData.whiteColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: title,
                    style: TextStyle(
                        color: provider.appTheme == ThemeMode.light
                            ? MyThemeData.blackColor
                            : MyThemeData.whiteColor),
                    // initialValue: taskargs.title,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter the title';
                      }
                      return null;
                    },
                    // controller: titleController,
                    onChanged: (text) {
                      title = text;
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      labelText: 'This is Title',
                      labelStyle: TextStyle(
                          color: provider.appTheme == ThemeMode.light
                              ? MyThemeData.blackColor
                              : MyThemeData.whiteColor,
                          fontSize: 17),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    initialValue: des,
                    style: TextStyle(
                        color: provider.appTheme == ThemeMode.light
                            ? MyThemeData.blackColor
                            : MyThemeData.whiteColor),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter the description';
                      }
                      return null;
                    },
                    // controller: descController,
                    onChanged: (text) {
                      des = text;
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      labelText: 'This is Description',
                      labelStyle: TextStyle(
                          color: provider.appTheme == ThemeMode.light
                              ? MyThemeData.blackColor
                              : MyThemeData.whiteColor,
                          fontSize: 17),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Select Time',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: provider.appTheme == ThemeMode.light
                                ? MyThemeData.blackColor
                                : MyThemeData.whiteColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          showDate();
                        },
                        child: Center(
                          child: Text(
                            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                            style: TextStyle(
                              fontSize: 18,
                              color: provider.appTheme == ThemeMode.light
                                  ? MyThemeData.whiteColor
                                  : MyThemeData.whiteColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          editTask();
                        },
                        child: const Text(
                          'Save Changes',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showDate() async {
    var dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (dateTime != null) {
      selectedDate = dateTime;
    }
    setState(() {});
  }

  void editTask() async {
    if (formKey.currentState!.validate()) {
      Task editTask = Task(
          id: taskargs.id,
          title: title,
          description: des,
          date: selectedDate.millisecondsSinceEpoch,
          isDone: false);
      showLoading(context, 'Loading...');
      await getTaskCollection()
          .doc(taskargs.id)
          .update(editTask.toJson())
          .timeout(const Duration(seconds: 5), onTimeout: () {
        hideLoading(context);
        showMessage(context, 'Task Edited Successfully', 'OK', (context) {
          Navigator.pop(context);
        });
      });
    }
  }
}
