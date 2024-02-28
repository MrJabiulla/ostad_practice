import 'package:flutter/material.dart';
import 'package:untitled/presentation/app_screen/bottom_navigation_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
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
        borderSide: BorderSide(color: Theme.of(context).colorScheme.onSecondary),
      ),
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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager App',
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(
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
      home: BottomNavigationScreen(
        toggleTheme: _toggleTheme,
      ),
    );
  }
}
