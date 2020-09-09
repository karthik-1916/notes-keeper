import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String msg) {
  Scaffold.of(context).removeCurrentSnackBar();
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(msg),
  ));
}
