import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  final void Function()? onPressed;
  const CircleIcon({super.key, required this.color, required this.icon, required this.size, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Icon(
          icon,
          color: Colors.black,
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: CircleBorder(),
            minimumSize: Size(size, size)),
      ),
    );
  }
}
