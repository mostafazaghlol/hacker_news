import 'package:flutter/material.dart';

class loding_container_widget extends StatelessWidget{
  Widget build(context){
    return ListTile(
      title: container(),
      subtitle: container(),
    );
  }


  Widget container (){
    return Container(
      height: 8.0,
      margin: EdgeInsets.only(top: 10.0,bottom: 10.0),
    );
  }
}