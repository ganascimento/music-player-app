import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:musicapp/app/core/components/music_item_component.dart';
import 'package:musicapp/app/core/models/music.dart';
import 'package:musicapp/app/modules/start/start_controller.dart';

class MusicPage extends StatefulWidget {
	@override
	_MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
	final controller = Modular.get<StartController>();

	@override
	Widget build(BuildContext context) {		
		final size = MediaQuery.of(context).size;

		void playMusic(Music music) {
			final oldPlayId = controller.playEntity?.id;
			controller.setPlayEntity('musics');
			controller.startMusic(music, oldPlayId);
		}

		return Container(
			margin: EdgeInsets.only(bottom: 18),
			child: Observer(
				builder: (context) {
					return ListView.builder(
						itemCount: controller.selectedMusics.length,
						itemBuilder: (context, index) {
							return MusicItemComponent(
								width:size.width * 0.95,
								music: controller.selectedMusics[index],
								playMusic: playMusic,
								playId: 'musics',
							);
						},
					);
				},
			)
		);
	}
}