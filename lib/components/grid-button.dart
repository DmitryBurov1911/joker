import 'package:flutter/material.dart';

class GridButton extends StatelessWidget {
  VoidCallback click;
  String text;

  GridButton(this.text, this.click);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: GestureDetector(
        onTap: click,
        child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/number.png")
                )
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink[100]
                ),
              ),
            )
        ),
      ),
    );
  }
}