import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../Models/item_model.dart';
import '../Resoures/repository.dart';
class commentsBolc {
  final _repository = Repository();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutputs = BehaviorSubject<Map<int,Future<item_model>>>();

  //streams
  Observable<Map<int,Future<item_model>>> get itemswithComments => _commentsOutputs.stream;

  //sinks
  Function(int) get fetchitemswithcomments =>_commentsFetcher.sink.add;

  commentsBolc(){
    _commentsFetcher.stream.transform(_streamTransformer())
        .pipe(_commentsOutputs);
  }

  dispose(){
    _commentsFetcher.close();
    _commentsOutputs.close();
  }

  _streamTransformer() {
    return ScanStreamTransformer<int,Map<int,Future<item_model>>>(
    (cache,int id,index){
      print(index);
      cache[id]= _repository.fetchItem(id);
      cache[id].then((item_model item){
        item.kids.forEach((it)=> fetchitemswithcomments(it));
      });
      return cache;
    },
      <int,Future<item_model>>{}
    );
  }

}