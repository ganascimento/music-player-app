import 'dart:io';

import 'package:flutter/material.dart';
import 'package:musicapp/app/core/models/music_playlist.dart';

class MusicPlaylistComponent extends StatefulWidget {

	final double width;
	final MusicPlaylist musicPlaylist;
	final Function(MusicPlaylist) selectMusic;

	MusicPlaylistComponent({
		@required this.width,
		@required this.musicPlaylist,
		@required this.selectMusic
	});

	@override
	_MusicPlaylistComponentState createState() => _MusicPlaylistComponentState();
}

class _MusicPlaylistComponentState extends State<MusicPlaylistComponent> {
	@override
	Widget build(BuildContext context) {
		String duration = widget.musicPlaylist != null && widget.musicPlaylist.music.durationFormat != null ? widget.musicPlaylist.music.durationFormat : "00:00";

		handlePress() {
			FocusScope.of(context).unfocus();
			widget.selectMusic(widget.musicPlaylist);
		}

		return Container(
			width: widget.width,
			padding: EdgeInsets.symmetric(horizontal: 10),
			child: Column(
			  children: <Widget>[
			    Material(
			      child: InkWell(
							onTap: handlePress,
							borderRadius: BorderRadius.circular(5),
			        child: Padding(
			          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 7),
			          child: Row(
			            children: <Widget>[
			          		Container(
			          			height: 50,
			          			width: 50,
			          			decoration: BoxDecoration(
			          				border: Border.all(),
			          				borderRadius: BorderRadius.circular(5),
												color: Color.fromRGBO(200, 200, 200, 1)
			          			),
			          			child: widget.musicPlaylist.music.audio.metas.image.path != null ? Image.file(File(widget.musicPlaylist.music.audio.metas.image.path)) : Icon(Icons.music_note),
			          			margin: EdgeInsets.only(right: 15),
			          		),
			              Column(
			          			mainAxisSize: MainAxisSize.max,
			          			crossAxisAlignment: CrossAxisAlignment.start,
			              	children: <Widget>[
			              		Container(
			          					width: widget.width * 0.9 - 85,
			              			child: Text(
			          						widget.musicPlaylist.music.audio.metas.title,
			          						overflow: TextOverflow.ellipsis,
			          						style: TextStyle(
			          							fontSize: 17,
			          						),
			          					),
			              		),
			              		Container(
													width: widget.width * 0.6,
													child: Text(
														'${widget.musicPlaylist.music.audio.metas.artist} - $duration',
														overflow: TextOverflow.ellipsis,
														style: TextStyle(
															fontSize: 12
														),
													),
												)
			              	],
			              ),
										Container(
											width: widget.width * 0.1,
											child: Icon(
												widget.musicPlaylist.isChecked ? Icons.check_box : Icons.check_box_outline_blank,
												color: Colors.white,
											),
										)
			            ],
			          ),
			        ),
			      ),
			    ),
					Container(
						height: 0.5,
						color: Color.fromRGBO(180, 180, 180, 1),
						margin: EdgeInsets.only(top: 5, bottom: 5),
						width: widget.width - 20,
					)
			  ],
			),
		);
	}
}