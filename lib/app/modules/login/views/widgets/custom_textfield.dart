import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final IconData? data;
  final String? hintText;
  //final String? label;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  bool? isObscure = true;
  bool? enabled = true;

  CustomTextField({
    Key? key,
    this.controller,
    this.data,
    this.hintText,
    //this.label,
    this.inputFormatters,
    this.validator,
    this.isObscure,
    this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffF2F6FE),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(5),
      child: TextFormField(
        style: const TextStyle(
            color: Colors.black, overflow: TextOverflow.ellipsis),
        enabled: enabled,
        controller: controller,
        obscureText: isObscure!,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            data,
            color: Colors.cyan,
          ),
          focusColor: Theme.of(context).primaryColor,
          hintText: hintText,
          //label: Text(label!),
        ),
        inputFormatters: inputFormatters,
        validator: validator,
      ),
    );
  }
}