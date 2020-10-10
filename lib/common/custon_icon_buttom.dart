import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {

  final IconData iconData;
  final Color color;
  final VoidCallback onTap;

  const CustomIconButton({Key key, this.iconData, this.color, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(
              iconData,
              color:color
              
            ),
          ),
        ),
      ),
    );
  }
}