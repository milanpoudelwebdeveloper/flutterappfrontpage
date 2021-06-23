// @dart=2.8
import 'package:flutter/material.dart';
import 'package:myapp/common_widgets/custom_raised_button.dart';

class FormSubmitButton extends CustomRaisedButton {
  FormSubmitButton(
      {@required String text, VoidCallback onPressed, @required Color color})
      : super(
          color: color,
          onPressed: onPressed,
          height: 44.0,
          borderRadius: 4.0,
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        );
}
