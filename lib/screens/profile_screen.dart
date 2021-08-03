import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:register_login/models/CurrentUser.dart';
import 'package:register_login/services/api_service.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'user_info';  

  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    APIService apiServiceProvider=Provider.of<APIService>(context,listen: false);
    CurrentUser currentUser=apiServiceProvider.getCurrentUser ?? CurrentUser(
                                                              firstName: '', 
                                                              lastName: '', 
                                                              avatarUrl: '', 
                                                              displayName: ''
                                                            );
    

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(
              height: 200,
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: CircleAvatar(
                        child: ClipOval(
                          child: currentUser.avatarUrl!=''
                            ? Image.network(
                                '${currentUser.avatarUrl}',
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              )
                            : Icon(Icons.people,size:50),
                            
                        ),
                        radius: 50,
                      ),
                    ),
                    
                    Text('${currentUser.displayName}'),
                  ],
                ),
              ),
              
            ),
            Divider(            
            ),
            Text('${currentUser.firstName}'),
            SizedBox(height: 12,),
            Text('${currentUser.lastName}'),
            
            
          ],
        ),
      ),
      
    );
  }
}