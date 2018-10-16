import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../Models/item_model.dart';
import '../Resoures/repository.dart';

class StoriesBloc {
  final _topIds = PublishSubject<List<int>>();
  final _repository = Repository();
  final _itemsOutputs = BehaviorSubject<Map<int, Future<item_model>>>();
  final _itemsFetchers = PublishSubject<int>();

  Observable<List<int>> get topIds => _topIds.stream;
  Observable<Map<int, Future<item_model>>> get items => _itemsOutputs.stream;

  Function(int) get fetchItem => _itemsFetchers.sink.add;

  //Constructors
  StoriesBloc() {
    _itemsFetchers.stream.transform(_itemTransfromer()).pipe(_itemsOutputs);
  }

  //add data to sink
  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  clearCache() async{
    return await _repository.clearCache();
  }

  //ScanStreamTransform
  _itemTransfromer() {
    return ScanStreamTransformer(
        (Map<int, Future<item_model>> cache, int id, index) {
      print(index);
      cache[id] = _repository.fetchItem(id);
      return cache;
    }, <int, Future<item_model>>{});
  }

  dispose() {
    _topIds.close();
    _itemsOutputs.close();
    _itemsFetchers.close();
  }
}
