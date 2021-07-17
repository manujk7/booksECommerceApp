import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_e_commerce/notifiers/BookQuantity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Authentication/authenication.dart';
import 'Payment/paymentDetailsaPage.dart';
import 'package:book_e_commerce/Config/config.dart';
import 'Store/store.dart';
import 'notifiers/cartitemcounter.dart';
import 'Store/myOrders.dart';
import 'notifiers/changeAddresss.dart';
import 'notifiers/totalMoney.dart';
import 'Store/storehome.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EcommerceApp.sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  EcommerceApp.auth = FirebaseAuth.instance;
  EcommerceApp.firestore = FirebaseFirestore.instance;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CartItemCounter()),
          ChangeNotifierProvider(create: (_) => BookQuantity()),
          ChangeNotifierProvider(create: (_) => AddressChanger()),
          ChangeNotifierProvider(create: (_) => TotalAmount()),
        ],
        child: MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Colors.green,
            ),
            home: SplashScreen()));
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    Timer(Duration(seconds: 2), () async {
      if (await EcommerceApp.auth.currentUser != null) {
        Route newRoute = MaterialPageRoute(builder: (_) => Store());
        Navigator.pushReplacement(context, newRoute);
      } else {
        /// Not SignedIn
        Route newRoute = MaterialPageRoute(builder: (_) => AuthenticScreen());
        Navigator.pushReplacement(context, newRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/books.png'),
              Text('Welcome to Book Store'),
            ],
          ),
        ),
      ),
    );
  }
}
