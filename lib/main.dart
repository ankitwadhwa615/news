import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:inshort_clone/controller/provider.dart';
import 'package:inshort_clone/controller/theme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var docPath = await getApplicationDocumentsDirectory();

  Hive.init(docPath.path);

  await Hive.openBox('themeMode');

  var _isDarkModeOn = await Hive.box('themeMode').get('isDarkModeOn');

  ThemeProvider().darkTheme(_isDarkModeOn ?? false);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ChangeNotifierProvider<FeedProvider>(create: (_) => FeedProvider()),
      ],
      child: App(),
    ),
  );
}