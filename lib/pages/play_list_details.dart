import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/components/my_drawer.dart';
import 'package:shopping_cart/components/neu_box.dart';
import 'package:shopping_cart/models/playlist_provider.dart';

class PlayListDetails extends StatelessWidget {
  const PlayListDetails({super.key});

  //convert duration to mm:ss

  String formatTime(Duration duration) {
    String twoDigitsSeconds = duration.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    String formattedTime = '${duration.inMinutes}:$twoDigitsSeconds';
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, playlistProvider, child) {
        final playlist = playlistProvider.playlist;
        final currentSong = playlist[playlistProvider.currentIndex];

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.onTertiary,
              ),
              onPressed: () {
                playlistProvider.stopSong();
                Navigator.pop(context);
              },
            ),
            iconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.onTertiary,
            ),
            title: Text(
              'P L A Y L I S T',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onTertiary,
                fontWeight: FontWeight.normal,
                fontSize: 20,
              ),
            ),
            centerTitle: true,
          ),
          endDrawer: MyDrawer(),
          body: Padding(
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
              bottom: 25,
              top: 25,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Center(
                    child: NeuBox(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(currentSong.albumArtImagePath),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentSong.songName,
                                      style: TextStyle(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onTertiary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      currentSong.artistName,
                                      style: TextStyle(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onTertiary,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.favorite,
                                  color: Colors.redAccent,
                                  size: 25,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 25,
                          right: 25,
                          top: 25,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(formatTime(playlistProvider.currentDuration)),
                            Icon(Icons.shuffle),
                            Icon(Icons.repeat),
                            Text(formatTime(playlistProvider.totalDuration)),
                          ],
                        ),
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbShape: RoundSliderThumbShape(
                            enabledThumbRadius: 0,
                          ),
                        ),
                        child: Slider(
                          min: playlistProvider.currentDuration.inSeconds
                              .toDouble(),
                          max: playlistProvider.totalDuration.inSeconds
                              .toDouble(),
                          value: playlistProvider.currentDuration.inSeconds
                              .toDouble(),
                          activeColor: Colors.green,
                          inactiveColor: Colors.grey,
                          onChanged: (value) {},
                          onChangeEnd: (value) {
                            playlistProvider.seek(
                              Duration(seconds: value.toInt()),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 25),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: playlistProvider.playPreviousSong,
                              child: NeuBox(child: Icon(Icons.skip_previous)),
                            ),
                          ),
                          SizedBox(width: 25),
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: playlistProvider.pauseResumeSong,
                              child: NeuBox(
                                child: Icon(
                                  playlistProvider.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 25),
                          Expanded(
                            child: GestureDetector(
                              onTap: playlistProvider.playNextSong,
                              child: NeuBox(child: Icon(Icons.skip_next)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
