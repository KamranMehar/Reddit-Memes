import 'package:flutter/material.dart';
import 'package:shared_pref/pages/home.dart';
import 'package:shared_pref/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool? isLogin;
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
 //Compulsory to add
  SharedPreferences pref = await SharedPreferences.getInstance();
  print(pref.getBool("isLogin")==true.toString()+"________");
///If user already login to the app then open Home page else open login page
  isLogin=pref.getBool("isLogin")??false;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData( // This is the theme of your application.

        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: isLogin == false || isLogin == null ? "first" : "/",
      routes: {
        '/': (context)=>Home(),
        'first': (context)=>LoginPage(),
        },
    );
  }
}