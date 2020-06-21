import 'package:flutter/material.dart';
import 'package:new_quiz_app/services/auth.dart';
import 'package:new_quiz_app/views/signin.dart';
import 'package:new_quiz_app/widgets/widgets.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  String name, email, password;
  bool isloading = false;
  signUp()async{
    if(_formKey.currentState.validate()) { 
      setState(() {
        isloading = true;
      });
     await _authService.signUpWithEmailAndPassword(email, password).then((val){
       if(val != null){ 
        setState(() {
        isloading = false;
       });
       Navigator.push( context,
       MaterialPageRoute(builder: (context) => SignIn()),
        );
       }
     });
    }
  }
  @override
  Widget build(BuildContext context) {
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
                validator: (val){ return val.isEmpty ? "Enter Name" : null;},
                decoration: InputDecoration(
                  hintText: "Name"
                ),
                onChanged: (val){
                  name = val; 
                },
              ),
              TextFormField(
                validator: (val){ return val.isEmpty ? "Enter EmailId" : null;},
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
                  signUp();
                  //  Navigator.push( context,
                  //  MaterialPageRoute(builder: (context) => SignIn()),
                  //  );
                 },
                  child: Container(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                     borderRadius: BorderRadius.circular(30)),
                     width: MediaQuery.of(context).size.width,
                     child: Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                      Text('Already have an account? ', style: TextStyle(color: Colors.black87, fontSize: 15)),
                              GestureDetector(
                                 onTap: () {
                                  // widget.toogleView();
                                    Navigator.push( context,
                                    MaterialPageRoute(builder: (context) => SignIn()),
                                  );
                                },
                                child: Text('Sign In', style: TextStyle(color: Colors.red, fontSize: 15, 
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


