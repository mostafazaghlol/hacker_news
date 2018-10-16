import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import '../Models/item_model.dart';
import 'repository.dart';

class NewsDbAPI implements Source,cache{
  Database Db;

  NewsDbAPI(){
    init();
  }
  void init() async{
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path,"items.dp");
    Db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db,int version){
        db.execute(""" CREATE TABLE items
        (id INTEGER PRIMARY KEY,
          type TEXT,
          by TEXT,
          time INTEGER,
          text TEXT,
          parent INTEGER,
          kids BLOB,
          dead INTEGER,
          deleted INTEGER,
          url TEXT,
          score INTEGER,
          title TEXT,
          descendants INTEGER
        )""");
      }
    );
  }


  Future<item_model> fetchItem(int id)async{
    final map = await Db.query(
      "items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );
    if(map.length>0){
      return item_model.fromDb(map.first);
    }
    return null;
  }


  Future<int> addItem(item_model item){
    return Db.insert("items", item.toMapForDb(),conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  @override
  Future<List<int>> fetchTopIds() {
    return null;
  }

  Future<int> clear(){
    return Db.delete('items');
  }
}

final NewsDbAPIObject = NewsDbAPI();