import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UiHelper{
  customTF(double border , TextEditingController controller,String text,IconData iconData){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(border),),
          hintText: text,
          suffixIcon: Icon(iconData)
        ),
      ),
    );
  }
}