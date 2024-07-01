import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';

Drawer drawer (BuildContext context){
  return Drawer(
    backgroundColor: Colors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        dummyHeight(vh(context, 7.5)),
        const Text('KeuanganKu Pro'),
        dummyHeight(20),
        const Text('Mama Mia')
      ],
    ),
  );
}