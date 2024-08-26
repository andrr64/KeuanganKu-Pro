import 'package:flutter/cupertino.dart';

late final DEVICE_WIDTH;
late final DEVICE_HEIGHT;
bool _init = false;

void DEVICE_initData(BuildContext context){
  if (!_init){
    DEVICE_WIDTH = MediaQuery.of(context).size.width;
    DEVICE_HEIGHT = MediaQuery.of(context).size.height;
    _init = true;
  }
}