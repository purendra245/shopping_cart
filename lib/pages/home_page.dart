import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/components/my_drawer.dart';
import 'package:shopping_cart/components/my_list_tile.dart';
import 'package:shopping_cart/models/playlist_provider.dart';
import 'package:shopping_cart/models/song_model.dart';
import 'package:shopping_cart/pages/play_list_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PlaylistProvider playlistProvider;

  @override
  void initState() {
    super.initState();
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  @override
  void dispose() {
    playlistProvider.dispose();
    super.dispose();
  }

  void goToSongDetails(int index){
    playlistProvider.currentIndex = index;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PlayListDetails(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'P L A Y L I S T',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onTertiary,
            fontWeight: FontWeight.normal,
            fontSize: 20,
          ),
        ),
      ),
      drawer: MyDrawer(),
      body: Consumer<PlaylistProvider>(
        builder: (context, playlistProvider, child) {
          List<SongModel> playlists = playlistProvider.playlist;
          return ListView.builder(
            itemCount: playlists.length,
            itemBuilder: (context, index) {
              SongModel song = playlists[index];
              return MyListTile(
                title: song.songName,
                subtitle: song.artistName,
                imageUrl: song.albumArtImagePath,
                onTap: () {
                  goToSongDetails(index);
                },
              );
            },
          );
        },
      ),
    );
  }
}
