
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:register_login/services/api_service.dart';
import 'package:register_login/models/user.dart';
import 'package:register_login/models/validator_model.dart';
import 'package:register_login/screens/sign_in_screen.dart';
import 'package:register_login/widgets/text-input-widget.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}


class _SignUpScreenState extends State<SignUpScreen> {
  
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordTextController =TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();


  final _formKey = GlobalKey<FormState>();

  bool _passwordVisibility = false;

  @override
  Widget build(BuildContext context) {
    APIService signUpProvider=Provider.of<APIService>(context,listen: false);
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
                        'Sign Up',
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
                            height: MediaQuery.of(context).size.height * 0.80,
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
                            child: buildRegistrationForm(context, signUpProvider),
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

  Form buildRegistrationForm(BuildContext context, APIService signUpProvider) {
    return Form(
      key: _formKey,

      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        children: [          
          const SizedBox(
            height: 12,
          ),
          TextInputWidget(
            hintText: 'First name',
            labelText: 'First name',
            controller: _firstNameController,
            // prefixIcon: Icon(Icons.),
            validator: (value){
              if(value==''|| value==null)
                return 'Enter first name';
            },
          ),
          const SizedBox(
            height: 12,
          ),
          TextInputWidget(
            hintText: 'Last Name',
            labelText: 'Last Name',
            controller: _lastNameController,
            // prefixIcon: Icon(Icons.),
          ),
          const SizedBox(
            height: 12,
          ),
          TextInputWidget(
            hintText: 'Username',
            labelText: 'UserName',
            controller: _usernameController,
            // prefixIcon: Icon(Icons.),
            validator: (value){
              if(value==''|| value==null)
                return 'Enter UserName';
            },
          ),
          const SizedBox(
            height: 12,
          ),
          TextInputWidget(
            hintText: 'E-mail',
            labelText: 'E-mail',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: Validator.validateEmail,
            prefixIcon: Icon(Icons.email_outlined,size:16),

          ),
          const SizedBox(
            height: 12,
          ),
          TextInputWidget(
            hintText: 'Password',
            labelText: 'Password',
            controller: _passwordController,
            obscureText: !_passwordVisibility,
            validator: Validator.validatePassword,
            suffixIcon: buildVisibilityWidget(),
            prefixIcon: Icon(Icons.lock_outline, size: 16),

          ),
          const SizedBox(
            height: 12,
          ),
          TextInputWidget(
            hintText: 'Confirm password',
            labelText: 'Confirm password',
            controller: _confirmPasswordTextController,
            obscureText: !_passwordVisibility,
            validator: (value) {
              return Validator.validateConfirmPassword(
                  value, _passwordController.text);
            },
            suffixIcon: buildVisibilityWidget(),
            prefixIcon: Icon(Icons.lock_outline, size: 16),

          ),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
            onPressed: () async {
              showLoaderDialog(context);
              try {
                if (_formKey.currentState!.validate()) {
                  final data=await APIService.signUpUser(
                    User(
                      firstName: _firstNameController.value.text,
                      lastName: _lastNameController.value.text,
                      userName: _usernameController.value.text ,
                      email: _emailController.value.text, 
                      password: _passwordController.text,
                    ),
                  );
                  if(data['status']=='ok'){
                    signUpProvider.setUser();
                    await signUpProvider.setCurrentUser(data['user_id'].toString());
                    setState(() { });
                    Navigator.pop(context);
                  }else{
                    buildToast(text: data['error']);
                  }
                  Navigator.pop(context);
                  
                } else {
                  Navigator.pop(context);
                }
              }catch (e) {
                Navigator.pop(context);
                print(e);
              }
            },
            child: Text(
              'Sign Up',
              style: TextStyle(fontSize: 14),
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
                  text: 'Already have an account?',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 11,
                  ),
                  children: [
                    TextSpan(
                      text: '\nSign In',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print('Go to Login Screen');
                          Navigator.pushReplacementNamed(context, SignInScreen.id);
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

  void buildToast({required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }
}

// color: Color(0xff1B3664),