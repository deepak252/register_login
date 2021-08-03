import 'package:flutter/material.dart';
import 'package:register_login/widgets/navigation_drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';  
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          leading: Builder(
            builder: (context){
              return IconButton(
                padding: EdgeInsets.only(bottom: 8),
                icon: Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              );
            },
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Home',
            ),
          ),
          centerTitle: true,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          titleTextStyle: TextStyle(
            color: Colors.black,
          ),
          elevation: 6,
        ),
      ),
      drawer: NavigationDrawerWidget(),
    );
  }
}