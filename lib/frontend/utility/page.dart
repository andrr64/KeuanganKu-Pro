import 'package:flutter/material.dart';

void openPage(BuildContext context, Widget widget){
  Navigator.push(context, MaterialPageRoute(builder: (context){
    return widget;
  }));
}

void closePage(BuildContext context){
  Navigator.pop(context);
}

void changePage(BuildContext context, Widget widget){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget));
}