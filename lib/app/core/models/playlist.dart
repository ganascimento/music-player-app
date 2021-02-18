import 'package:musicapp/app/core/models/music.dart';
import 'package:uuid/uuid.dart';

class Playlist {
	int id;
	String name;
	List<Music> musics;
	List<String> identMusics;
	String playId;

	Playlist({this.id, this.name, this.musics, this.identMusics}) {
		var uuid = Uuid();
		playId = uuid.v4().toString();		
	}

	Playlist.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    identMusics = json['identMusics'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['identMusics'] = this.identMusics;
    return data;
  }
}