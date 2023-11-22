import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class NotesDatabase{
  static final NotesDatabase instance = NotesDatabase._init();
  static Database? _database;
  NotesDatabase._init();

  Future<Database?> get database async{
    if(_database != null) return _database;
    _database = await _initializeDB('Notes.db');
    return _database;
  }

  Future<Database> _initializeDB (String filepath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath,filepath);

    return await openDatabase(path, version: 1,onCreate: _createDB);
  }

  Future _createDB(Database db,int version) async {
    await db.execute('''
    CREATE TABLE Notes(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    pin INTEGER NOT NULL,
    title STRING NOT NULL,
    content STRING NOT NULL,
    createdTime STRING NOT NULL
    )
    ''');

  }

    Future<bool? > InsertEntry() async{
      final db= await instance.database;
      await db!.insert("Notes", {"pin" : 0 , "title" : "Code with salman" , "content" : "This is My note content", "createdTime" : "26 jan 2018"});
      return true;
    }

    Future<String> readAllNotes() async{
    final db=await instance.database;
    final orderBy= 'createdTime ASC';
    final query_result= await db!.query("Notes",orderBy: orderBy);
    print(query_result);
    return "Successful";
    }

    Future<String?> readOneNote(int id) async{
    final db = await instance.database;
    final map = await db!.query("Notes"
      ,columns: ["title"] ,
      where: 'id = ?',
      whereArgs: [id]
    );
    print(map);
    }
}