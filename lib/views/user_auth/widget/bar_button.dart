import 'package:flutter/material.dart';

class BarButton extends StatelessWidget {
  const BarButton({
    super.key,
    required this.onPressed,
    required this.setText,
  });

  final String setText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: SizedBox(
          height: 40,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              onPressed();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
            ),
            child: Text(setText),
          )),
    );
  }
}
