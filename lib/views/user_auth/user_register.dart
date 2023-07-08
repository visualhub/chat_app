import 'package:chap_app/utils/app_snack_bar.dart';
import 'package:chap_app/views/user_auth/widget/bar_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'widget/input_text_field.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({super.key});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final _nameControlLer = TextEditingController();
  final _emailController = TextEditingController();
  final _newPasscontroller = TextEditingController();
  final _conPasscontroller = TextEditingController();

  bool _showPassword = false;

  void _signUp() async {
    if (_nameControlLer.text.isEmpty) {
      AppSnackBar.showSnackBar(
        context,
        message: 'Please Enter Your Full Name',
      );
    } else if (_emailController.text.isEmpty) {
      AppSnackBar.showSnackBar(
        context,
        message: 'Please Enter Your Email',
      );
    } else if (_newPasscontroller.text.isEmpty) {
      AppSnackBar.showSnackBar(
        context,
        message: 'Please Enter Your Password',
      );
    } else if (_conPasscontroller.text.isEmpty) {
      AppSnackBar.showSnackBar(
        context,
        message: 'Please Enter Confirm Password',
      );
    } else if (_newPasscontroller.text != _conPasscontroller.text) {
      AppSnackBar.showSnackBar(
        context,
        message: 'Confirm Password Does Not Match',
      );
    } else {
      try {
        UserCredential credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _newPasscontroller.text,
        );
        await _writeToDatabase(credential.user!.uid);
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } on FirebaseAuthException catch (error) {
        AppSnackBar.showSnackBar(
          context,
          message: error.message ?? 'Something Went Wrong',
        );
      }
    }
  }

  Future<void> _writeToDatabase(String uid) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'uid': uid,
        'name': _nameControlLer.text,
        'email': _emailController.text,
        'image': '',
      });
    } on FirebaseException catch (error) {
      debugPrint(error.message);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _conPasscontroller.dispose();
    _emailController.dispose();
    _nameControlLer.dispose();
    _newPasscontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Registration',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Please register down below',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  InputTextField(
                      isCapital: true,
                      hintText: 'Full name',
                      icon: Icons.co_present_sharp,
                      controller: _nameControlLer),
                  InputTextField(
                      hintText: 'Email',
                      icon: Icons.email,
                      controller: _emailController,
                      isEmail: true),
                  InputTextField(
                    hintText: 'Password',
                    icon: Icons.password,
                    controller: _newPasscontroller,
                    isPassword: true,
                    hideInputText: !_showPassword,
                    onEyeTap: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  ),
                  InputTextField(
                    hintText: 'Confirm password',
                    icon: Icons.password,
                    controller: _conPasscontroller,
                    isPassword: true,
                    hideInputText: !_showPassword,
                    onEyeTap: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  ),
                  BarButton(
                    onPressed: _signUp,
                    setText: 'SIGN UP',
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(fontSize: 11),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 11.9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }
}
