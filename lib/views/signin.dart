import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_quiz_app/services/auth.dart';
import 'package:new_quiz_app/views/home.dart';
import 'package:new_quiz_app/views/signup.dart';
import 'package:new_quiz_app/widgets/widgets.dart';


class SignIn extends StatefulWidget {
  // final Function toogleView;

  // SignIn({this.toogleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email, password;
  bool isloading = false;
  signIn() async{
    if(_formKey.currentState.validate()) { 
      setState(() {
        isloading = true;
      });
     await _authService.signInWithEmailAndPass(email, password).then((val){
       if(val != null){ 
        setState(() {
        isloading = false;
       });
       Navigator.push( context,
       MaterialPageRoute(builder: (context) => Home()),
        );
       }
     });
    }
  }
  // TextEditingController emailEditingController = new TextEditingController();
  // TextEditingController passwordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),

      body: isloading? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) :Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Spacer(),
              TextFormField(
                validator: (val){ return val.isEmpty ? "Enter Email Id" : null;},
                decoration: InputDecoration(
                  hintText: "Email"
                ),
                onChanged: (val){
                  email = val; 
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                obscureText: true,
                validator: (val){ return val.isEmpty ? "Enter Password" : null;},
                decoration: InputDecoration(
                  hintText: "Password"
                ),
                onChanged: (val){
                  password = val; 
                },
              ),
              SizedBox(height: 24,),
              GestureDetector(
                 onTap: () {
                    // widget.toogleView();
                    signIn();
                    //  Navigator.push( context,
                    //  MaterialPageRoute(builder: (context) => Home()),
                    //  );
                   },
                  child: Container(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    
                    color: Colors.blue,
                     borderRadius: BorderRadius.circular(30)),
                     width: MediaQuery.of(context).size.width,
                     child: Text(
                        "Sign In",
                        style: TextStyle(fontSize: 16, color: Colors.white,),
                        textAlign: TextAlign.center,
                  ),
                  
                ),
              ),
              SizedBox(height: 18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                      Text('Don\'t have an account? ', style: TextStyle(color: Colors.black87, fontSize: 15)),
                              GestureDetector(
                                onTap: () {
                    // widget.toogleView();
                     Navigator.push( context,
                     MaterialPageRoute(builder: (context) => SignUp()),
                     );
                   },
                     child: Text('Sign Up', style: TextStyle(color: Colors.red, fontSize: 15, 
                     decoration: TextDecoration.underline)),
                      ),
                ]
              ),
              SizedBox(height: 80,),
            ]
          ),
        )
      ),
    );
  }
}