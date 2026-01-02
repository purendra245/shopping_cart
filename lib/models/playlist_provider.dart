import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopping_cart/models/song_model.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<SongModel> _playlist = [
    SongModel(
      songName: "So Sick",
      artistName: "Neyo",
      albumArtImagePath: "assets/images/music_artwork1.png",
      audioPath: "audios/chill.mp3",
    ),
    SongModel(
      songName: "Acid Rap",
      artistName: "Chance the Rapper",
      albumArtImagePath: "assets/images/music_artwork2.png",
      audioPath: "audios/chill.mp3",
    ),
    SongModel(
      songName: "Pheonix",
      artistName: "ASAP Rocky",
      albumArtImagePath: "assets/images/music_artwork3.png",
      audioPath: "audios/chill.mp3",
    ),
  ];

  int _currentIndex = 0;

  List<SongModel> get playlist => _playlist;

  int get currentIndex => _currentIndex;
  bool get isPlaying => _isPlaying;
  Duration get totalDuration => _totalDuration;
  Duration get currentDuration => _currentDuration;

  // ====== AUDIO PLAYER =========
  final AudioPlayer _audioPlayer = AudioPlayer();

  //duration

  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  //constructor

  PlaylistProvider() {
    listenToDuration();
  }

  //initial is not playing

  bool _isPlaying = false;

  //play the song

  void playSong() async {
    final String path = playlist[currentIndex].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  // pause the song

  void pauseSong() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  //resume the song

  void resumeSong() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  void pauseResumeSong() async {
    if (_isPlaying) {
      pauseSong();
    } else {
      resumeSong();
    }
    notifyListeners();
  }

  void seek(Duration duration) async {
    await _audioPlayer.seek(duration);
    notifyListeners();
  }

  void playNextSong() async {
    if (_currentIndex < playlist.length - 1) {
      currentIndex = currentIndex + 1;
    } else {
      currentIndex = 0;
    }
    // playSong();
    notifyListeners();
  }

  void playPreviousSong() async {
    //if more than 2 second the pause previous song
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (currentIndex > 0) {
        currentIndex = currentIndex - 1;
      } else {
        currentIndex = playlist.length - 1;
      }
    }
    notifyListeners();
  }

  //stop the song
  void stopSong() async {
    await _audioPlayer.stop();
    _isPlaying = false;
    notifyListeners();
  }

  void listenToDuration() {
    //listen to total duration
    _audioPlayer.onDurationChanged.listen((duration) {
      _totalDuration = duration;
      notifyListeners();
    });

    //listen to current duration
    _audioPlayer.onPositionChanged.listen((position) {
      _currentDuration = position;
      notifyListeners();
    });

    //listen to player state
    _audioPlayer.onPlayerComplete.listen((state) {
      playNextSong();
    });
  }

  // ============= AUDIO PLAYER =============

  set currentIndex(int index) {
    _currentIndex = index;
    if (_currentIndex < playlist.length) {
      playSong();
    }
    notifyListeners();
  }
}
