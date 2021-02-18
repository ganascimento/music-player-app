import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:musicapp/app/modules/start/pages/home/components/playlist_item_component.dart';
import 'package:musicapp/app/modules/start/start_controller.dart';

class HomePage extends StatefulWidget {
	@override
	_HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {	
	@override
	Widget build(BuildContext context) {
		final controller = Modular.get<StartController>();
		final size = MediaQuery.of(context).size;

		return Scaffold(
			floatingActionButton: Padding(
			  padding: const EdgeInsets.only(bottom: 30),
			  child: FloatingActionButton(			  	
			  	child: Icon(Icons.add),
			  	onPressed: () {
						Navigator.pushNamed(context, '/playlist');
					},
			  ),
			),
			body: Container(
				padding: EdgeInsets.only(right: size.width * 0.01),
				child: OrientationBuilder(
					builder: (_, orientation) {
						return Observer(
							builder: (_) {
								return GridView.count(									
									crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
									children: List.generate(
										controller.playlists.length,
										(index) {
											return PlaylistItemComponent(
												playlist: controller.playlists[index],
											);
										}
									)
								);
							}
						);
					}
				)
			)
		);
	}
}

