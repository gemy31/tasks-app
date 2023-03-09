import 'package:flutter/material.dart';
<<<<<<< HEAD

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_app/setting_tab/theme_bottom_sheet.dart';
import '../my_theme.dart';

import '../provider/setting_provider.dart';
import 'language_bottom_sheet.dart';

class SettingTab extends StatefulWidget {

=======
import 'package:provider/provider.dart';
import 'package:to_do_app/setting_tab/theme_bottom_sheet.dart';
import '../my_theme.dart';
import '../provider/setting_provider.dart';
import 'language_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingTab extends StatefulWidget {
  const SettingTab({Key? key}) : super(key: key);
>>>>>>> origin/master

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.language,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: provider.appTheme == ThemeMode.light
                      ? MyThemeData.blackColor
                      : MyThemeData.whiteColor)),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              showLanguageBottomSheet();
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: provider.appTheme == ThemeMode.light
<<<<<<< HEAD
                      ? MyThemeData.whiteColor
=======
                      ? MyThemeData.primaryblue
>>>>>>> origin/master
                      : MyThemeData.backgroundDark),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      provider.appLanguage == 'en'
                          ? AppLocalizations.of(context)!.english
                          : AppLocalizations.of(context)!.arabic,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
<<<<<<< HEAD
                          ?.copyWith(color: provider.appTheme == ThemeMode.light
                          ? MyThemeData.primaryblue
                          : MyThemeData.darkBlueColor)),
                   Icon(
                    Icons.arrow_drop_down_outlined,
                    size: 40,
                    color: provider.appTheme == ThemeMode.light
                        ? MyThemeData.primaryblue
                        : MyThemeData.darkBlueColor,
=======
                          ?.copyWith(color: provider.appTheme == ThemeMode.light? MyThemeData.whiteColor:MyThemeData.whiteColor)),
                  const Icon(
                    Icons.arrow_drop_down_outlined,
                    size: 40,
                    color:Colors.white,
>>>>>>> origin/master
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            AppLocalizations.of(context)!.theme,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: provider.appTheme == ThemeMode.light
                    ? MyThemeData.blackColor
                    : MyThemeData.whiteColor),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              showThemeBottomSheet();
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: provider.appTheme == ThemeMode.light
<<<<<<< HEAD
                      ? MyThemeData.whiteColor
=======
                      ? MyThemeData.primaryblue
>>>>>>> origin/master
                      : MyThemeData.backgroundDark),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.appTheme == ThemeMode.light
                        ? AppLocalizations.of(context)!.lightMood
                        : AppLocalizations.of(context)!.darkMood,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
<<<<<<< HEAD
                        ?.copyWith(color:  provider.appTheme == ThemeMode.light
                        ? MyThemeData.primaryblue
                        : MyThemeData.darkBlueColor),
                  ),
                   Icon(
                    Icons.arrow_drop_down_outlined,
                    size: 40,
                    color: provider.appTheme == ThemeMode.light
                        ? MyThemeData.primaryblue
                        : MyThemeData.darkBlueColor,
=======
                        ?.copyWith(color: provider.appTheme == ThemeMode.light? MyThemeData.whiteColor:MyThemeData.whiteColor),
                  ),
                  const Icon(
                    Icons.arrow_drop_down_outlined,
                    size: 40,
                    color:Colors.white,
>>>>>>> origin/master
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        context: context,
        builder: (context) => LanguageBottomSheet());
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        context: context,
        builder: (context) => ThemeBottomSheet());
  }
}
