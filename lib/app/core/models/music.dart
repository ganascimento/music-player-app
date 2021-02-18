import 'package:assets_audio_player/assets_audio_player.dart';

class Music {
	int id;
	String ident;
	Audio audio;
	bool isStarted;
	String durationFormat;
	int duration;

	Music({
		this.id,
		this.audio,
		this.isStarted,
		this.durationFormat,
		this.duration,
		this.ident
	});

	Music.construct(Music value) {
		id = value.id;
		ident = value.ident;
		audio = value.audio;
		isStarted = false;
		durationFormat = value.durationFormat;
		duration = value.duration;
	}
}