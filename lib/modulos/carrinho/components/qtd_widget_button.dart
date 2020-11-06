import 'package:flutter/material.dart';

class QtdWidgetButton extends StatelessWidget {
  final void Function() onTap;
  final Widget child;

  const QtdWidgetButton({Key key, this.onTap, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          // color: Colors.amber,
          child: child,
        ),
      ),
    );
  }
}
