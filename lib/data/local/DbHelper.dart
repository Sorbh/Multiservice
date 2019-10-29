import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final String ORDER_TBL = "request";
  static Database _db;

//  Future<Database> get db async {
//    if (_db != null) return _db;
//    _db = await initDb();
//    return _db;
//  }

  static Future<Database> getDb() async {
    if (_db != null) return _db;
    _db = await _initDb();
    return _db;
  }


  //Creating a database with name test.dn in your directory
  static _initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "multiservice.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  // Creating a table name Employee with fields
  static void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute("CREATE TABLE $ORDER_TBL(id INTEGER PRIMARY KEY, "
        "ordType TEXT, "
        "ordDate TEXT, "
        "ordNum TEXT, "
        "devID TEXT, "
        "devModel TEXT, "
        "devSerialNum TEXT, "
        "region TEXT, "
        "city TEXT, "
        "address TEXT, "
        "location TEXT, "
        "employer TEXT, "
        "isBoss TEXT, "
        "phone TEXT, "
        "contactInfo TEXT, "
        "contactPhone TEXT, "
        "shipmentAdress TEXT, "
        "shipmentLocation TEXT, "
        "syncTime TEXT, "
        "ordID TEXT, "
        "remoteStatus TEXT"
        ")");
    print("Created tables");
  }
}
