import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../my_theme.dart';
import '../provider/setting_provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {

late var provider ;
  @override
  Widget build(BuildContext context) {
     provider = Provider.of<AppConfigProvider>(context);

    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          InkWell(
              onTap: () {
                provider.changeAppLanguage('en');
              },
              child: provider.appLanguage == 'en'
                  ? getSelectedItemBottomSheet(
                      AppLocalizations.of(context)!.english)
                  : getUnSelectedItemBottomSheet(
                      AppLocalizations.of(context)!.english)),
          const SizedBox(
            height: 20,
          ),
          InkWell(
              onTap: () {
                provider.changeAppLanguage('ar');
              },
              child: provider.appLanguage == 'ar'
                  ? getSelectedItemBottomSheet(
                      AppLocalizations.of(context)!.arabic)
                  : getUnSelectedItemBottomSheet(
                      AppLocalizations.of(context)!.arabic)),
        ],
      ),
    );
  }

  getSelectedItemBottomSheet(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            color: provider.appTheme == ThemeMode.light
                ? MyThemeData.primaryblue
                : MyThemeData.darkBlueColor,
            fontSize: 25,
          ),
        ),
        Icon(
          Icons.check,
          color: provider.appTheme == ThemeMode.light
              ? MyThemeData.primaryblue
              : MyThemeData.darkBlueColor,
        )
      ],
    );
  }

  getUnSelectedItemBottomSheet(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            color: MyThemeData.blackColor,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
