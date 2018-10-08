
import 'dart:async';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' show Client;
import '../Models/item_model.dart';
import 'repository.dart';
final _root = "https://hacker-news.firebaseio.com/v0";

class API_PROVIDER implements Source{
  Client client = Client();
  Future<List<int>> fetchTopIds() async{
    final response = await client.get('$_root/topstories.json');
    final Ids = json.decode(response.body);
    return Ids.cast<int>();
  }
  Future<item_model> fetchItem(int id) async{
    final response = await client.get('$_root/item/$id.json');
    final parsedJson = json.decode(response.body);
    return item_model.fromJson(parsedJson);
  }
}