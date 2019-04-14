import 'dart:async';

import 'package:demo_tinder_app/homepage.dart';
import 'package:demo_tinder_app/newpolitician.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartScreenPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    NewPolitician np = new NewPolitician();
    new Timer(const Duration(seconds: 1), ()=> np.performPolitician(false, context, 'gwa', 'gwa'));

    return Scaffold(

    );
  }

}