import 'package:flutter/material.dart';

class GerenciaProdutoWidget extends StatelessWidget {
  final String title;
  final Widget widget;
  final AlignmentGeometry alignment;

  const GerenciaProdutoWidget(
      {Key key, this.title, this.widget, this.alignment})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: alignment,
        // color: Colors.brown,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            Expanded(
              child: widget,
            ),
          ],
        ),
      ),
    );
  }
}
