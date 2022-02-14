import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_study_management/models/user_model.dart';
import 'package:e_study_management/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameController,
      keyboardType: TextInputType.name,
      // validator
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          // labelText: "Email",
          hintText: "First Name",
          prefixIcon: const Icon(Icons.person),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      validator: (value) {
        RegExp regexp = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Please enter First Name");
        }
        if (!regexp.hasMatch(value)) {
          return ("Minimum 3 characters required");
        }
        return null;
      },
    );

    final lastNameField = TextFormField(
      autofocus: false,
      controller: lastNameController,
      keyboardType: TextInputType.name,
      // validator
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          // labelText: "Email",
          hintText: "Last Name",
          prefixIcon: const Icon(Icons.person),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      validator: (value) {
        RegExp regexp = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Please enter First Name");
        }
        if (!regexp.hasMatch(value)) {
          return ("Minimum 3 characters required");
        }
        return null;
      },
    );

    //Email Field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      // validator
      onSaved: (value) {
        emailController.text = value!;
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
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your email");
        }
        // RegExp for Email Text Validation - not necessary but useful
        // if(!RegExp("^a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value )){
        //   return ("Please enter a valid email");
        // }
        return null;
      },
    );

    // Password Field
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      // validator
      onSaved: (value) {
        passwordController.text = value!;
      },
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          hintText: "Password",
          prefixIcon: const Icon(Icons.password),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      validator: (value) {
        RegExp regexp = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Please enter your password");
        }
        if (!regexp.hasMatch(value)) {
          return ("Minimum 6 character password required.");
        }
        return null;
      },
    );

    final confirmPasswordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: confirmPasswordController,
      // validator
      onSaved: (value) {
        passwordController.text = value!;
      },
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          hintText: "Confirm Password",
          prefixIcon: const Icon(Icons.password),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      validator: (value) {
        if (value != confirmPasswordController.text) {
          return ("Passwords don't match");
        }
        return null;
      },
    );

    final registrationButton = TextButton(
      style: TextButton.styleFrom(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          primary: Colors.white,
          backgroundColor: Colors.green,
          textStyle: const TextStyle(
            fontSize: 20,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          )),
      onPressed: () {
        signUp(emailController.text, passwordController.text);
      },
      child: const Text("Register"),
    );

    const double _boxHeight =
        10; //Box Height for SizedBox inbetween the widgets in Scaffold
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: Colors.green,
          ),
        ),
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
                        // width: 100,
                        child: SvgPicture.asset("assets/logo.svg"),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      firstNameField,
                      const SizedBox(
                        height: _boxHeight,
                      ),
                      lastNameField,
                      const SizedBox(
                        height: _boxHeight,
                      ),
                      emailField,
                      const SizedBox(
                        height: _boxHeight,
                      ),
                      passwordField,
                      const SizedBox(
                        height: _boxHeight,
                      ),
                      confirmPasswordField,
                      const SizedBox(
                        height: _boxHeight,
                      ),
                      registrationButton,
                    ]),
              ),
            ),
          ),
        ));
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  void postDetailsToFirestore() async {
    // 1. Call firestore
    // 2. Call user model
    // 3. Send values to firestore
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();

    // Passing user details taken from the TextFields to the User Model
    userModel.email = user!.email;
    userModel.userId = user.uid;
    userModel.firstName = firstNameController.text;
    userModel.lastName = lastNameController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully!");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false);
  }
}
