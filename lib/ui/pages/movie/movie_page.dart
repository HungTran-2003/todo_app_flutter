import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/app_dimens.dart';
import 'package:todo_app/common/app_images.dart';
import 'package:todo_app/ui/pages/movie/movie_navigator.dart';
import 'package:todo_app/ui/pages/movie/movie_provider.dart';
import 'package:todo_app/ui/widgets/app_bar/app_bar_widget.dart';
import 'package:video_player/video_player.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return MovieProvider(navigator: MovieNavigator(context: context));
      },
      child: const MovieChildPage(),
    );
  }
}

class MovieChildPage extends StatefulWidget {
  const MovieChildPage({super.key});

  @override
  State<MovieChildPage> createState() => _MovieChildPageState();
}

class _MovieChildPageState extends State<MovieChildPage> {
  late MovieProvider _provider;

  @override
  void initState() {
    _provider = context.read<MovieProvider>();
    super.initState();
    _setup();
  }

  void _setup() async {
    _provider.initializeVideoPlayer();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    if (hours > 0) {
      return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Movie",
        onPressed: () {
          _provider.navigator.pop();
        },
        imageBackground: AppImages.header2,
      ),
      body: Container(
        margin: const EdgeInsets.all(AppDimens.paddingNormal),
        child: _buildShowVideo(),
      ),
    );
  }

  Widget _buildShowVideo() {
    return Selector<MovieProvider, VideoPlayerController?>(
      selector: (context, provider) => provider.videoPlayerController,
      builder: (context, videoPlayerController, child) {
        if (videoPlayerController == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            AspectRatio(
              aspectRatio: videoPlayerController.value.aspectRatio,
              child: GestureDetector(
                onTap: _provider.onVideoPlayerTapped,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    VideoPlayer(videoPlayerController),
                    _buildVideoControls(videoPlayerController),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildVideoControls(VideoPlayerController controller) {
    return Selector<MovieProvider, bool>(
      selector: (context, provider) => provider.areControlsVisible,
      builder: (context, areControlsVisible, child) {
        return AnimatedOpacity(
          opacity: areControlsVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: IgnorePointer(
            ignoring: !areControlsVisible,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Center(
                  child: IconButton(
                    iconSize: 50,
                    color: Colors.white,
                    onPressed: _provider.togglePlayPause,

                    icon: ValueListenableBuilder(
                      valueListenable: controller,
                      builder: (context, VideoPlayerValue value, child) {
                        return Icon(
                          value.isPlaying
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_filled,
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black87],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: controller,
                      builder: (context, VideoPlayerValue value, child) {
                        if (value.duration == Duration.zero) {
                          return const SizedBox.shrink();
                        }
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Slider(
                              value: value.position.inMilliseconds
                                  .clamp(0, value.duration.inMilliseconds)
                                  .toDouble(),
                              min: 0.0,
                              max: value.duration.inMilliseconds.toDouble(),
                              onChanged: (v) {
                                _provider.seekVideo(
                                  Duration(milliseconds: v.round()),
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                AppDimens.marginNormal,
                                0,
                                AppDimens.marginNormal,
                                AppDimens.marginSmall,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    _formatDuration(value.position),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(width: AppDimens.marginNormal),
                                  Text(
                                    _formatDuration(value.duration),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
