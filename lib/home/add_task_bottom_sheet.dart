import 'package:flutter/material.dart';
import 'package:to_do_app/firebase_utils/firebase_utils.dart';
import 'package:to_do_app/utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../model/task.dart';
import '../my_theme.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  String title = '';

  String description = '';
  DateTime selectedDate = DateTime.now();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(18),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.addNewTask,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: MyThemeData.blackColor),
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Please enter your title';
                    }
                    return null;
                  },
                  onChanged: (text) {
                    title = text;
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    label: Text(AppLocalizations.of(context)!.enterYourTask),
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: MyThemeData.blackColor,
                    ),
                  ),
                ),
                TextFormField(
                  maxLines: 5,
                  minLines: 5,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Please enter your description';
                    }
                    return null;
                  },
                  onChanged: (text) {
                    description = text;
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      label: Text(AppLocalizations.of(context)!.description),
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: MyThemeData.blackColor,
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.selectData,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        chooseData();
                      },
                      child: Text(
                        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        addTask();
                      },
                      child: Text(AppLocalizations.of(context)!.add),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void chooseData() async {
    var chossedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );
    if (chossedDate != null) {
      selectedDate = chossedDate;
      setState(() {});
    }
  }

  void addTask() {
    if (formKey.currentState!.validate()) {
      Task task = Task(
        title: title,
        description: description,
        date: selectedDate.millisecondsSinceEpoch,
      );
      showLoading(context, 'Loading ...');
      addTaskToFirebase(task).timeout(const Duration(milliseconds: 5000),
          onTimeout: () {
        hideLoading(context);
        print('Added Task');
        showMessage(context, 'Task Added Successfully', 'OK', (context) {
          Navigator.pop(context);
          Navigator.pop(context);
        });
      });
    }
  }
}
