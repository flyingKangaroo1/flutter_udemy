import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

import 'package:flutter_udemy/widgets/expenses.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  //dark mode에 적합하된 비슷한 색상을 만들기 위해
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 9, 125),
);

void main() {
//  WidgetsFlutterBinding.ensureInitialized();
//  //portraitUp orientation만 허용
//  SystemChrome.setPreferredOrientations([
//    DeviceOrientation.portraitUp,
//  ]).then((fn) {
    runApp(
      MaterialApp(
        darkTheme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: kDarkColorScheme,
          //안 쓰면 null오류 떠서
          cardTheme: CardTheme().copyWith(
            color: kDarkColorScheme.secondaryContainer,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kDarkColorScheme.primaryContainer,
              foregroundColor: kDarkColorScheme.onPrimaryContainer,
            ),
          ),
        ),
        //copyWith 하면 default쓰면서 일부분만 바꿀 수 override 있다
        theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: kColorScheme,
          appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer,
          ),
          cardTheme: CardTheme().copyWith(
            color: kColorScheme.secondaryContainer,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            //widget 어떤거는 styleFrom() 어떤거는 copyWith()
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                //titleLarge: ThemeData().textTheme.titleLarge.copyWith(),
                titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 16,
                ),
              ),
        ),
        //themeMode: ThemeMode.system, //default, user system 따라 light또는 dark모드
        themeMode: ThemeMode.dark,
        home: const Expenses(),
      ),
    );
//  });
}
