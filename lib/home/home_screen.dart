import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/home/task_item.dart';
import 'package:to_do_app/home/task_list_tab.dart';
import 'package:to_do_app/setting_tab/setting_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../my_theme.dart';
import '../provider/setting_provider.dart';
import 'add_task_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  static const Route_Name = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      backgroundColor: provider.appTheme == ThemeMode.light
          ? MyThemeData.background
          : MyThemeData.primarydark,
      appBar: AppBar(
        backgroundColor: provider.appTheme == ThemeMode.light
            ? MyThemeData.primaryblue
            : MyThemeData.darkBlueColor,
        centerTitle: true,
        title: const Text(
          'ToDo App',
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: BottomNavigationBar(
          selectedItemColor: MyThemeData.primaryblue,
          unselectedItemColor: MyThemeData.blackColor,
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: currentIndex,
          onTap: (index) {
            currentIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.list,
              ),
              label: AppLocalizations.of(context)!.tasks,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: AppLocalizations.of(context)!.setting,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showTaskBottomSheet();
        },
        shape: StadiumBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.onPrimary,
            width: 4,
          ),
        ),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Tabs[currentIndex],
    );
  }

  void showTaskBottomSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        context: context,
        builder: (context) => AddTaskBottomSheet());
  }

  List<Widget> Tabs = [
    const TaskListTab(),
    const SettingTab(),
  ];
}
