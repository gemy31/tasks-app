import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:to_do_app/provider/list_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_app/provider/setting_provider.dart';
import 'edit_task_screen.dart';
import 'my_theme.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseFirestore.instance.disableNetwork();
  runApp(MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (BuildContext context) => ListProvider()),
      ChangeNotifierProvider(create: (BuildContext context) => AppConfigProvider()),

      ],
      child: MyApp()));
}
class MyApp extends StatelessWidget{
  late AppConfigProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    getSharedPref();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.Route_Name : (context) => HomeScreen(),
        EditTaskScreen.Route_Name : (context) => EditTaskScreen(),
      },
      initialRoute: HomeScreen.Route_Name,
      theme: MyThemeData.lightMood,
      darkTheme: MyThemeData.darkMood,
      themeMode: provider.appTheme,
      locale: Locale(provider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

    );
  }
  void getSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    String language = prefs.getString('lang') ?? 'en';
    provider.appLanguage = language;
    if (prefs.getString('theme') == 'dark') {
      provider.appTheme = ThemeMode.dark;
    } else {
      provider.appTheme = ThemeMode.light;
    }
  }
}