import 'package:mobx/mobx.dart';
import 'package:musicapp/app/core/models/music.dart';
import 'package:musicapp/app/core/models/music_playlist.dart';
import 'package:musicapp/app/core/models/playlist.dart';
import 'package:musicapp/app/core/services/finder_music.dart';
import 'package:musicapp/app/core/services/local_database_service.dart';
part 'playlist_controller.g.dart';

class PlaylistController = _PlaylistControllerBase with _$PlaylistController;

abstract class _PlaylistControllerBase with Store {
	final LocalDatabaseService localDatabaseService;

	_PlaylistControllerBase(FinderMusic finderMusic, this.localDatabaseService) {
		localDatabaseService.select();
		finderMusic.getAllMusics().then((value) {
			if (value == null && value.length == 0) return;

			List<MusicPlaylist> songs = [];

			value.forEach((item) {
				songs.add(new MusicPlaylist(
					isChecked: false,
					music: item
				));
			});

			setMusicsPlaylist(songs);
		});
	}

	Future<bool> savePlaylist() async {
		try {
			List<Music> musics = [];
			List<String> idents = [];

			musicsPlaylist.forEach((item) {
				if (item.isChecked) {
					musics.add(item.music);
					idents.add(item.music.ident);
				}
			});

			Playlist playlist = new Playlist(identMusics: idents, musics: musics, name: title.trim());

			playlist.id = await localDatabaseService.insert(playlist);
			return true;
		} catch (e) {
			print('Erro ao salvar playlist');
			return true;
		}
	}
	
	@observable
	String title = '';

	@observable
	String messageError;

	@observable
	List<MusicPlaylist> musicsPlaylist = [];

	@computed
	bool get isValid => title != null && title.trim() != '' && title.trim().length >= 6 && musicsPlaylist.where((item) => item.isChecked == true).length > 0;

	@action
	setTitle(String value) {
		title = value;
		valid();
	}

	@action
	setMusicsPlaylist(List<MusicPlaylist> value) {
		musicsPlaylist = value;
	}

	@action
	selectMusic(MusicPlaylist music) {
		musicsPlaylist = musicsPlaylist.map((item) {
			if (item.music.ident == music.music.ident) item.isChecked = !item.isChecked;
			return item;
		}).toList();
	}

	@action
	valid() {
		if (title == null || title.trim() == '') messageError = 'O titulo é obrigatório';
		else if (title.trim().length < 6) messageError = 'O titule deve conter pelo menos 6 caracteres';
		else messageError = null;
	}
}