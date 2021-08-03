import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:register_login/models/CurrentUser.dart';
import 'package:register_login/models/user.dart';

const _rootApi='https://treecampus.dgtlmart.com/api/';

bool _isUserLoggedIn =false;
// CurrentUser _currentUser=CurrentUser(
//   firstName: '', 
//   lastName: '', 
//   avatarUrl: '', 
//   displayName: ''
// );
CurrentUser? _currentUser;
class APIService extends ChangeNotifier{

  void setUser(){
    // _currentUserId=userID;
    _isUserLoggedIn=true;
    notifyListeners();
  }
  bool get isUserLoggedIn => _isUserLoggedIn;
  CurrentUser? get getCurrentUser=> _currentUser;

  static Future signUpUser(User _user) async{
    final registerUrl=Uri.parse(_rootApi+'user/register/');   
    
    try{
      final _nonce = await APIService.getNonce(method:'register');
      if(_nonce['status']=='ok'){
        Map userData = {
          'first_name': _user.firstName,
          'last_name':_user.lastName,
          'username': _user.userName,
          'email': _user.email,
          'password': _user.password,
          'nonce': _nonce['nonce'],
        };
        http.Response response= await http.post(registerUrl,body: userData);
        var data=jsonDecode(response.body);
        print(data);
        return data;
      }
    }catch(e){
      print(e);
    }

  }

  

  static Future signInUser({required String email,required String password}) async{
    // final loginUrl = Uri.parse(_rootApi + 'user/register/');

    try {
      final data=await APIService.getAuthCookie(email: email, password: password);
      // print(data);
      return data;
    } catch (e) {
      
      print(e);
    }

  }

  static Future getAuthCookie({required String email,required String password}) async {
    
    try {
      final _nonce = await APIService.getNonce(method: 'generate_auth_cookie');

      final _authCookieUrl = Uri.parse(_rootApi +
          'user/generate_auth_cookie/?nonce=${_nonce['nonce']}&email=$email&password=$password&insecure=cool');
      print(_authCookieUrl);
      http.Response response = await http.post(_authCookieUrl);
      
      var data = jsonDecode(response.body);
      return data;
    } catch (e) {
      
      print(e);
    }
  }
  static Future getNonce({required String method}) async {
    final _nonceUrl = Uri.parse(
      _rootApi + 'get_nonce/?json=core.get_nonce&controller=user&method=$method');
    try {
      http.Response response = await http.get(_nonceUrl);
      var data = jsonDecode(response.body);
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future setCurrentUser(String userID)async {
    try{
      final _userInfoUrl=Uri.parse(_rootApi+'user/get_userinfo/?user_id=$userID');
      http.Response response = await http.get(_userInfoUrl);
      if(response.statusCode==200)
      {
        var data = jsonDecode(response.body);
        if(data['status']=='ok')
        {
          _currentUser = CurrentUser(
            firstName: data['firstname'],
            lastName: data['lastname'],
            avatarUrl: data['avatar'],
            displayName: data['displayname'],
          );
          notifyListeners();
        }
      }else{
        throw 'Error while fetching data';
      }
    }catch(e){
      print('User Id required');
    }  
  }

}