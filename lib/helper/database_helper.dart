import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/job.dart';

class DatabaseHelper {
  static final _databaseName = "bookmark_database.db";
  static final _databaseVersion = 1;

  static final table = 'bookmark_table';

  static final columnId = 'id';
  static final columnJob = 'job';


  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();


  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }


  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnJob TEXT NOT NULL
          )
          ''');
  }


  Future<void> insertJob(Jobs job) async {
    Database db = await instance.database;
    Map<String, dynamic> jobMap = job.toJson();
    jobMap['jobType'] = jobMap['jobType'].join(', ');
    await db.insert(table, jobMap);
  }


  Future<List<Jobs>> getJobs() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);

    return List.generate(maps.length, (i) {
      Map<String, dynamic> jobMap = maps[i];
      jobMap['jobType'] = jobMap['jobType'].split(', ');
      return Jobs.fromJson(jobMap);
    });
  }
}