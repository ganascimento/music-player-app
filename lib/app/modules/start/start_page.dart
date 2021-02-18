import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:musicapp/app/core/components/default_component.dart';
import 'package:musicapp/app/modules/start/pages/album/album_page.dart';
import 'package:musicapp/app/modules/start/pages/artist/artist_page.dart';
import 'package:musicapp/app/modules/start/pages/home/home_page.dart';
import 'package:musicapp/app/modules/start/pages/music/music_page.dart';
import 'package:musicapp/app/modules/start/start_controller.dart';

class StartPage extends StatefulWidget {
	@override
	_StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with SingleTickerProviderStateMixin {
	final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
	final controller = Modular.get<StartController>();

	@override
  void initState() {
    super.initState();
		imageCache.clear();
		controller.tabController = new TabController(vsync: this, length: 4);

		controller.tabController.addListener(() {
			controller.tabController.animateTo(controller.tabController.index);

			if (controller.tabController.index == 1) {
				controller.selectedMusics = controller.allMusics;
			}
		});
  }

	@override
	Widget build(BuildContext context) {
		return DefaultPage(
			body: DefaultTabController(
				length: 4,
				child: Scaffold(
					key: _drawerKey,
					appBar: AppBar(						
						title: Row(
							children: [
								Container(
									width: 40,
									margin: EdgeInsets.only(right: 10),
									child: Image.asset('assets/logo.png', fit: BoxFit.cover),
								),
								Text('GaDev - MusicApp')
							],
						),
						backgroundColor: Color.fromRGBO(25, 25, 25, 1),
						elevation: 0,
					bottom: TabBar(
						controller: controller.tabController,
						tabs: <Widget>[
							Tab(icon: Icon(Icons.home)),
							Tab(icon: Icon(Icons.music_note)),
							Tab(icon: Icon(Icons.person)),
							Tab(icon: Icon(Icons.album)),
						],
					),
					),
					backgroundColor: Color.fromRGBO(25, 25, 25, 1),
					body: TabBarView(
						controller: controller.tabController,
						children: <Widget>[
							HomePage(),
							MusicPage(),
							ArtistPage(),
							AlbumPage()
						]
					)
				)
			)
		);
	}
}