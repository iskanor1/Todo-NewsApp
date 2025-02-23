import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required VoidCallback function, // Use VoidCallback for no-argument functions
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit, // Use Function(String) for field submission
  Function(String)? onChange, // Use Function(String) for text changes
  VoidCallback? onTap, // Use VoidCallback for tap events
  bool isPassword = false,
  required FormFieldValidator<String> validate, // Use FormFieldValidator for validation
  required String label,
  required IconData prefix,
  IconData? suffix, // Make suffix nullable
  VoidCallback? suffixPressed, // Use VoidCallback for suffix press events
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(suffix),
        )
            : null,
        border: OutlineInputBorder(),
      ),
    );
Widget buildTaskItem(Map model) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      CircleAvatar(
        radius: 40.0,
        child: Text(
          '${model['title']}',

        ),

      ),
      SizedBox(
        width: 2.0,
      ),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${model['time']}',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${model['data']}',
            style: TextStyle(
              color: Colors.grey
            ),
          ),


        ],
      )
    ],
  ),
);