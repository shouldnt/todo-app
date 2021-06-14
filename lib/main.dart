import 'package:flutter/material.dart';
import 'package:ktodo/Providers/Theme.dart';
import 'package:ktodo/Routes.dart';
import 'package:ktodo/screens/Init.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeModel>(
        create: (_) => ThemeModel()
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: Consumer<ThemeModel>(
        builder: (context, model, __) {
          return MaterialApp(
            title: 'KTodo',
            theme: ThemeData(
              pageTransitionsTheme: PageTransitionsTheme(),
              primaryColor: model.primaryColor,
              colorScheme: model.colorScheme,
              shadowColor: Color.fromARGB(30, 0, 0, 0),
              scaffoldBackgroundColor: model.backgroundColor,
              appBarTheme: new AppBarTheme(
                backgroundColor: model.primaryColor,
                elevation: 0,
                foregroundColor: model.backgroundColor
              )
            ),
            initialRoute: RouteNames.home,
            routes: routes,
            home: Init()
          );
        },
      )
    );
  }
}
