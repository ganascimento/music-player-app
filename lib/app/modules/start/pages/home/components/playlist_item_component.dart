import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:musicapp/app/core/models/playlist.dart';
import 'package:musicapp/app/core/models/specific.dart';
import 'package:musicapp/app/modules/start/start_controller.dart';

class PlaylistItemComponent extends StatefulWidget {

	final Playlist playlist;

	PlaylistItemComponent({@required this.playlist});

	@override
	_PlaylistItemComponentState createState() => _PlaylistItemComponentState();
}

class _PlaylistItemComponentState extends State<PlaylistItemComponent> {
	@override
	Widget build(BuildContext context) {
		final controller = Modular.get<StartController>();
		final size = MediaQuery.of(context).size;
		int selectedPlaylistId;

		handlePress() {
			controller.setSelectedMusics(widget.playlist.musics);
			Navigator.pushNamed(context, '/specific', arguments: new Specific(title: 'Playlist: ${widget.playlist.name}', playId: widget.playlist.playId));
		}

		executar() {
			Navigator.pop(context);
			handlePress();
		}

		removePlaylist() {
			Navigator.pop(context);
			controller.removePlaylist(selectedPlaylistId);
		}

		handleLongPress(int id) {
			selectedPlaylistId = id;

			showModalBottomSheet(
				context: context, 
				builder: (context) {
					return Container(
						child: Wrap(
							children: [
								Material(
									color: Colors.white,
								  child: ListTile(
										leading: Icon(Icons.play_arrow),
								  	title: const Text('Executar'),
								  	onTap: executar,
								  ),
								),
								Material(
									color: Colors.white,
								  child: ListTile(
										leading: Icon(Icons.delete),
								  	title: const Text('Remover'),
								  	onTap: removePlaylist,
								  ),
								),
								Container(
									height: 5,
								),
								Material(
									color: Colors.white,
								  child: ListTile(
										leading: Icon(Icons.close),
								  	title: const Text('Fechar'),
								  	onTap: (){
											Navigator.pop(context);
										},
								  ),
								)
							]
						)
					);
				}
			);
		}

		final musics = widget.playlist.musics;

		return Container(
			margin: EdgeInsets.only(left: size.width * 0.01, top: 3),
			child: Material(
				color: Colors.blue,
			  child: InkWell(
					onTap: handlePress,
					onLongPress: () {
						handleLongPress(widget.playlist.id);
					},
			    child: Column(
			    	children: <Widget>[
			    		Expanded(
			    			flex: 4,
			    			child: GridView.count(
			    				crossAxisCount: 2,
			    				childAspectRatio: 5 / 4,
			    				children: <Widget>[
										musics[0]?.audio?.metas?.image?.path != null ? Image.file(File(musics[0].audio.metas.image.path), fit: BoxFit.fill) : imageItem(),
										musics.length >= 2 && musics[1]?.audio?.metas?.image?.path != null ? Image.file(File(musics[1].audio.metas.image.path), fit: BoxFit.fill) : imageItem(),
										musics.length >= 3 && musics[2]?.audio?.metas?.image?.path != null ? Image.file(File(musics[2].audio.metas.image.path), fit: BoxFit.fill) : imageItem(),
										musics.length >= 4 && musics[3]?.audio?.metas?.image?.path != null ? Image.file(File(musics[3].audio.metas.image.path), fit: BoxFit.fill) : imageItem()
			    				],
			    			),
			    		),
			    		Expanded(
			    			flex: 1,
			    			child: Container(
			    				alignment: Alignment.center,
			    				child: Text(widget.playlist.name),
			    			),
			    		)
			    	],
			    ),
			  ),
			),
		);
	}
}

Widget imageItem() {
	return Container(
		color: Colors.grey[800],
		child: Icon(
			Icons.music_note,
			color: Colors.white,
		),
	);
}