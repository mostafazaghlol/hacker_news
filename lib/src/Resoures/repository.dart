import 'dart:async';
import 'api_provider.dart';
import 'Db_provider.dart';
import '../Models/item_model.dart';
class Repository {
//  NewsDbAPI newsAPI = NewsDbAPI();
//  API_PROVIDER api_provider = API_PROVIDER();
  List<Source> sources = [
    NewsDbAPIObject,
    API_PROVIDER(),
  ];
  List<cache> caches = [
    NewsDbAPIObject,
  ];


  Future<List<int>> fetchTopIds(){
    return sources[1].fetchTopIds();
  }

  Future<item_model> fetchItem(int id) async{
    item_model mitem_model;
    Source source;
    for(source in sources){
      mitem_model = await source.fetchItem(id);
      if(mitem_model != null){
        break;
      }
    }
    for(var cache in caches){
      cache.addItem(mitem_model);
    }

    return mitem_model;
  }
}

abstract class Source {
  Future<item_model> fetchItem(int id);
  Future<List<int>> fetchTopIds();
}

abstract class cache{
  Future<int> addItem(item_model item);
}