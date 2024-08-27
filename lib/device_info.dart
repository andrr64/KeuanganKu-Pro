import 'package:flutter/cupertino.dart';

double DEVICE_WIDTH = 0;
double DEVICE_HEIGHT = 0;
bool _init = false;

void DEVICE_initData(BuildContext context){
  if (!_init){
    DEVICE_WIDTH = MediaQuery.of(context).size.width;
    DEVICE_HEIGHT = MediaQuery.of(context).size.height;
    _init = true;
  }
}