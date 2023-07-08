import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.onEyeTap,
    this.isEmail = false,
    this.isPassword = false,
    this.hideInputText = false,
    this.isCapital = false,
  });

  final TextEditingController controller;
  final String hintText;
  final bool isPassword, isEmail, hideInputText, isCapital;
  final IconData icon;
  final VoidCallback? onEyeTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: TextField(
                controller: controller,
                maxLength: 17,
                textCapitalization: isCapital
                    ? TextCapitalization.words
                    : TextCapitalization.none,
                keyboardType:
                    isEmail ? TextInputType.emailAddress : TextInputType.text,
                cursorColor: Colors.black,
                cursorHeight: 20,
                obscureText: hideInputText,
                decoration: InputDecoration(
                  counterText: '',
                  icon: Icon(
                    icon,
                    color: Colors.black,
                  ),
                  hintText: hintText,
                  border: InputBorder.none,
                ),
              ),
            ),
            if (isPassword)
              IconButton(
                onPressed: onEyeTap,
                icon: const Icon(Icons.visibility),
                splashRadius: 1,
              ),
          ],
        ),
      ),
    );
  }
}
