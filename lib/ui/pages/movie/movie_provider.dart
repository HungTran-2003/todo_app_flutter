import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:todo_app/models/entities/movie_entity.dart';
import 'package:todo_app/ui/pages/movie/movie_navigator.dart';
import 'package:video_player/video_player.dart';

class MovieProvider extends ChangeNotifier {
  final MovieNavigator navigator;

  MovieProvider({required this.navigator});
  
  VideoPlayerController? _videoController;
  VideoPlayerController? get videoPlayerController => _videoController;

  bool _areControlsVisible = false;
  bool get areControlsVisible => _areControlsVisible;


  Timer? _controlsTimer;


  Future<void> initializeVideoPlayer() async {
    await Future.delayed(const Duration(seconds: 1));
    final movie = MovieEntity(id: 1, name: "test", url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4");
    _videoController = VideoPlayerController.networkUrl(
      Uri.parse(movie.url),
    );
    try {
      await _videoController!.initialize();
      _videoController!.play();
      _videoController!.setLooping(true);
      notifyListeners();
    } catch (e) {
      log("Error initializing video player: $e");
    }
  }

  void onVideoPlayerTapped() {
    _areControlsVisible = !_areControlsVisible;
    if (_areControlsVisible) {
      _hideControlsAfterDelay();
    } else {
      _controlsTimer?.cancel();
    }
    notifyListeners();
  }

  void togglePlayPause() {
    if (_videoController == null) return;

    if (_videoController!.value.isPlaying) {
      _videoController!.pause();
      _controlsTimer?.cancel();
    } else {
      _videoController!.play();
      _hideControlsAfterDelay();
    }
  }

  void seekVideo(Duration position) {
    _videoController?.seekTo(position);
    _hideControlsAfterDelay();
  }

  void _hideControlsAfterDelay() {
    _controlsTimer?.cancel();
    _controlsTimer = Timer(const Duration(seconds: 3), () {
      _areControlsVisible = false;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _controlsTimer?.cancel();
    super.dispose();
  }
}

