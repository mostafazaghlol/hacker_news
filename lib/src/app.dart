import 'package:flutter/material.dart';

import 'blocs/stories_provider.dart';
import 'blocs/comments_provider.dart';
import 'screens/NewsList.dart';
import 'screens/NewsDetalis.dart';

class MyApp extends StatelessWidget {
  Widget build(context) {
    return commentsProvider(
      child:StoriesProvider(
          child: MaterialApp(
            title: 'News APP !',
            onGenerateRoute: routs,
          )
      ) ,
    );
    }


  Route routs(RouteSettings settings){
    if(settings.name == '/'){
      return MaterialPageRoute(
        builder: (context){
          return NewsList();
        },
      );
    }else{
      return MaterialPageRoute(
        builder: (context){
          int itemid = int.parse(settings.name.replaceFirst('/', ''));
          commentsBolc bolc = commentsProvider.of(context);
          bolc.fetchitemswithcomments(itemid);
          return newsDetails(id:itemid);
        },
      );
    }
  }


}
