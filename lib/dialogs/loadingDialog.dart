import 'package:book_e_commerce/Widgets/loadingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingAlertDialog extends StatelessWidget {
  final String message;
  const LoadingAlertDialog({Key key, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          LoadingWidget(

          ),
          SizedBox(
            height: 10,
          ),
          Text('Please wait!! Loading...'),
        ],
      ),
    );
  }
}
