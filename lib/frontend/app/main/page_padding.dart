import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';

Padding PagePadding(BuildContext context, {required Widget child}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: vh(context, 2.5),
      horizontal: vw(context, 5),
    ),
    child: child,
  );
}
