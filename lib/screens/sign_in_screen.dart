import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:register_login/models/validator_model.dart';
import 'package:register_login/screens/home_screen.dart';
import 'package:register_login/screens/sign_up_screen.dart';
import 'package:register_login/services/api_service.dart';
import 'package:register_login/widgets/text-input-widget.dart';

class SignInScreen extends StatefulWidget {
  static const String id='login_screen';
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  // String? _emailText;
  // String? _passwordText;
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisibility = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.orange,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12))),
                  ),
                ],
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                body: CupertinoScrollbar(
                  isAlwaysShown: MediaQuery.of(context).viewInsets.bottom != 0,
                  radius: Radius.circular(30),
                  radiusWhileDragging: Radius.circular(30),
                  thickness: 20,
                  thicknessWhileDragging: 20,
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 74,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 22.0),
                            height: MediaQuery.of(context).size.height * 0.70,
                            width: MediaQuery.of(context).size.width * 0.84,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 4,
                                    blurRadius: 4,
                                    color: Colors.black38,
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: buildSignInForm(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Form buildSignInForm() {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        children: [          
          const SizedBox(
            height: 12,
          ),
          TextInputWidget(
            hintText: 'E-mail',
            labelText: 'E-mail',
            controller: _emailTextController,            
            keyboardType: TextInputType.emailAddress,
            validator: Validator.validateEmail,
            prefixIcon: Icon(Icons.email_outlined,size: 16,),
          ),
          const SizedBox(
            height: 12,
          ),
          TextInputWidget(
            hintText: 'Password',
            labelText: 'Password',
            controller: _passwordTextController,            
            obscureText: !_passwordVisibility,
            suffixIcon: buildVisibilityWidget(),
            prefixIcon: Icon(Icons.lock_outline ,size: 16,),

          ),
          Container(
            padding: EdgeInsets.all(5.0),
            alignment: Alignment(1, 0),
            child: GestureDetector(
              // highlightColor: Colors.red,
              child: Text(
                'Forgot Password?',
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                print('Forgot Password');
              },
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          ElevatedButton(
            onPressed: () async {   
              showLoaderDialog(context);     
              try {
                if (_formKey.currentState!.validate()) {
                  final data=await APIService.signInUser(
                    email: _emailTextController.value.text, 
                    password: _passwordTextController.value.text,
                  );
                  print(data);
                  Navigator.pop(context);
                  
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context) => HomeScreen()));
                }else{
                  Navigator.pop(context);
                }
              } catch (e) {
                Navigator.pop(context);
                print(e);
              }
            },
            child: Text(
              'Sign In',
              style: TextStyle(fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                minimumSize: Size(double.infinity, 44),
                elevation: 6.0,
                onPrimary: Colors.white,
            ),
          ),
          Container(
            padding: EdgeInsets.all(5.0),
            alignment: Alignment(0, 1),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: 'Don\'t have an account?',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 11,
                  ),
                  children: [
                    TextSpan(
                      text: '\nCreate Account',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print('Go to Login Screen');
                          Navigator.pushReplacementNamed(context, SignUpScreen.id);
                        },
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  RawMaterialButton buildVisibilityWidget() {
    return RawMaterialButton(
      onPressed: () {
        setState(() {
          _passwordVisibility = !_passwordVisibility;
        });
      },
      child: _passwordVisibility
          ? Icon(Icons.visibility)
          : Icon(Icons.visibility_off),
      padding: EdgeInsets.all(0),
      constraints: BoxConstraints(
        maxWidth: 30,
      ),
      shape: CircleBorder(),
      splashColor: Colors.lightBlueAccent,
    );
  }

  void showLoaderDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                backgroundColor: Colors.transparent,
              ),
              Text(
                'Please wait...',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
