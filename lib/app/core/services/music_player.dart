import 'package:assets_audio_player/assets_audio_player.dart';

class MusicPlayer {
	final _audioPlayer = AssetsAudioPlayer();

	Future play(List<Audio> audios, int index, { Function playPauseMusic, Function nextMusic, Function previousMusic}) async {
		await _audioPlayer.stop();

		await _audioPlayer.open(
			Playlist(
				audios: audios
			),
			showNotification: true,
			notificationSettings: NotificationSettings(
				stopEnabled: false,
				customPauseIcon: AndroidResDrawable(name: "ic_action_pause"),
				customPlayIcon: AndroidResDrawable(name: "ic_action_play_arrow"),
				customPreviousIcon: AndroidResDrawable(name: "ic_action_skip_previous"),
				customNextIcon: AndroidResDrawable(name: "ic_action_skip_next"),
				customNextAction: (player) {
					nextMusic();
				},
				customPrevAction: (player) {
					previousMusic();
				},
				customPlayPauseAction: (player) {
					player.playOrPause();
					playPauseMusic();
				}
			)
		);

		_audioPlayer.playlistPlayAtIndex(index);
	}

	void playOrPause() {
		_audioPlayer.playOrPause();
	}

	void next() {
		_audioPlayer.next();
	}

	bool previous() {
		_audioPlayer.previous();

		if (_audioPlayer.currentPosition.value.inSeconds <= 4) return true;

		return false;
	}

	Stream<Playing> audioFinished() {
		return _audioPlayer.playlistAudioFinished;
	}

	Stream<Duration> getCurrentPosition() {
		return _audioPlayer.currentPosition;
	}

	void changeMusicPosition(double position) {
		Duration duration = Duration(seconds: position.toInt());
		_audioPlayer.seek(duration);
	}

	void activeLoop(bool active) async {
		if (active) await _audioPlayer.setLoopMode(LoopMode.single);
		else await _audioPlayer.setLoopMode(LoopMode.none);
	}

	void volumeChange(bool active) async {
		if (active) await _audioPlayer.setVolume(0);
		else await _audioPlayer.setVolume(1);
	}
}