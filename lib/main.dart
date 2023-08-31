import 'package:flutter/material.dart';
//import 'package:flutter/src/material/colors.dart;
import 'detail_audio_page.dart';
import 'login.dart';
import 'my_home_page.dart';

void main(){
  runApp(Myapp());
}

class Myapp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: "stories player",
      theme: ThemeData(
         primarySwatch: Colors.cyan,
      ),
      home:  LoginPage(),
    );
  }
}


