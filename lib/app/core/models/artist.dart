import 'package:musicapp/app/core/models/music.dart';
import 'package:uuid/uuid.dart';

class Artist {
	final String name;
	final String pathImage;
	final List<Music> musics;
	String playId;

	Artist({this.name, this.pathImage, this.musics}) {
		var uuid = Uuid();
		playId = uuid.v4().toString();
	}
}