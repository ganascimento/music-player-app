import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:musicapp/app/core/components/button_component.dart';
import 'package:musicapp/app/core/models/music.dart';
import 'package:musicapp/app/modules/start/start_controller.dart';
import 'dart:io';

class PlayerPage extends StatefulWidget {
	@override
	_PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> with SingleTickerProviderStateMixin {
	AnimationController _playPauseAnimationController;
	double timeMusic = 0;

	@override
  void initState() {    
    super.initState();
		_playPauseAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 800));		
  }

	@override
  void dispose() {
    super.dispose();
		_playPauseAnimationController.dispose();
  }

	@override
	Widget build(BuildContext context) {
		final controller = Modular.get<StartController>();
		final size = MediaQuery.of(context).size;

		void playPauseMusic() {
			controller.playPauseMusic();
			controller.currentMusic.isStarted ? _playPauseAnimationController.reverse() : _playPauseAnimationController.forward();
		}

		void sliderOnChange(double value, Music music) {
			setState(() {
				controller.setMusicPosition(value);
				timeMusic = value;
			});
		}

		return Observer(
		  builder: (_) {
				Music music = controller.currentMusic;
				bool hasThumb = music != null && music.audio.metas.image.path != null;
				String positionMusic = "00:00";

				if (music != null && music.isStarted) _playPauseAnimationController.reverse();
				else _playPauseAnimationController.forward();

				if (controller.currentMusicPosition != null && controller.currentMusicPosition > 0 && controller.currentMusicPosition.toDouble() <= music?.duration?.toDouble()) {
					int hour = (controller.currentMusicPosition / 60) > 60 ? (controller.currentMusicPosition / 60 / 60).floor() : 0;
					int minutes = (controller.currentMusicPosition / 60).floor();
					int seconds = (controller.currentMusicPosition % 60).round();
					String secondsString = seconds > 9 ? "$seconds" : "0$seconds";

					positionMusic = hour > 0 ? "$hour:$minutes:$secondsString" : minutes > 0 ? "$minutes:$secondsString" : "00:$secondsString";
					timeMusic = controller.currentMusicPosition.toDouble();
				} else if (controller.currentMusicPosition != null && controller.currentMusicPosition.toDouble() > music?.duration?.toDouble()) {
					positionMusic = music.durationFormat;
					timeMusic = music.duration.toDouble();
				} else {
					positionMusic = "00:00";
					timeMusic = 0;
				}

				return Container(
					color: Color.fromRGBO(0, 20, 30, 1),
					child: Column(
						children: <Widget>[
							Container(
								padding: EdgeInsets.symmetric(vertical: 7, horizontal: 8),
								child: Row(
									children: <Widget>[
										Container(
											height: 55,
											width: 55,
											margin: EdgeInsets.only(right: 15),
											decoration: BoxDecoration(
												border: Border.all(),
												borderRadius: BorderRadius.circular(5),
												color: Color.fromRGBO(200, 200, 200, 1)
											),
											child: hasThumb ? Image.file(File(music.audio.metas.image.path)) : Icon(Icons.music_note),
										),
										Column(
											mainAxisSize: MainAxisSize.max,
											crossAxisAlignment: CrossAxisAlignment.start,
											children: <Widget>[
												Container(
													width: size.width * 0.7 - 50,
													child: Text(
														music != null ? music.audio.metas.title : '',
														overflow: TextOverflow.ellipsis,
														style: TextStyle(
															fontSize: 17,
														),
													),
												),
												Container(
													width: size.width * 0.7 - 50,
													child: Text(
														music != null ? music.audio.metas.artist : '',
														overflow: TextOverflow.ellipsis,
														style: TextStyle(
															fontSize: 12
														),
													)
												)
											],
										),
										Container(
											width: size.width * 0.2,
											alignment: Alignment.center,
											child: ButtonComponent(
												handle: playPauseMusic,
												child: AnimatedIcon(
													icon: AnimatedIcons.pause_play,
													color: Colors.white,
													size: 50,
													progress: _playPauseAnimationController,
												)
											)
										)
									]
								)
							),
							Container(
								height: size.width - 30,
								width: size.width - 30,
								margin: EdgeInsets.only(top: 10),
								decoration: BoxDecoration(
									color: Color.fromRGBO(160, 160, 160, 1),
									borderRadius: BorderRadius.circular(size.width)
								),
								child: hasThumb ? 
									ClipRRect(
										borderRadius: BorderRadius.circular(size.width),
									  child: Image.file(File(music.audio.metas.image.path), fit: BoxFit.cover),
									) : 
									Icon(Icons.music_note, color: Color.fromRGBO(80, 80, 80, 1), size: 100),
							),
							Expanded(
							  child: Container(							  	
							  	child: Column(
										crossAxisAlignment: CrossAxisAlignment.center,
										mainAxisAlignment: MainAxisAlignment.center,
							  	  children: <Widget>[											
											Row(
												crossAxisAlignment: CrossAxisAlignment.center,
												mainAxisAlignment: MainAxisAlignment.center,
												children: <Widget>[
													Text(
														positionMusic,
														style: TextStyle(
															fontSize: 12
														)
													),
													Container(
														width: size.width * 0.72,
													  child: Slider(
													  	min: 0,
													  	max: music != null && music.duration != null ? music.duration.toDouble() : 10,
													  	value: timeMusic,
															onChanged: (value) {},
															onChangeEnd: (value) {
																sliderOnChange(value, music);
															}
													  ),
													),
													Text(
														music != null && music.durationFormat != null ? music.durationFormat : "00:00",
														style: TextStyle(
															fontSize: 12
														)
													),
												],
											),
							  	    Row(
												crossAxisAlignment: CrossAxisAlignment.center,
												mainAxisAlignment: MainAxisAlignment.center,
												children: <Widget>[
													Container(
														margin: EdgeInsets.only(right: 20),
														child: ButtonComponent(
															handle: controller.volumeChange,
															child: Icon(
																controller.isMute ? Icons.volume_mute : Icons.volume_up,
																color: controller.isMute ? Color.fromRGBO(255, 255, 255, 0.5) : Colors.white,
																size: 28
															),
														),
													),
													Container(
														margin: EdgeInsets.only(right: 20),
														child: ButtonComponent(
															handle: controller.previousMusic,
															child: Icon(
																Icons.skip_previous,
																color: Colors.white,
																size: 40
															),
														),
													),
													ButtonComponent(
														handle: playPauseMusic,
														child: AnimatedIcon(
															icon: AnimatedIcons.pause_play,
															color: Colors.white,
															size: 70,
															progress: _playPauseAnimationController,
														)
													),
													Container(
														margin: EdgeInsets.only(left: 20),
														child: ButtonComponent(
															handle: controller.nextMusic,
															child: Icon(
																Icons.skip_next,
																color: Colors.white,
																size: 40
															),
														),
													),
													Container(
														margin: EdgeInsets.only(left: 20),
														child: ButtonComponent(
															handle: controller.changeLoopMode,
															child: Icon(
																Icons.loop,
																color: controller.isLoop ? Colors.white : Color.fromRGBO(255, 255, 255, 0.4),
																size: 28
															),
														),
													),
												],
											),
							  	  ],
							  	),
							  ),
							)
						]
					)
				);
			}
		);
	}
}