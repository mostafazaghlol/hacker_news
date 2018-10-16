import 'package:flutter/material.dart';
class newsDetails extends StatelessWidget {
  final int id;
  newsDetails({this.id});
  Widget build(context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Text('$id'),
    );
  }
}