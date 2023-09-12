import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/note.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    /*
    * getDatabasesPath
    * Get the default databases location.
    * On Android, it is typically data/data/ /databases
    * On iOS, it is the Documents director
    * */
    final dbPath = await getDatabasesPath();
    /*
    * filePath
    * app database db
    * */
    final path = join(dbPath, filePath);

    /*
    * onUpgrade
    * for SQL schema change in table
    */

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  //Create DB
  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const macAddressTextType = 'TEXT NOT NULL';
    const ipAddressTextType = 'TEXT NOT NULL';
    /*
    * db execute
    * CREATE TABLE
    * to create table
    */
    await db.execute('''
CREATE TABLE $tableNameNotes ( 
  ${NoteFields.id} $idType, 
  ${NoteFields.macAddress} $macAddressTextType,
  ${NoteFields.ipAddress} $ipAddressTextType,
  ${NoteFields.title} $textType,
  ${NoteFields.description} $textType,
  ${NoteFields.time} $textType
  )
''');

    /*
    * For CREATE ANOTHER TABLE
    * copy above  db execute CREATE TABLE NewTable
    */
  }

  /*
    * create a single Note to db
    */
  Future<Note> create(Note note) async {
    final db = await instance.database;

    /*
    * final json = note.toJson();
    * final columns =
    *     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    * final values =
    *     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    * final id = await db
    *     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');
    * Example
    * int id1 = await db.rawInsert(
    *     'INSERT INTO Test(name, value, num) VALUES("some name", 1234, 456.789)');
    * int id2 = await db.rawInsert(
    *     'INSERT INTO Test(name, value, num) VALUES(?, ?, ?)',
    *     ['another name', 12345678, 3.1416]);
    *
    */
    final id = await db.insert(
      tableNameNotes,
      note.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return note.copy(id: id);
  }

  /*
    * Read a Single Note
    */
  Future<Note> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableNameNotes,
      columns: NoteFields.values,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;

    const orderBy = '${NoteFields.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableNameNotes, orderBy: orderBy);

    return result.map((json) => Note.fromJson(json)).toList();
  }

  Future<int> update(Note note) async {
    final db = await instance.database;

    return db.update(
      tableNameNotes,
      note.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableNameNotes,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
