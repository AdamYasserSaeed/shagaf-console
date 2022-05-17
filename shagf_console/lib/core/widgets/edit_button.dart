import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  final Function()? onPress;
  final String? name;
  final Color? bgColor;
  final Color? txtColor;

  const EditButton(
      {Key? key, this.onPress, this.name, this.bgColor, this.txtColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 100,
      child: FlatButton(
        onPressed: onPress,
        color: bgColor ?? Colors.white,
        child: Text(
          name ?? 'no text',
          style: TextStyle(
              color: txtColor ?? Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
