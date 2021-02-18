import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:musicapp/app/core/models/music.dart';
import 'package:musicapp/app/core/models/specific.dart';
import 'package:musicapp/app/modules/start/start_controller.dart';

class TagItemComponent extends StatefulWidget {	
	final String title;
	final String pathImage;
	final String playId;
	final List<Music> musics;

	TagItemComponent(
		{
			@required this.title,
			@required this.pathImage,
			@required this.playId,
			@required this.musics
		}
	);

	@override
	_TagItemComponentState createState() => _TagItemComponentState();
}

class _TagItemComponentState extends State<TagItemComponent> {
	@override
	Widget build(BuildContext context) {
		final controller = Modular.get<StartController>();
		final size = MediaQuery.of(context).size;

		handleClick() {
			controller.setSelectedMusics(widget.musics);
			Navigator.pushNamed(context, '/specific', arguments: new Specific(title: widget.title, playId: widget.playId));
		}

		return Container(
			margin:  EdgeInsets.only(bottom: 5, left: size.width * 0.01),
		  child: Material(			
		  	color: Color.fromRGBO(0, 84, 175, 1),
		    child: InkWell(
		  		onTap: handleClick,
		      child: Container(
		      	child: Column(
		      		mainAxisSize: MainAxisSize.max,
		      		children: <Widget>[
		      			Expanded(
		      				flex: 4,
		      				child: Container(
		      					width: size.width * 0.5,
		      					child: widget.pathImage != null ? 
		      						Image.file(File(widget.pathImage), fit: BoxFit.fill) :
		      						Container(
		      							color: Color.fromRGBO(180, 180, 180, 1),
		      							child: Icon(
		      								Icons.music_note,
		      								size: 40,
		      							),
		      						)
		      				)
		      			),
		      			Expanded(
		      				flex: 1,
		      				child: Container(
		      					alignment: Alignment.center,
		      					width: size.width * 0.5,
		      					child: Text(
		      						widget.title,
		      						textAlign: TextAlign.center,
		      						overflow: TextOverflow.ellipsis,
		      					),
		      				),
		      			)
		      		],
		      	),
		      ),
		    ),
		  ),
		);
	}
}