import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({
    @required this.colour,
    this.cardChild,
    this.onPress,
  });

  final Color colour;
  final Widget cardChild;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 110.0,
        child: cardChild,
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
