import 'package:hacker_news/src/Resoures/api_provider.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'dart:convert';

void main(){
//  test("The test 1", (){
//    final sum = 2+3;
//    expect(sum, 5);
//  });\
    test("test2", () async{
          final newsApi = API_PROVIDER();
          newsApi.client = MockClient((request) async{
               return Response(json.encode([1,2,3,4]), 200);
          });
          final ids = await newsApi.fetchTopIds();
          expect(ids, [1,2,3,4]);
    });
    test('test2', ()async{
          final newsApi = API_PROVIDER();
          newsApi.client = MockClient((request) async{
            final jsonMap = {'id':123};
            return Response(json.encode(jsonMap), 200);
          });
          final ids = await newsApi.fetchItem(1401);
          expect(ids.id ,123);
    });
}