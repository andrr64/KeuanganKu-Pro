import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pageIndexProvider = StateProvider<int>((_) => 0);
final pageControllerProvider = StateProvider<PageController>((_) => PageController());
final mainPageScaffoldKeyProvider = StateProvider<GlobalKey<ScaffoldState>>((_) => GlobalKey<ScaffoldState>());
