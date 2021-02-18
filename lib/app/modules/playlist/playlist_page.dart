import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:musicapp/app/modules/playlist/components/music_playlist_component.dart';
import 'package:musicapp/app/modules/playlist/playlist_controller.dart';
import 'package:musicapp/app/modules/start/start_controller.dart';

class PlaylistPage extends StatefulWidget {
	@override
	_PlaylistPageState createState() => _PlaylistPageState();
}

class _PlaylistPageState extends ModularState<PlaylistPage, PlaylistController> {
	@override
	Widget build(BuildContext context) {
		final size = MediaQuery.of(context).size;
		final startController = Modular.get<StartController>();

		closePage() {
			Navigator.pop(context);
		}

		addPlaylist() async {
			if (await controller.savePlaylist()){
				Navigator.pop(context);
				startController.findPlaylist();
			}
		}

		return Observer(
			builder: (_) {
				return Scaffold(
					appBar: AppBar(
						title: Text('Criar playlist'),
						backgroundColor: Color.fromRGBO(25, 25, 25, 1),
						elevation: 0,
						actions: [
							IconButton(
								icon: Icon(Icons.check),
								onPressed: controller.isValid ? addPlaylist : null,
								splashRadius: 25,
								disabledColor: Colors.grey[600],
							),
							IconButton(
								icon: Icon(Icons.clear),
								onPressed: closePage,
								splashRadius: 25,
							)
						],
					),
					body: Column(
						children: [
							Container(
								padding: EdgeInsets.symmetric(horizontal: 18),
								child: TextFormField(
									onChanged: controller.setTitle,
									cursorColor: Colors.white30,
									style: TextStyle(
										color: Colors.white
									),
									decoration: InputDecoration(
										contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
										focusedBorder: OutlineInputBorder(
											borderSide: BorderSide(color: Colors.white)
										),
										enabledBorder: OutlineInputBorder(
											borderSide: BorderSide(color: Colors.white)
										),
										border: OutlineInputBorder(
											borderSide: BorderSide(color: Colors.white)
										),
										hintText: 'Titulo da playlist',
										hintStyle: TextStyle(
											color: Colors.grey[500]
										),
										errorText: controller.messageError
									),
								),
							),
							Expanded(
								child: ListView.builder(
									itemCount: controller.musicsPlaylist.length,
									itemBuilder: (context, index) {
										return MusicPlaylistComponent(
											width:size.width * 0.95,
											musicPlaylist: controller.musicsPlaylist[index],
											selectMusic: controller.selectMusic,
										);
									}
								)
							),
						],			
					)
				);
			},
		);
	}
}