// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PlaylistController on _PlaylistControllerBase, Store {
  Computed<bool> _$isValidComputed;

  @override
  bool get isValid => (_$isValidComputed ??= Computed<bool>(() => super.isValid,
          name: '_PlaylistControllerBase.isValid'))
      .value;

  final _$titleAtom = Atom(name: '_PlaylistControllerBase.title');

  @override
  String get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  final _$messageErrorAtom = Atom(name: '_PlaylistControllerBase.messageError');

  @override
  String get messageError {
    _$messageErrorAtom.reportRead();
    return super.messageError;
  }

  @override
  set messageError(String value) {
    _$messageErrorAtom.reportWrite(value, super.messageError, () {
      super.messageError = value;
    });
  }

  final _$musicsPlaylistAtom =
      Atom(name: '_PlaylistControllerBase.musicsPlaylist');

  @override
  List<MusicPlaylist> get musicsPlaylist {
    _$musicsPlaylistAtom.reportRead();
    return super.musicsPlaylist;
  }

  @override
  set musicsPlaylist(List<MusicPlaylist> value) {
    _$musicsPlaylistAtom.reportWrite(value, super.musicsPlaylist, () {
      super.musicsPlaylist = value;
    });
  }

  final _$_PlaylistControllerBaseActionController =
      ActionController(name: '_PlaylistControllerBase');

  @override
  dynamic setTitle(String value) {
    final _$actionInfo = _$_PlaylistControllerBaseActionController.startAction(
        name: '_PlaylistControllerBase.setTitle');
    try {
      return super.setTitle(value);
    } finally {
      _$_PlaylistControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setMusicsPlaylist(List<MusicPlaylist> value) {
    final _$actionInfo = _$_PlaylistControllerBaseActionController.startAction(
        name: '_PlaylistControllerBase.setMusicsPlaylist');
    try {
      return super.setMusicsPlaylist(value);
    } finally {
      _$_PlaylistControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic selectMusic(MusicPlaylist music) {
    final _$actionInfo = _$_PlaylistControllerBaseActionController.startAction(
        name: '_PlaylistControllerBase.selectMusic');
    try {
      return super.selectMusic(music);
    } finally {
      _$_PlaylistControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic valid() {
    final _$actionInfo = _$_PlaylistControllerBaseActionController.startAction(
        name: '_PlaylistControllerBase.valid');
    try {
      return super.valid();
    } finally {
      _$_PlaylistControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
title: ${title},
messageError: ${messageError},
musicsPlaylist: ${musicsPlaylist},
isValid: ${isValid}
    ''';
  }
}
