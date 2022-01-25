import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class VerseAudio extends ChangeNotifier {
  Duration totalDuration = Duration.zero;
  Duration position = Duration.zero;
  String audioState = "Stopped";

  VerseAudio() {
    initAudio();
  }

  AudioPlayer audioPlayer = AudioPlayer();

  initAudio() {
    audioPlayer.onDurationChanged.listen((updatedDuration) {
      totalDuration = updatedDuration;
      notifyListeners();
    });

    audioPlayer.onAudioPositionChanged.listen((updatedPosition) {
      position = updatedPosition;
      notifyListeners();
    });

    audioPlayer.onPlayerStateChanged.listen((playerState) {
      if(playerState == AudioPlayerState.STOPPED)
        audioState = "Stopped";
      if(playerState == AudioPlayerState.PLAYING)
        audioState = "Playing";
      if(playerState == AudioPlayerState.PAUSED)
        audioState = "Paused";
      notifyListeners();
    });
  }

  playAudio(url) {
    audioPlayer.play(url);
  }

  pauseAudio() {
    audioPlayer.pause();
  }

  stopAudio() {
    audioPlayer.stop();
  }

  seekAudio(Duration durationToSeek) {
    audioPlayer.seek(durationToSeek);
  }
}