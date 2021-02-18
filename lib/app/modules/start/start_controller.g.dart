// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StartController on _StartControllerBase, Store {
  final _$allMusicsAtom = Atom(name: '_StartControllerBase.allMusics');

  @override
  List<Music> get allMusics {
    _$allMusicsAtom.reportRead();
    return super.allMusics;
  }

  @override
  set allMusics(List<Music> value) {
    _$allMusicsAtom.reportWrite(value, super.allMusics, () {
      super.allMusics = value;
    });
  }

  final _$artistsAtom = Atom(name: '_StartControllerBase.artists');

  @override
  List<Artist> get artists {
    _$artistsAtom.reportRead();
    return super.artists;
  }

  @override
  set artists(List<Artist> value) {
    _$artistsAtom.reportWrite(value, super.artists, () {
      super.artists = value;
    });
  }

  final _$albumsAtom = Atom(name: '_StartControllerBase.albums');

  @override
  List<Album> get albums {
    _$albumsAtom.reportRead();
    return super.albums;
  }

  @override
  set albums(List<Album> value) {
    _$albumsAtom.reportWrite(value, super.albums, () {
      super.albums = value;
    });
  }

  final _$playlistsAtom = Atom(name: '_StartControllerBase.playlists');

  @override
  List<Playlist> get playlists {
    _$playlistsAtom.reportRead();
    return super.playlists;
  }

  @override
  set playlists(List<Playlist> value) {
    _$playlistsAtom.reportWrite(value, super.playlists, () {
      super.playlists = value;
    });
  }

  final _$selectedMusicsAtom =
      Atom(name: '_StartControllerBase.selectedMusics');

  @override
  List<Music> get selectedMusics {
    _$selectedMusicsAtom.reportRead();
    return super.selectedMusics;
  }

  @override
  set selectedMusics(List<Music> value) {
    _$selectedMusicsAtom.reportWrite(value, super.selectedMusics, () {
      super.selectedMusics = value;
    });
  }

  final _$isLoopAtom = Atom(name: '_StartControllerBase.isLoop');

  @override
  bool get isLoop {
    _$isLoopAtom.reportRead();
    return super.isLoop;
  }

  @override
  set isLoop(bool value) {
    _$isLoopAtom.reportWrite(value, super.isLoop, () {
      super.isLoop = value;
    });
  }

  final _$isMuteAtom = Atom(name: '_StartControllerBase.isMute');

  @override
  bool get isMute {
    _$isMuteAtom.reportRead();
    return super.isMute;
  }

  @override
  set isMute(bool value) {
    _$isMuteAtom.reportWrite(value, super.isMute, () {
      super.isMute = value;
    });
  }

  final _$playEntityAtom = Atom(name: '_StartControllerBase.playEntity');

  @override
  Play get playEntity {
    _$playEntityAtom.reportRead();
    return super.playEntity;
  }

  @override
  set playEntity(Play value) {
    _$playEntityAtom.reportWrite(value, super.playEntity, () {
      super.playEntity = value;
    });
  }

  final _$currentMusicAtom = Atom(name: '_StartControllerBase.currentMusic');

  @override
  Music get currentMusic {
    _$currentMusicAtom.reportRead();
    return super.currentMusic;
  }

  @override
  set currentMusic(Music value) {
    _$currentMusicAtom.reportWrite(value, super.currentMusic, () {
      super.currentMusic = value;
    });
  }

  final _$currentMusicPositionAtom =
      Atom(name: '_StartControllerBase.currentMusicPosition');

  @override
  int get currentMusicPosition {
    _$currentMusicPositionAtom.reportRead();
    return super.currentMusicPosition;
  }

  @override
  set currentMusicPosition(int value) {
    _$currentMusicPositionAtom.reportWrite(value, super.currentMusicPosition,
        () {
      super.currentMusicPosition = value;
    });
  }

  final _$findPlaylistAsyncAction =
      AsyncAction('_StartControllerBase.findPlaylist');

  @override
  Future findPlaylist() {
    return _$findPlaylistAsyncAction.run(() => super.findPlaylist());
  }

  final _$removePlaylistAsyncAction =
      AsyncAction('_StartControllerBase.removePlaylist');

  @override
  Future removePlaylist(int id) {
    return _$removePlaylistAsyncAction.run(() => super.removePlaylist(id));
  }

  final _$startMusicAsyncAction =
      AsyncAction('_StartControllerBase.startMusic');

  @override
  Future startMusic(Music music, String oldPlayId) {
    return _$startMusicAsyncAction
        .run(() => super.startMusic(music, oldPlayId));
  }

  final _$_StartControllerBaseActionController =
      ActionController(name: '_StartControllerBase');

  @override
  dynamic setAllMusics(List<Music> value) {
    final _$actionInfo = _$_StartControllerBaseActionController.startAction(
        name: '_StartControllerBase.setAllMusics');
    try {
      return super.setAllMusics(value);
    } finally {
      _$_StartControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setArtists(List<Artist> value) {
    final _$actionInfo = _$_StartControllerBaseActionController.startAction(
        name: '_StartControllerBase.setArtists');
    try {
      return super.setArtists(value);
    } finally {
      _$_StartControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setAlbums(List<Album> value) {
    final _$actionInfo = _$_StartControllerBaseActionController.startAction(
        name: '_StartControllerBase.setAlbums');
    try {
      return super.setAlbums(value);
    } finally {
      _$_StartControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPlaylists(List<Playlist> value) {
    final _$actionInfo = _$_StartControllerBaseActionController.startAction(
        name: '_StartControllerBase.setPlaylists');
    try {
      return super.setPlaylists(value);
    } finally {
      _$_StartControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSelectedMusics(List<Music> value) {
    final _$actionInfo = _$_StartControllerBaseActionController.startAction(
        name: '_StartControllerBase.setSelectedMusics');
    try {
      return super.setSelectedMusics(value);
    } finally {
      _$_StartControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPlayEntity(String id) {
    final _$actionInfo = _$_StartControllerBaseActionController.startAction(
        name: '_StartControllerBase.setPlayEntity');
    try {
      return super.setPlayEntity(id);
    } finally {
      _$_StartControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic playPauseMusic() {
    final _$actionInfo = _$_StartControllerBaseActionController.startAction(
        name: '_StartControllerBase.playPauseMusic');
    try {
      return super.playPauseMusic();
    } finally {
      _$_StartControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic nextMusic() {
    final _$actionInfo = _$_StartControllerBaseActionController.startAction(
        name: '_StartControllerBase.nextMusic');
    try {
      return super.nextMusic();
    } finally {
      _$_StartControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic previousMusic() {
    final _$actionInfo = _$_StartControllerBaseActionController.startAction(
        name: '_StartControllerBase.previousMusic');
    try {
      return super.previousMusic();
    } finally {
      _$_StartControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic audioFinished() {
    final _$actionInfo = _$_StartControllerBaseActionController.startAction(
        name: '_StartControllerBase.audioFinished');
    try {
      return super.audioFinished();
    } finally {
      _$_StartControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic listenMusicStarted() {
    final _$actionInfo = _$_StartControllerBaseActionController.startAction(
        name: '_StartControllerBase.listenMusicStarted');
    try {
      return super.listenMusicStarted();
    } finally {
      _$_StartControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setMusicPosition(double position) {
    final _$actionInfo = _$_StartControllerBaseActionController.startAction(
        name: '_StartControllerBase.setMusicPosition');
    try {
      return super.setMusicPosition(position);
    } finally {
      _$_StartControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeLoopMode() {
    final _$actionInfo = _$_StartControllerBaseActionController.startAction(
        name: '_StartControllerBase.changeLoopMode');
    try {
      return super.changeLoopMode();
    } finally {
      _$_StartControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic volumeChange() {
    final _$actionInfo = _$_StartControllerBaseActionController.startAction(
        name: '_StartControllerBase.volumeChange');
    try {
      return super.volumeChange();
    } finally {
      _$_StartControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
allMusics: ${allMusics},
artists: ${artists},
albums: ${albums},
playlists: ${playlists},
selectedMusics: ${selectedMusics},
isLoop: ${isLoop},
isMute: ${isMute},
playEntity: ${playEntity},
currentMusic: ${currentMusic},
currentMusicPosition: ${currentMusicPosition}
    ''';
  }
}
