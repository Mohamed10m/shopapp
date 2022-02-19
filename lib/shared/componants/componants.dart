import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required String label,
  required TextInputType type,
  required FormFieldValidator<String> validate,
  required IconData prefix,
  bool obSecureText = false,
  IconData? suffix,
  Function? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      validator: validate,
      obscureText: obSecureText,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(suffix))
            : null,
      ),
    );

Widget defaultMaterialButton({
  required String text,
  required Function onPressed,
  double? height,
  double width = double.infinity,
  Color backgroundColor = Colors.blue,
  double radius = 3.0,
  bool isUpperCase = false,
}) =>
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.blue,
      ),
      child: MaterialButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => widget), (route) {
      return false;
    });

void showToast({required String text, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
