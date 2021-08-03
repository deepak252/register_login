import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:register_login/screens/profile_screen.dart';
import 'package:register_login/screens/sign_in_screen.dart';
import 'package:register_login/services/api_service.dart';

class DrawerItem {
  final String title;
  final IconData icon;

  DrawerItem({required this.title, required this.icon});
}
bool? isUserLoggedIn;

class NavigationDrawerWidget extends StatelessWidget {
  final List<DrawerItem> drawerItemList = [
    isUserLoggedIn==true
    ? DrawerItem(title: 'Sign out', icon: Icons.logout)
    : DrawerItem(title: 'Sign in', icon: Icons.login),
    DrawerItem(title: 'Settings', icon: Icons.settings),
  ];

  @override
  Widget build(BuildContext context) {
    APIService apiServiceProvider=Provider.of<APIService>(context,listen: false);
    isUserLoggedIn=apiServiceProvider.isUserLoggedIn;

    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: Drawer(
        child: Container(
            decoration: BoxDecoration(
              // color: Colors.red[400],
            ),
            child: Column(
              children: <Widget>[
                buildHeader(context),
                Divider(
                  color: Colors.grey,
                ),
                buildDrawerItems(context: context),
                Spacer(),
              ],
            )),
      ),
    );
  }

  Widget buildDrawerItems({required BuildContext context}) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 12),
      shrinkWrap: true,
      primary: false,
      itemCount: drawerItemList.length,
      separatorBuilder: (context, index) => SizedBox(
        height: 4,
      ),
      itemBuilder: (context, index) {
        final item = drawerItemList[index];
        return buildDrawerItem(
            icon: item.icon,
            title: item.title,
            context: context,
            onPressed: () {
              
              onItemPressed(context, index);
            });
      },
    );
  }

  void onItemPressed(BuildContext context, int index) {
    Navigator.pop(context);
    switch (index) {
      case 0:
          isUserLoggedIn==true 
          ? null
          : Navigator.pushNamed(context, SignInScreen.id);
        break;
      case 1:
        
        break;
      default:
    }
  }

  Widget buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onPressed,
    required BuildContext context,
  }) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(children: [
                Icon(
                  icon,
                  size: 20,
                  color: Colors.black54,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black
                  ),
                ),
              ])),
        ));
  }

  Widget buildHeader(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap:isUserLoggedIn==true ?  () {
          Navigator.pop(context);
          Navigator.pushNamed(context,ProfileScreen.id);
        }
        : null,
        child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 30, bottom: 10),
            child: Column(
              children: [
                CircleAvatar(
                  child: Icon(Icons.people),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
