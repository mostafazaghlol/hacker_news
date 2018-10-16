import 'package:flutter/material.dart';
import 'comments_bloc.dart';
export 'comments_bloc.dart';

class commentsProvider extends InheritedWidget{
  final commentsBolc bloc;

  commentsProvider({Key key,Widget child})
      :bloc = commentsBolc(),
        super(key:key,child:child);
  bool updateShouldNotify(_) => true;
  static commentsBolc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(commentsProvider)as commentsProvider).bloc;
  }
}
