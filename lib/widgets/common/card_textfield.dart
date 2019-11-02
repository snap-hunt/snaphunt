import 'package:flutter/material.dart';

class CardTextField extends StatelessWidget {
  final String label;
  final Widget widget;

  const CardTextField({
    Key key,
    this.label,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 2.0,
      ),
      height: 60,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 3,
        child: Container(
          margin: EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(label),
                ),
              ),
              const VerticalDivider(
                width: 10,
                thickness: 1,
              ),
              Expanded(
                flex: 5,
                child: Container(
                  child: widget,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
