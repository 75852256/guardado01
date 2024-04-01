import 'dart:ffi';

import 'dart:io';
import 'dart:ui';

//import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:music_ui/cancionesmodell.dart';

import 'package:audioplayers/audioplayers.dart';

import 'cancionesmodell.dart';

class ReproductorPage extends StatefulWidget {
  final List<cancion> canciones;
  final int index;
  final player = AudioCache();

  ReproductorPage({Key? key, required this.canciones, required this.index})
      : super(key: key);

  @override
  State<ReproductorPage> createState() => _ReproductorPageState();
}

class _ReproductorPageState extends State<ReproductorPage> {
  final audioPlayer = AudioPlayer();
  bool isplaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();

    setAudio();

    audioPlayer.onPlayerStateChanged.listen((State) {
      setState(() {
        isplaying = State == PlayerState.PLAYING;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.LOOP);
    final player = AudioCache(prefix: 'assets/');
    final url = await player.load(widget.canciones[0].audio);
    audioPlayer.setUrl(url.path, isLocal: true);
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: PageView(
              children: widget.canciones
                  .map((canciones) => imagendefondo(canciones))
                  .toList(),
            ),
          ),
          filtro(),
          Column(
            children: <Widget>[
              const SizedBox(
                height: 70,
              ),
              appbar(),
              const SizedBox(
                height: 40,
              ),
              Container(
                height: 270,
                child: PageView(
                  controller: PageController(viewportFraction: 0.8),
                  children: widget.canciones
                      .map((canciones) => portada(canciones))
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              subtitulo(),
              BARRAmusic(),
              const SizedBox(
                height: 0,
              ),
              Container(
                height: 55,
                child: PageView(
                  children: canciones
                      .asMap()
                      .map((index, cancion) =>
                          MapEntry(index, botones(context, cancion, index + 1)))
                      .values
                      .toList(),
                  // children: widget.canciones
                  //     .map((canciones) => botones(canciones))
                  //     .toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget imagendefondo(cancion canciones) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff1c1e2c),
        image: DecorationImage(
            image: AssetImage(widget.canciones[0].imagen),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6), BlendMode.dstATop)),
      ),
    );
  }

  Widget filtro() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 9, sigmaY: 9),
      child: Container(color: Colors.black.withOpacity(0.4)),
    );
  }

  Widget appbar() {
    return Container(
      height: 100,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      "MUSIC PLAY",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    Text(
                      "1000 SONGS | + 1.3 M FAVORITES",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget portada(cancion canciones) {
    return Card(
      child: Container(
        height: 250,
        width: 300,
        child: Image.asset(
          canciones.imagen,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget subtitulo() {
    return Container(
      height: 60,
      child: Column(
        children: <Widget>[
          Text(
            widget.canciones[0].titulo,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final hours = twoDigits(duration.inHours);
    final minute = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minute,
      seconds,
    ].join(':');
  }

  Widget BARRAmusic() {
    return Container(
      child: Column(
        children: <Widget>[
          Slider(
            min: 0,
            max: duration.inSeconds.toDouble(),
            value: position.inSeconds.toDouble(),
            activeColor: Colors.blue,
            inactiveColor: Colors.grey,
            onChanged: (value) async {
              final position = Duration(seconds: value.toInt());
              await audioPlayer.seek(position);
              await audioPlayer.resume();
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatTime(position),
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  formatTime(duration - position),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget botones(BuildContext context, cancion canciones, int index) {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.fast_rewind,
            color: Colors.grey,
            size: 40,
          ),
          const SizedBox(
            width: 30,
          ),
          IconButton(
            icon: Icon(
              isplaying ? Icons.pause : Icons.play_arrow,
            ),
            color: Colors.blue,
            iconSize: 50,
            onPressed: () async {
              if (isplaying) {
                await audioPlayer.pause();
              } else {
                await audioPlayer.resume();
              }
            },
          ),
          const SizedBox(
            width: 30,
          ),
          const Icon(
            Icons.fast_forward,
            color: Colors.grey,
            size: 40,
          ),
        ],
      ),
    );
  }
}
