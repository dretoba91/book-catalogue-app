// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:book_catalogue_app/helpers/constant/colors.dart';
import 'package:book_catalogue_app/helpers/constant/sizer.dart';
import 'package:book_catalogue_app/helpers/routes/route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // To remouve both top and bottom bar on splash screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed(RouteHelper.allBookRoute);
    });
  }

  @override
  void dispose() {
    super.dispose();
    // restoring the top and bottom bar after leaving the splash screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.secondButtonColor, AppColors.buttonColor],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu_book,
              size: sizer(true, 80, context),
              color: Colors.white,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '... be organised!!!',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
