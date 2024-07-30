import 'package:flutter/material.dart';

Widget kFutureBuilder<T>({
  required Future<T> futureFunction,
  required Widget Function(Object? err) wxWhenError,
  required Widget Function(T) wxWhenSuccess,
  required Widget wxWhenWaiting,

}){
  return FutureBuilder(
      future: futureFunction,
      builder: (_, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting){
          return wxWhenWaiting;
        } else if (snapshot.hasError){
          return wxWhenError(snapshot.error);
        } else {
          return wxWhenSuccess(snapshot.data as T);
        }
      });
}