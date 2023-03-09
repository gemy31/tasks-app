import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../my_theme.dart';
import '../provider/setting_provider.dart';

class ThemeBottomSheet extends StatelessWidget {
  late var provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          InkWell(
              onTap: () {
                provider.changeAppTheme(ThemeMode.light);
              },
              child: provider.appTheme == ThemeMode.light
                  ? getSelectedBottomSheet(
                      AppLocalizations.of(context)!.lightMood)
                  : getUnSelectedBottomSheet(
                      AppLocalizations.of(context)!.lightMood)),
          const SizedBox(
            height: 20,
          ),
          InkWell(
              onTap: () {
                provider.changeAppTheme(ThemeMode.dark);
              },
              child: provider.appTheme == ThemeMode.dark
                  ? getSelectedBottomSheet(
                      AppLocalizations.of(context)!.darkMood)
                  : getUnSelectedBottomSheet(
                      AppLocalizations.of(context)!.darkMood)),
        ],
      ),
    );
  }

  getSelectedBottomSheet(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
              fontSize: 25,
              color: provider.appTheme == ThemeMode.light
                  ? MyThemeData.primaryblue

                  : MyThemeData.darkBlueColor),



        ),
        Icon(
          Icons.check,
          color: provider.appTheme == ThemeMode.light
              ? MyThemeData.primaryblue

              : MyThemeData.darkBlueColor,



        ),
      ],
    );
  }

  getUnSelectedBottomSheet(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 20, color: MyThemeData.blackColor),
        ),
      ],
    );
  }
}
