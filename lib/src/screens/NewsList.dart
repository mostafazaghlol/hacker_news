import 'package:flutter/material.dart';
import 'dart:async';
import '../blocs/stories_provider.dart';
import '../widgets/News_List_Tiles.dart';
import '../widgets/refresh.dart';
class NewsList extends StatelessWidget{
  Widget build(context){
    final bloc = StoriesProvider.of(context);
    bloc.fetchTopIds();
    return Scaffold(
      appBar: AppBar(
        title: Text("Top News"),
      ),
      body: buildList(bloc),
    );
  }
  Widget buildList(StoriesBloc bloc){
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context , AsyncSnapshot<List<int>> snapShot){
        if(!snapShot.hasData){
          return Center(child:CircularProgressIndicator(),) ;
        }else{
          return refresh(
           child:ListView.builder(
                itemCount: snapShot.data.length,
                itemBuilder: (context,int index){
                  bloc.fetchItem(snapShot.data[index]);
                  return News_List_Tiles(item_id: snapShot.data[index],);
                },
              )
          );
        }
      },
    );
  }
//good example of list view wait for future data.
//  Widget buildList() {
//    return ListView.builder(
//        itemCount:  1000,
//        itemBuilder: (context,int index){
//          return FutureBuilder(
//              future: getFuture(),
//              builder: (context,snapShot){
//                return snapShot.hasData ? Text('Im Visible at $index') :Text('Im not Visible');
//              });
//        });
//  }
//
//  getFuture() {
//    return Future.delayed(
//      Duration(microseconds: 500),
//      ()=>'hi');
//  }
}