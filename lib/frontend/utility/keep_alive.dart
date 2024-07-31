import 'package:flutter/material.dart';

class KeepAlivePage extends StatefulWidget {
  /// Class ini digunakan untuk mempertahankan state 'child'
  const KeepAlivePage({
    super.key, required this.child,
  });

  final Widget child;

  @override
  State<KeepAlivePage> createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}