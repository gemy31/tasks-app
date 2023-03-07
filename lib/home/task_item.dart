import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/my_theme.dart';
import 'package:to_do_app/provider/list_provider.dart';
import 'package:to_do_app/utils/utils.dart';
import '../edit_task_screen.dart';
import '../firebase_utils/firebase_utils.dart';
import '../model/task.dart';
import '../provider/setting_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskItem extends StatelessWidget {
  Task task ;
  TaskItem({required this.task});
  late ListProvider listProvider ;
  late AppConfigProvider provider ;

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);
    provider = Provider.of<AppConfigProvider>(context);


    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(EditTaskScreen.Route_Name,
        arguments: task);
      },
      child: Container(
        margin: const EdgeInsets.all(15),
        child: Slidable(
            startActionPane: ActionPane(
              extentRatio: .25,
              motion:  const ScrollMotion(),
              children:  [
                SlidableAction(
                  onPressed: (context){
                    deleteTaskFromFireStore(task).timeout(const Duration(milliseconds: 5000),onTimeout: (){
                     listProvider.getTaskFromFireStore();
                     showMessage(context, 'Task was Deleted Successfully', 'Ok', (context){
                       Navigator.pop(context);
                     });
                    });
                  },
                  backgroundColor: MyThemeData.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(8),bottomLeft:  Radius.circular(8)),
                ),
              ],
            ),
          child: Container(
             // margin: EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color:provider.appTheme==ThemeMode.light? MyThemeData.whiteColor:MyThemeData.backgroundDark,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Container(
                  height: 80,
                  width: 4,
                  color:task.isDone! ?MyThemeData.green : MyThemeData.primaryblue,
                ),
                const SizedBox(width: 15,),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(task.title,style: TextStyle( color:task.isDone! ? MyThemeData.green : MyThemeData.primaryblue),),
                    const SizedBox(height: 8,),
                    Text(task.description,style: TextStyle(color:provider.appTheme==ThemeMode.light? MyThemeData.blackColor:MyThemeData.whiteColor),),
                  ],
                )),
                InkWell(
                  onTap:(){
                    editTaskToFireBase();
                  },
                  child:task.isDone! ?
                      Text('Done !',style: TextStyle(color: MyThemeData.green,fontSize: 22,fontWeight: FontWeight.bold),)
                  :
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 24),
                   // margin: EdgeInsets.all(13),
                    decoration: BoxDecoration(
                        color:provider.appTheme==ThemeMode.light? MyThemeData.primaryblue:MyThemeData.darkBlueColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.check,color: MyThemeData.whiteColor,size: 22,),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  void editTaskToFireBase() {
    var collection = getTaskCollection();
    collection.doc(task.id).update(
        {
          'isDone' : !task.isDone!
        });
  }
}

