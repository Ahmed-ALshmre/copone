import 'package:admin_copon/utiletes/tools.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'appData/appData.dart';
import 'classMuilteN.dart';
import 'homescreen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EcommerceApp.sharedPreferences = await SharedPreferences.getInstance();
  EcommerceApp.firestore = Firestore.instance;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<MultipleNotifier>(
          create: (_) => MultipleNotifier([], [], [], []),
        ),
        ChangeNotifierProvider<AppData>(
          create: (_) => AppData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xff221D71),
        ),
        home: HomeScreen(),
      ),
    ),
  );
}
