import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:register_login/constants.dart';
import 'package:register_login/screens/home_screen.dart';
import 'package:register_login/screens/sign_in_screen.dart';
import 'package:register_login/screens/sign_up_screen.dart';
import 'package:register_login/screens/profile_screen.dart';
import 'package:register_login/services/api_service.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<APIService>(create: (_)=>APIService()),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: kLightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context)=>HomeScreen(),
        SignInScreen.id: (context)=>SignInScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        ProfileScreen.id:(context)=> ProfileScreen(),
      },   
    );
  }
}
