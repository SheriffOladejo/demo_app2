import 'package:demo_app2/models/message.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DbHelper {

  DbHelper._createInstance();

  String db_name = "khunju_sms_app.db";

  static Database _database;
  static DbHelper helper;

  String message_table = "message_table";
  String col_message_id = "id";
  String col_message_text = "text";
  String col_message_timestamp = "timestamp";
  String col_message_groupdate = "group_date";
  String col_message_recipient_number = "recipient_number";
  String col_message_recipient_name = "recipient_name";
  String col_message_sender = "sender";


  factory DbHelper(){
    if(helper == null){
      helper = DbHelper._createInstance();
    }
    return helper;
  }

  Future<Database> get database async {
    if(_database == null){
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future createDb(Database db, int version) async {
    String createMessageTable = "create table $message_table ("
        "$col_message_id integer primary key autoincrement,"
        "$col_message_timestamp integer,"
        "$col_message_groupdate varchar(100),"
        "$col_message_text text,"
        "$col_message_recipient_number text,"
        "$col_message_recipient_name text,"
        "$col_message_sender text)";

    await db.execute(createMessageTable);
  }

  Future<Database> initializeDatabase() async{
    final db_path = await getDatabasesPath();
    final path = join(db_path, db_name);
    return await openDatabase(path, version: 1, onCreate: createDb);
  }

  Future<void> saveMessage(Message message) async {
    Database db = await database;
    String query = "insert into $message_table ("
        "$col_message_timestamp, $col_message_groupdate, $col_message_text, "
        "$col_message_recipient_number, $col_message_recipient_name, $col_message_sender) values ("
        "'${message.timestamp}', '${message.groupDate}', '${message.text}', '${message.recipientNumber}', "
        "'${message.recipientName}', '${message.sender}')";
    await db.execute(query);
  }

  Future<List<Message>> getConversations() async {
    Database db = await database;
    List<Message> list = [];
    List<String> numbers = [];
    String query = "select distinct $col_message_recipient_number from $message_table";
    List<Map<String, Object>> result = await db.rawQuery(query);
    for (var i = 0; i < result.length; i++) {
      numbers.add(result[i][col_message_recipient_number]);
      print("db_helper.getConversations numbers: ${result[i][col_message_recipient_number]}");
    }

    for (var i = 0; i < numbers.length; i++) {
      String query = "select * from $message_table where"
          " $col_message_recipient_number = '${numbers[i]}' "
          "order by $col_message_timestamp desc limit 1";
      List<Map<String, Object>> result = await db.rawQuery(query);
      for (var j = 0; j < result.length; j++) {
        var m = Message(
            isSelected: false,
            id: result[j][col_message_id],
            timestamp: result[j][col_message_timestamp],
            recipientNumber: result[j][col_message_recipient_number],
            recipientName: result[j][col_message_recipient_name],
            text: result[j][col_message_text],
            sender: result[j][col_message_sender],
            groupDate: result[j][col_message_groupdate]
        );
        list.add(m);
      }
    }
    return list;
  }

  Future<List<Message>> getConversation(String recipientNumber) async {
    Database db = await database;
    List<Message> list = [];
    String query = "select * from $message_table where $col_message_recipient_number = '$recipientNumber'";
    List<Map<String, Object>> result = await db.rawQuery(query);
    for (int i = 0; i < result.length; i++) {
      var m = Message(
          isSelected: false,
          id: result[i][col_message_id],
          timestamp: result[i][col_message_timestamp],
          recipientNumber: result[i][col_message_recipient_number],
          recipientName: result[i][col_message_recipient_name],
          text: result[i][col_message_text],
          sender: result[i][col_message_sender],
          groupDate: result[i][col_message_groupdate]
      );
      list.add(m);
    }
    return list;
  }

}