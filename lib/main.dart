import 'package:book_catalogue_app/firebase_options.dart';
import 'package:book_catalogue_app/helpers/constant/colors.dart';
import 'package:book_catalogue_app/helpers/provider/book_catalogue_provider.dart';
import 'package:book_catalogue_app/helpers/routes/route.dart';
import 'package:book_catalogue_app/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => BookCatalogueProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final window = ui.Window.instance;
    final windowBinding = WidgetsBinding.instance.platformDispatcher;
    MediaQueryData windowData =
        MediaQueryData.fromView(windowBinding.views.single);
    windowData = windowData.copyWith(
      textScaler: const TextScaler.linear(1.0),
    );

    return MediaQuery(
        data: windowData,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Book Catalogue',
          theme: ThemeData(
            useMaterial3: false,
            fontFamily: 'Abel',
            scaffoldBackgroundColor: Colors.black,
            unselectedWidgetColor: AppColors.secondButtonColor,
            primarySwatch: colorCustom,
            primaryColor: colorCustom,
          ),
          home: const Splash(),
          onGenerateRoute: RouteHelper().generateRoute,
        )
    );
  }
}
