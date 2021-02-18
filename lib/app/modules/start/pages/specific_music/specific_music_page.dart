import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:musicapp/app/core/components/default_component.dart';
import 'package:musicapp/app/core/components/music_item_component.dart';
import 'package:musicapp/app/core/models/music.dart';
import 'package:musicapp/app/core/models/specific.dart';
import 'package:musicapp/app/modules/start/start_controller.dart';

class SpecificMusicPage extends StatefulWidget {
	
	final Specific specific;

	SpecificMusicPage(this.specific);

	@override
	_SpecificMusicPageState createState() => _SpecificMusicPageState();
}

class _SpecificMusicPageState extends State<SpecificMusicPage> {
	@override
	Widget build(BuildContext context) {
		final controller = Modular.get<StartController>();
		final size = MediaQuery.of(context).size;

		void playMusic(Music music) {
			final oldPlayId = controller.playEntity?.id;
			controller.setPlayEntity(widget.specific.playId);
			controller.startMusic(music, oldPlayId);
		}

		return DefaultPage(
			body: Scaffold(
				appBar: AppBar(
					title: Text(widget.specific.title),
					backgroundColor: Color.fromRGBO(25, 25, 25, 1),
					elevation: 0
				),
				body: Container(
					margin: EdgeInsets.only(bottom: 18),
					child: Observer(
						builder: (context) {
							return ListView.builder(
								itemCount: controller.selectedMusics.length,
								itemBuilder: (context, index) {
									return MusicItemComponent(
										width: size.width * 0.95,
										music: controller.selectedMusics[index],
										playMusic: playMusic,
										playId: widget.specific.playId,
									);
								}
							);
						}
					)
				)
			)
		);
	}
}