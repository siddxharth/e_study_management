import 'package:e_study_management/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:e_study_management/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller for email and password fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // firebase auth
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      // validator
      onSaved: (value) {
        emailController.text = value!;
      },
      validator: (value) {
        if (value!.isEmpty){
          return ("Please enter your email");
        }
        // RegExp for Email Text Validation - not necessary but useful
        // if(!RegExp("^a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value )){
        //   return ("Please enter a valid email");
        // }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          // labelText: "Email",
          hintText: "Email",
          prefixIcon: const Icon(Icons.email),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      // validator
      onSaved: (value) {
        passwordController.text = value!;
      },
      validator: (value){
        RegExp regexp = RegExp(r'^.{6,}$');
        if(value!.isEmpty){
          return ("Please enter your password");
        }
        if(!regexp.hasMatch(value)){
          return ("Minimum 6 character password required.");
        }
        return null;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          hintText: "Password",
          prefixIcon: const Icon(Icons.password),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    final loginButton = TextButton(
      style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    primary: Colors.white,
                    backgroundColor: Colors.green,
                    textStyle: const TextStyle(fontSize: 20,),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    )
      ),
      onPressed: () { logIn(emailController.text, passwordController.text); },
      child: const Text("Login"),
      );

    //Return the email and password TextFields, plus the Login Button in a Scaffold
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(45),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 200,
                      // width: 200,
                      child: SvgPicture.asset("assets/logo.svg"),
                      // fit: BoxFit.contain,
                    ),
                    const SizedBox(
                      height: 45,
                    ), 
                    emailField, 
                    const SizedBox(
                      height: 10,
                    ),passwordField, 
                    const SizedBox(
                      height: 12,
                    ),
                    loginButton,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationScreen()));},
                          child: const Text("Sign Up"),
                          style: TextButton.styleFrom(
                            splashFactory: NoSplash.splashFactory,
                            enableFeedback: true,
                            primary: Colors.green,
                            padding: const EdgeInsets.all(0),
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                            )
                          )
                        )
                      ],
                    )],
                ),
              ),
            ),
          ),
        ));
  }

  //login function - firebase
  void logIn(String email, String password) async{
    if(_formKey.currentState!.validate()){
      await _auth.signInWithEmailAndPassword(email: email, password: password)
        .then((uid) => {
          Fluttertoast.showToast(msg: "Successfully logged in!"),
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()))
        }).catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
    }
  }
}
