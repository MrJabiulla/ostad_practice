import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/presentation/app_screen/authenication/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'data/provider/language_provider.dart';
import 'data/provider/theme_provider.dart';

class TaskManager extends StatefulWidget {
  const TaskManager({Key? key}) : super(key: key);

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  late LanguageProvider languageProvider;

  @override
  void initState() {
    languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    languageProvider.loadSavedLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final inputDecorationTheme = InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      filled: true,
      fillColor: Theme.of(context).colorScheme.onPrimary,
      hintStyle: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.secondary),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.onSecondary)),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.onSecondary)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color:Theme.of(context).colorScheme.onSecondary)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.onSecondary)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.error)),
    );

    final themeProvider = Provider.of<ThemeProvider>(context);

    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child){
        return Consumer<ThemeProvider>(
          builder: (context, languageProvider, child){
            return
              MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Task Manager App',
                theme: themeProvider.isDarkMode ?
                     ThemeData.dark().copyWith(
                    inputDecorationTheme: inputDecorationTheme,
                    colorScheme: ColorScheme(
                      brightness: Brightness.dark,
                      primary: Colors.grey.shade900,
                      onPrimary: Colors.grey.shade900,
                      secondary: Colors.grey.shade400,
                      onSecondary: Colors.grey.shade400,
                      error: Colors.red,
                      onError: Colors.white,
                      background: Colors.black,
                      onBackground: Colors.white,
                      surface: Colors.grey.shade800,
                      onSurface: Colors.black,
                    ))
                    : ThemeData.light().copyWith(
                    inputDecorationTheme: inputDecorationTheme,
                    colorScheme: ColorScheme(
                      brightness: Brightness.light,
                      primary: Colors.grey.shade100,
                      onPrimary: Colors.green,
                      secondary: Colors.grey.shade800,
                      onSecondary: Colors.white,
                      error: Colors.red,
                      onError: Colors.white,
                      background: Colors.grey.shade50,
                      onBackground: Colors.white,
                      surface: Colors.green,
                      onSurface: Colors.transparent,
                    )
                ),

                home: const SplashScreen(),

                supportedLocales: const [
                  Locale('en', ''),
                  Locale('bn', ''),
                ],

                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],

                localeResolutionCallback: (locale, supportedLocales) {
                  for (var supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == locale?.languageCode &&
                        supportedLocale.countryCode == locale?.countryCode) {
                      return supportedLocale;
                    }
                  }
                  return supportedLocales.first;
                },
              );
          },
        );
      },
    );
  }
}

