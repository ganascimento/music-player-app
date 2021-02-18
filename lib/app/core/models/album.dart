import 'package:musicapp/app/core/models/music.dart';
import 'package:uuid/uuid.dart';

class Album {
	final String name;
	final String pathImage;
	final List<Music> musics;
	String playId;

	Album({this.name, this.pathImage, this.musics}) {
		var uuid = Uuid();
		playId = uuid.v4().toString();
	}
}