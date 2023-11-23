import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:track_note/model/MyNoteModel.dart';
import 'package:track_note/model/MyNoteModel.dart;
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
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType = 'BOOLEAN NOT NULL';
    final textType = 'TEXT NOT NULL';
    await db.execute('''
    CREATE TABLE Notes(
    ${NotesImpNames.id} $idType,
    ${NotesImpNames.pin} $boolType,
    ${NotesImpNames.title} $textType,
    ${NotesImpNames.content} $textType,
    ${NotesImpNames.createdTime} $textType
    )
    ''');

  }

    Future<Note? > InsertEntry(Note note) async{
      final db= await instance.database;
      final id= await db!.insert(NotesImpNames.TableName, note.toJson());
      return note.copy(id: id);
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

    Future updateNote(int id) async{
    final db=await instance.database;

    await db!.update("Notes", {"title" : "This is a updated Title"}, where : "id = ?",whereArgs: [id] );
    }

    Future deleteNote(int id) async{
    final db = await instance.database;
    await db!.delete("Notes", where: "id = ?",whereArgs: [id]);
    }
}