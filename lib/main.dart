import 'dart:math';

import 'package:flutter/material.dart';

import 'github_sign_in/github_sign_in.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if(!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
        child: SignInPage()
    );
  }
}