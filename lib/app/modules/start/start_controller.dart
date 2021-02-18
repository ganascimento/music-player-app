import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart' as AudioPlayer;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:musicapp/app/core/models/album.dart';
import 'package:musicapp/app/core/models/artist.dart';
import 'package:musicapp/app/core/models/music.dart';
import 'package:musicapp/app/core/models/play.dart';
import 'package:musicapp/app/core/models/playlist.dart';
import 'package:musicapp/app/core/services/finder_music.dart';
import 'package:musicapp/app/core/services/local_database_service.dart';
import 'package:musicapp/app/core/services/music_player.dart';
part 'start_controller.g.dart';

class StartController = _StartControllerBase with _$StartController;

abstract class _StartControllerBase with Store implements Disposable {
	final MusicPlayer _musicPlayer;
	final LocalDatabaseService _localDatabase;

	_StartControllerBase(FinderMusic finderMusic, this._musicPlayer, this._localDatabase) {
		finderMusic.getAllMusics().then((value) {
			setAllMusics(value);
			finderMusic.getArtists().then((value) => setArtists(value));
			finderMusic.getAlbums().then((value) => setAlbums(value));
			findPlaylist();
		});
	}
	
	TabController tabController;
	bool isNext = false;
	StreamSubscription<AudioPlayer.Playing> streamAudioFinished;

	@observable
	List<Music> allMusics = [];

	@observable
	List<Artist> artists = [];

	@observable
	List<Album> albums = [];

	@observable
	List<Playlist> playlists = [];

	@observable
	List<Music> selectedMusics = [];

	@observable
	bool isLoop = false;

	@observable
	bool isMute = false;

	@observable
	Play playEntity;

	@observable
	Music currentMusic;

	@observable
	int currentMusicPosition;

	@action
	setAllMusics(List<Music> value) {
		allMusics = value;
	}

	@action
	setArtists(List<Artist> value) {
		artists = value;
	}

	@action
	setAlbums(List<Album> value) {
		albums = value;
	}

	@action 
	setPlaylists(List<Playlist> value) {
		playlists = value;
	}

	@action 
	setSelectedMusics(List<Music> value) {
		selectedMusics = value;
	}

	@action 
	setPlayEntity(String id) {
		playEntity = new Play(id: id, musics: selectedMusics);
	}

	@action 
	findPlaylist() async {
		List<Playlist> value = await _localDatabase.select();

		if (value == null || value.length == 0) return;
		List<Playlist> entity = [];

		value.forEach((element) {
			List<Music> songs = [];

			element.identMusics.forEach((ident) {
				allMusics.forEach((music) {
					if (ident == music.ident) songs.add(music);
				});
			});

			element.musics = songs;

			entity.add(element);
		});

		setPlaylists(entity);
	}

	@action
	removePlaylist(int id) async {
		await _localDatabase.delete(id);
		playlists = playlists.where((item) => item.id != id).toList();
	}

	@action
	startMusic(Music music, String oldPlayId) async {
		if (streamAudioFinished != null) await streamAudioFinished.cancel();

		List<Music> playMusic = playEntity.musics.map((item) {
			if (item.isStarted && item.ident != music.ident) item.isStarted = false;
			else if ((item.ident == music.ident && !item.isStarted) || (item.ident == music.ident && playEntity.id != oldPlayId)) {
				item.isStarted = true;

				int index = 0;
				int indexSelected;
				List<AudioPlayer.Audio> audios = playEntity.musics.map((item) {
					if (item.ident == music.ident) indexSelected = index;
					index++;

					return item.audio;
				}).toList();

				currentMusic = item;
				_musicPlayer.play(audios, indexSelected, playPauseMusic: this.playPauseMusic, nextMusic: this.nextMusic, previousMusic: this.previousMusic).then((value) {
					listenMusicStarted();
					audioFinished();
				});
			}
			else if (item.ident == music.ident && item.isStarted && playEntity.id == oldPlayId) {
				item.isStarted = false;
				currentMusic = music;
				_musicPlayer.playOrPause();
			}
			
			return item;
		}).toList();

		playEntity.musics = playMusic;
		selectedMusics = playMusic;
	}

	@action
	playPauseMusic() {
		if (currentMusic == null) return;

		_musicPlayer.playOrPause();

		List<Music> auxMusics = playEntity.musics.map((item) {
			if (item.ident == currentMusic.ident) {
				item.isStarted = !item.isStarted;
				currentMusic = item;
			}

			return item;
		}).toList();

		Play playAux = new Play(id: playEntity.id, musics: auxMusics);
		playEntity = playAux;
		selectedMusics = selectedMusics;
	}

	@action
	nextMusic() {
		isNext = true;
		_musicPlayer.next();
	}

	@action
	previousMusic() {
		bool changed = _musicPlayer.previous();
		
		if (!changed || playEntity.musics.indexOf(currentMusic) == 0) return;

		List<Music> auxMusics = [];
		int indexNext;

		for (int i = 0; i < playEntity.musics.length; i++) {
			var item = playEntity.musics;

			if (item[i].ident == currentMusic.ident) {
				item[i].isStarted = false;
				indexNext = i - 1;
			}

			auxMusics.add(item[i]);
		}

		auxMusics[indexNext].isStarted = true;
		
		Play playAux = new Play(id: playEntity.id, musics: auxMusics);
		currentMusic = playAux.musics[indexNext];
		playEntity = playAux;
		selectedMusics = selectedMusics;
	}

	@action
	audioFinished() {
		streamAudioFinished = _musicPlayer.audioFinished().listen((audio) {
			
			List<Music> auxMusics = [];
			int indexNext;
			if (isLoop && !isNext) return;
			isNext = false;

			if (audio.index == playEntity.musics.length - 1 && !audio.hasNext) {
				final music = currentMusic..isStarted = false;
				final listMusic = playEntity..musics[playEntity.musics.length - 1].isStarted = false;
				currentMusic = music;
				playEntity = listMusic;
				selectedMusics = selectedMusics;
				return;
			}

			if (playEntity.musics.indexOf(currentMusic) == playEntity.musics.length - 1) {
				auxMusics = playEntity.musics.map((item) {
					item.isStarted = false;
					return item;
				}).toList();

				auxMusics[0].isStarted = true;
			} else {
				for (int i = 0; i < playEntity.musics.length; i++) {
					var item = playEntity.musics;

					if (item[i].ident == currentMusic.ident) {
						item[i].isStarted = false;
						indexNext = i + 1;
					}

					auxMusics.add(item[i]);
				}

				auxMusics[indexNext].isStarted = true;
			}
	
			Play playAux = new Play(id: playEntity.id, musics: auxMusics);
			if (indexNext != null && indexNext >= 0) currentMusic = playAux.musics[indexNext];
			else currentMusic = playAux.musics[0];
			playEntity = playAux;
			selectedMusics = selectedMusics;
		});
	}

	@action
	listenMusicStarted() {
		_musicPlayer.getCurrentPosition().listen((duration) {
			currentMusicPosition = duration.inSeconds;
		});
	}

	@action
	setMusicPosition(double position) {
		_musicPlayer.changeMusicPosition(position);
	}

	@action
	changeLoopMode() {
		isLoop = !isLoop;
		_musicPlayer.activeLoop(isLoop);
	}

	@action
	volumeChange() {
		isMute = !isMute;
		_musicPlayer.volumeChange(isMute);
	}

	@override
  void dispose() {
  }
}