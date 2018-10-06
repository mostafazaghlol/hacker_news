import 'dart:convert';
import 'package:http/http.dart' show Client;
import '../Models/item_model.dart';

final _root = "https://hacker-news.firebaseio.com/v0";

class API_PROVIDER {
  Client client = Client();
  fetchTopIds() async{
    final response = await client.get('$_root/topstories.json');
    final Ids = json.decode(response.body);
    return Ids;
  }
  fetchItem(int id) async{
    final response = await client.get('$_root/item/$id.json');
    final parsedJson = json.decode(response.body);
    return item_model.fromJson(parsedJson);
  }
}