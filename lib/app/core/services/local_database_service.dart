import 'dart:convert';

import 'package:musicapp/app/core/constants/local_database_constants.dart';
import 'package:musicapp/app/core/models/playlist.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseService {
	static final LocalDatabaseService instance = LocalDatabaseService.internal();

	factory LocalDatabaseService() => instance;

	LocalDatabaseService.internal();

	static Database _database;

	Future<Database> get database async {
		if (_database != null) return _database;

		_database = await _initDatabase();
		return _database;
	}

	_initDatabase() async {
		final databasePath = await getDatabasesPath();
		final path = join(databasePath, NAME_DB);
		return await openDatabase(path, version: VERSION, onCreate: _onCreate);
	}

	Future _onCreate(Database db, int version) async {
		await db.execute("CREATE TABLE $TABLE"
		"("
		"	$COLUMN_ID INTEGER PRIMARY KEY,"
		"	$COLUMN_JSON TEXT"
		")");
	}

	Future<int> insert(Playlist playlist) async {
		Database db = await instance.database;
		String json = jsonEncode(playlist.toJson());
		Map<String, dynamic> data = { COLUMN_JSON: json };

		return await db.insert(TABLE, data);
	}

	delete(int id) async {
		Database db = await instance.database;
		await db.delete(TABLE, where: "$COLUMN_ID = $id");
	}

	Future<List<Playlist>> select() async {
		Database db = await instance.database;
		List<dynamic> data = await db.rawQuery('SELECT * FROM $TABLE');

		if (data == null || data.length == 0) return null;

		try {
			List<Playlist> playlist = [];

			data.forEach((item) {
				int id = item[COLUMN_ID];
				Playlist entity = Playlist.fromJson(jsonDecode(item[COLUMN_JSON]));

				playlist.add(new Playlist(
					id: id,
					name: entity.name,
					identMusics: entity.identMusics
				));
			});

			return playlist;
		} catch (ex) {
			return null;
		}
	}
}