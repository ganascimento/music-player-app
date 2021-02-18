import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:musicapp/app/core/services/finder_music.dart';
import 'package:musicapp/app/core/services/local_database_service.dart';
import 'package:musicapp/app/core/services/music_player.dart';
import 'package:musicapp/app/modules/playlist/playlist_controller.dart';
import 'package:musicapp/app/modules/playlist/playlist_page.dart';
import 'package:musicapp/app/modules/start/pages/specific_music/specific_music_page.dart';
import 'package:musicapp/app/modules/start/start_controller.dart';
import 'package:musicapp/app/modules/start/start_page.dart';
import 'app_controller.dart';
import 'app_widget.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
		Bind((i) => FinderMusic()),
		Bind((i) => MusicPlayer()),
		Bind((i) => LocalDatabaseService()),
		Bind((i) => AppController()),
		Bind((i) => StartController(i.get<FinderMusic>(), i.get<MusicPlayer>(), i.get<LocalDatabaseService>())),
		Bind((i) => PlaylistController(i.get<FinderMusic>(), i.get<LocalDatabaseService>()))
	];

  @override
  List<Router> get routers => [
		Router(Modular.initialRoute, child: (_, args) => StartPage()),
		Router('/specific', child: (_, args) => SpecificMusicPage(args.data)),
		Router('/playlist', child: (_, args) => PlaylistPage())
	];

	@override
  Widget get bootstrap => AppWidget();
}