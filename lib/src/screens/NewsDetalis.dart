import 'package:flutter/material.dart';
import '../blocs/comments_provider.dart';
import 'dart:async';
import '../Models/item_model.dart';
class newsDetails extends StatelessWidget {
  final int id;
  newsDetails({this.id});
  Widget build(context){
    final commentsBolc bloc = commentsProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(commentsBolc bloc) {
    return StreamBuilder(
      stream: bloc.itemswithComments,
      builder: (context,AsyncSnapshot<Map<int ,Future<item_model>>> snapshot){
          if(!snapshot.hasData){
            return Text('Loading');
          }

          Future<item_model> itemModel = snapshot.data[id];
          return FutureBuilder(
            future: itemModel,
            builder: (context,AsyncSnapshot<item_model> itemsnapshot){
              if(!itemsnapshot.hasData){
                return Text('Loading');
              }

              return Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top:20.0,bottom: 3.0),
                    child: Text(
                      itemsnapshot.data.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Text('${itemsnapshot.data.id}')
                ],
              );
            },
          );
      }
    );
  }
}