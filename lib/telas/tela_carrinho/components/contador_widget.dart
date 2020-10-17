import 'package:flutter/material.dart';

import 'qtd_widget_button.dart';

class CobtadorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.cyan,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          QtdWidgetButton(
            onTap: () {},
            child: Text(
              '−',
              style: TextStyle(fontSize: 25),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text('12'),
              decoration: BoxDecoration(
                border: Border.symmetric(
                  vertical: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
          QtdWidgetButton(
            onTap: () {},
            child: Text(
              '+',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
