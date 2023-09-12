import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/note/note_provider.dart';
import 'package:todo_app/views/splash_screen/splash_screen.dart';

import 'db/notes_database.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Notes SQLite';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => NoteProvider(),),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          themeMode: ThemeMode.dark,
          theme: ThemeData(
            primaryColor: Colors.black,
            scaffoldBackgroundColor: Colors.blueGrey.shade900,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
          home: const SplashScreen(),
        ),
      );
}
