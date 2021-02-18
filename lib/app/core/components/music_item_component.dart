import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:musicapp/app/core/models/music.dart';
import 'package:musicapp/app/modules/start/start_controller.dart';

class MusicItemComponent extends StatefulWidget {

	final double width;
	final Music music;
	final Function(Music) playMusic;
	final String playId;

	MusicItemComponent({
		@required this.width,
		@required this.music,
		@required this.playMusic,
		@required this.playId
	});

	@override
	_MusicItemComponentState createState() => _MusicItemComponentState();
}

class _MusicItemComponentState extends State<MusicItemComponent> {
	@override
	Widget build(BuildContext context) {
		final controller = Modular.get<StartController>();
		String duration = widget.music != null && widget.music.durationFormat != null ? widget.music.durationFormat : "00:00";
		final bool isPlaying = controller.playEntity != null && controller.playEntity.id == widget.playId;

		return (
		Container(
			width: widget.width,
			padding: EdgeInsets.symmetric(horizontal: 10),
			child: Column(
			  children: <Widget>[
			    Material(
			      child: InkWell(
							onTap: (){
								widget.playMusic(widget.music);
							},
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
			          			child: widget.music.audio.metas.image.path != null ? Image.file(File(widget.music.audio.metas.image.path)) : Icon(Icons.music_note),
			          			margin: EdgeInsets.only(right: 15),
			          		),
			              Column(
			          			mainAxisSize: MainAxisSize.max,
			          			crossAxisAlignment: CrossAxisAlignment.start,
			              	children: <Widget>[
			              		Container(
			          					width: widget.width * 0.9 - 85,
			              			child: Text(
			          						widget.music.audio.metas.title,
			          						overflow: TextOverflow.ellipsis,
			          						style: TextStyle(
			          							fontSize: 17,
			          						),
			          					),
			              		),
			              		Container(
													width: widget.width * 0.6,
													child: Text(
														'${widget.music.audio.metas.artist} - $duration',
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
												widget.music.isStarted && isPlaying ? Icons.pause : Icons.play_circle_outline,
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
		)
	);
	}
}