import 'package:atelier5_1/models/list_etudiants.dart';
import 'package:atelier5_1/models/scol_list.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class dbuse {
  final int version = 1;
  Database? db;
  static final dbuse _dbHelper = dbuse._internal();
  dbuse._internal();
  factory dbuse() {
    return _dbHelper;
  }

  Future<Database?> openDb() async {
    db ??= await openDatabase(join(await getDatabasesPath(), 'shopping.db'),
        onCreate: (database, version) {
      database.execute(
          'CREATE TABLE classes(codClass INTEGER PRIMARY KEY, nomClass TEXT,nbreEtud INTEGER)');
      database.execute(
          'CREATE TABLE etudiants(id INTEGER PRIMARY KEY, codClass INTEGER,nom TEXT, prenom TEXT, datNais TEXT, ' +
              'FOREIGN KEY(codClass) REFERENCES classes(codClass))');
    }, version: version);
    return db;
  }

  Future testDb() async {
    db = await openDb();
    await db!.execute('INSERT INTO classes VALUES (1, "dsi21", 27)');
    await db!.execute(
        'INSERT INTO etudiants VALUES (10, 1, "hadil", "abdennebi", "12/09/2000")');
    List classes = await db!.rawQuery('select * from classes');
    List etudiants = await db!.rawQuery('select * from etudiants');
    print(classes[0].toString());
    print(etudiants[0].toString());
  }

  Future<List<ScolList>> getClasses() async {
    final List<Map<String, dynamic>> maps = await db!.query('classes');
    return List.generate(maps.length, (i) {
      return ScolList(
        maps[i]['codClass'],
        maps[i]['nomClass'],
        maps[i]['nbreEtud'],
      );
    });
  }

  Future<List<ListEtudiants>> getEtudiants(code) async {
    final List<Map<String, dynamic>> maps =
        await db!.query('etudiants', where: 'codClass = ?', whereArgs: [code]);
    return List.generate(maps.length, (i) {
      return ListEtudiants(
        maps[i]['id'],
        maps[i]['codClass'],
        maps[i]['nom'],
        maps[i]['prenom'],
        maps[i]['datNais'],
      );
    });
  }

  // void insertClass(ScolList list) {
  Future<void> insertClass(ScolList list) async {
    db = await openDb();
    await db!.rawInsert("INSERT INTO classes VALUES (?, ?,? )",
        [list.nbreEtud, list.nomClass, list.codClass]);

    //}
  }

  Future<void> updateClass(ScolList list) async {
    db = await openDb();
    int updateCount = await db!.rawUpdate('''
    UPDATE classes 
    SET nomClass = ?, nbreEtud = ? 
    WHERE codClass = ?
    ''', [list.nomClass, list.nbreEtud, list.codClass]);
  }

  Future<void> deleteList(ScolList scolList) async {
    db = await openDb();
    await db!.delete('classes',
        where: 'codClass = ?', whereArgs: [scolList.codClass]);
  }

  Future<void> insertEtud(ListEtudiants list) async {
    db = await openDb();
    await db!.rawInsert("INSERT INTO etudiants VALUES (?, ?,?,?,? )",
        [list.id, list.codClass, list.nom, list.prenom, list.datNais]);
  }

  Future<void> updateEtudiant(ListEtudiants list) async {
    db = await openDb();
    int updateCount = await db!.rawUpdate(
        '''UPDATE etudiants SET codClass = ?, nom = ? , prenom = ?, datNais = ?WHERE id = ?''',
        [list.codClass, list.nom, list.prenom, list.datNais, list.id]);
  }

  void deleteList1(ListEtudiants listEtudiants) async {
    db = await openDb();
    await db!
        .delete('etudiants', where: 'id = ?', whereArgs: [listEtudiants.id]);
  }
}
