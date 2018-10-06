class item_model{
  final int id;
  final bool deleted;
  final String type;
  final String by;
  final int time;
  final String text;
  final bool dead;
  final String parent;
  //final poll 	The pollopt's associated poll.
  final List<dynamic>kids;
  final String url;
  final int score;
  final String title;
  final List<dynamic> parts;
  final int descendants;

  item_model.fromJson(Map<String,dynamic> parsedJson)
 :id = parsedJson['id']
  ,deleted = parsedJson['deleted']
  ,type = parsedJson['type']
  ,by = parsedJson['by']
  ,time = parsedJson['time']
  ,text = parsedJson['text']
  ,dead = parsedJson['dead']
  ,parent = parsedJson['parent']
  ,kids = parsedJson['kids']
  ,url = parsedJson['url']
  ,score = parsedJson['score']
  ,title = parsedJson['title']
  ,parts = parsedJson['parts']
  ,descendants = parsedJson['descendants'];


}