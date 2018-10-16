import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';

class refresh extends StatelessWidget{
  final Widget child;
  refresh({this.child});
  Widget build(context){
    final bloc = StoriesProvider.of(context);
    return RefreshIndicator(
      child: child ,
      onRefresh: () async{
        await bloc.clearCache();
        await bloc.fetchTopIds();
    },);
  }
}