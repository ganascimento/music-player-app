import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:musicapp/app/core/models/album.dart';
import 'package:musicapp/app/core/models/artist.dart';
import 'package:musicapp/app/core/models/music.dart';
import 'dart:io';

class FinderMusic {
	final FlutterAudioQuery _audioQuery = FlutterAudioQuery();
	final List<Music> musics = [];
	final List<Artist> artists = [];
	final List<Album> albums = [];
	int index = 0;

	Future<List<Music>> getAllMusics() async {
		if (musics != null && musics.length > 0) return musics;
		
		final songs = await _audioQuery.getSongs();
		
		songs.forEach((item) {
			try {
				if (item.title.contains('Slack -') || item.title.contains('Hangouts ')) return;

				String image;

				if (item.albumArtwork != null && item.albumArtwork.isNotEmpty && File(item.albumArtwork).existsSync()) image = item.albumArtwork;
				
				Audio audio = Audio.file(
					item.filePath,
					metas: Metas(
						album: item.album,
						artist: item.artist != '<unknown>' ? item.artist : 'Desconhecido',
						title: item.title,
						image: MetasImage.file(image)
					)
				);

				int duration = (int.parse(item.duration) / 1000).round();
				int hour = (duration / 60) > 60 ? (duration / 60 / 60).floor() : 0;
				int minutes = (duration / 60).floor();
				int seconds = (duration % 60).round();
				String secondsString = seconds > 9 ? "$seconds" : "0$seconds";

				String durationMusic = hour > 0 ? "$hour:$minutes:$secondsString" : minutes > 0 ? "$minutes:$secondsString" : "00:$secondsString";
				
				musics.add(new Music(audio: audio, id: index, isStarted: false, durationFormat: durationMusic, duration: duration, ident: item.id));
				index++;
			} catch (ex) {
			}
		});

		return musics;
	}

	Future<List<Artist>> getArtists() async {
		List<ArtistInfo> artistsInfo = await _audioQuery.getArtists();

		artistsInfo.forEach((artist) {
			if (artist.name == '<unknown>') return;
			List<Music> artistsSong = [];

			musics.forEach((music) {
				if (music.audio.metas.artist == artist.name) artistsSong.add(music);
			});

			artists.add(new Artist(name: artist.name, pathImage: artist.artistArtPath, musics: artistsSong));
		});

		return artists;
	}

	Future<List<Album>> getAlbums() async {
		List<AlbumInfo> albumsInfo = await _audioQuery.getAlbums();

		for (var album in albumsInfo) {
			if (album.title == '<unknown>') continue;

			List<Music> albumsSong = [];
			String image;
			var songsInfo = await _audioQuery.getSongsFromAlbum(albumId: album.id);

			if (album.albumArt != null && album.albumArt.isNotEmpty && File(album.albumArt).existsSync()) image = album.albumArt;

			songsInfo.forEach((song) {
				musics.forEach((music) {
					if (song.title == music.audio.metas.title) albumsSong.add(music);
				});
			});

			if (!albums.contains(album)) albums.add(new Album(name: album.title, pathImage: image, musics: albumsSong));
		}

		 return albums;
	}
}