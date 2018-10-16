import 'dart:async';

import 'package:flutter/material.dart';

import '../Models/item_model.dart';
import '../blocs/stories_provider.dart';
import 'loading_Container_widger.dart';
import 'refresh.dart';
class News_List_Tiles extends StatelessWidget {
  final int item_id;

  News_List_Tiles({this.item_id});

  Widget build(context) {
    final bloc = StoriesProvider.of(context);
    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<item_model>>> snapshot) {
        if (!snapshot.hasData) {
          return loding_container_widget();
        }

        return FutureBuilder(
          future: snapshot.data[item_id],
          builder: (context, AsyncSnapshot<item_model> itemSnapShot) {
            if(!itemSnapShot.hasData) {
              return loding_container_widget();
            }else {
              return buildTile(context, itemSnapShot.data);
            }
          },
        );
      },
    );
  }
  
  Widget buildTile(BuildContext context,item_model item){
    return Column(
      children: <Widget>[
        ListTile(
          onTap: (){
            Navigator.pushNamed(context, '/${item.id}');
          },
          title: Text(item.title),
          subtitle: Text("${item.score} points"),
          trailing: Column(
            children: <Widget>[
              Icon(Icons.comment),
              Text('${item.descendants}')
            ],
          ),
        ),
        Divider(height: 8.0,)
      ],
    );
  }
}
