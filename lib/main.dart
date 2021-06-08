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
            darkTheme: ThemeData.dark(),
            theme: ThemeData(
              textTheme: Theme.of(context).textTheme.apply(
                bodyColor: model.textColor,
                displayColor: model.textColor
              ),
              primaryColor: model.primaryColor,
              accentColor: model.accentColor,
              appBarTheme: AppBarTheme(
                backgroundColor: model.backgroundColor
              ),
              scaffoldBackgroundColor: model.backgroundColor,
              iconTheme: IconThemeData(
                color: model.textColor
              ),
              shadowColor: Color.fromARGB(30, 0, 0, 0)
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
