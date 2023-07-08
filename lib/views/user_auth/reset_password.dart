import 'package:chap_app/views/user_auth/widget/bar_button.dart';
import 'package:chap_app/views/user_auth/widget/input_text_field.dart';

import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _newPasscontroller = TextEditingController();
  final _conPasscontroller = TextEditingController();

  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _newPasscontroller.dispose();
    _conPasscontroller.dispose();
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
                    'Reset password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Please enter new password',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  InputTextField(
                    hintText: 'New password',
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
                  const SizedBox(
                    height: 15,
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
                  const SizedBox(
                    height: 45,
                  ),
                  BarButton(
                    onPressed: () {},
                    setText: 'RESET PASSWORD',
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
