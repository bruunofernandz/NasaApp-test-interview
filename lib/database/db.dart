import 'dart:io';

import 'package:nasa_app/models/nasa_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseCreator {
  static DatabaseCreator _databaseCreator;
  static Database _database;
  String table;

  DatabaseCreator._createInstance();

  factory DatabaseCreator() {
    if (_databaseCreator == null)
      _databaseCreator = DatabaseCreator._createInstance();

    return _databaseCreator;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();

    String path = directory.path + "database.db";

    var sqlitedatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );

    return sqlitedatabase;
  }

  void _createDB(Database db, int newVersion) async {
    var sql;

    sql = ''' DROP TABLE IF EXISTS nasaphotos ''';
    await db.execute(sql);

    sql = ''' CREATE TABLE IF NOT EXISTS nasaphotos
      (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date DATE,
        hdurl TEXT,
        explanation TEXT,
        media_type TEXT,
        title TEXT,
        url TEXT
      ) ''';

    await db.execute(sql);
  }

  Future<void> deleteAll() async {
    Database db = await this.database;

    var sql = ''' DELETE FROM nasaphotos ''';
    await db.execute(sql);
  }

  Future<int> insertPhoto(NasaModel model) async {
    Database db = await this.database;

    // sql = ''' INSERT INTO nasaphotos (date, explanation, hdurl, title, url)
    //   VALUES(
    //     2000-04-23",
    //     What are those strange blue objects?  Many are images of a single, unusual, beaded, blue, ring-like galaxy which just happens to line-up behind a giant cluster of galaxies.  Cluster galaxies here appear yellow and -- together with the cluster's dark matter -- act as a gravitational lens.  A gravitational lens can create several images of background galaxies, analogous to the many points of light one would see while looking through a wine glass at a distant street light.  The distinctive shape of this background galaxy -- which is probably just forming -- has allowed astronomers to deduce that it has separate images at 4, 8, 9 and 10 o'clock, from the center of the cluster.  Possibly even the blue smudge just left of center is yet another image! This spectacular photo from the Hubble Space Telescope was taken in October 1994.",
    //     "https://apod.nasa.gov/apod/image/0004/cl0024_hst_big.gif",
    //     "Giant Cluster Bends, Breaks Images",
    //     https://apod.nasa.gov/apod/image/0004/cl0024_hst.jpg"
    //   ) ''';

    // await db.rawInsert(sql);

    var description = model.explanation.split('"').join('');
    var formatDate = model.date.split('-').join('/');

    var sql = ''' INSERT INTO nasaphotos (date, explanation, hdurl, title, url)
      VALUES(
        "$formatDate",
        "$description",
        "${model.hdurl}",
        "${model.title}",
        "${model.url}"
      ) ''';

    var result = await db.rawInsert(sql);

    return result;
  }

  Future<List<NasaModel>> getPhoto() async {
    Database db = await this.database;

    var sql = ''' SELECT * FROM nasaphotos''';

    var result = await db.rawQuery(sql);

    print(result);

    List<NasaModel> list = result.isNotEmpty
        ? result.map((c) => NasaModel.fromJson(c)).toList()
        : [];

    return list;
  }
}
