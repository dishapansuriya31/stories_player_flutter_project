import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/src/audioplayer.dart';
import 'package:audioplayers/src/source.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter/audioPlayers/audioPlayers.dart';
class AudioFile extends StatefulWidget {
  final AudioPlayer advancedPlayer;
  final String audiopath;
  const AudioFile({Key? key,  required this.advancedPlayer,required this.audiopath }) : super(key: key);

  @override
  _AudioFileState createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  //final  String path = "https://api.apilayer.com/youtube/auto-complete?q=https%3A%2F%2Fyoutu.be%2FnZa9q=https%3A%2F%2Fyoutu.be%2FnZa9qv2KU2o";
  bool isPlaying = false;
  bool isPushed = false;
  bool isRepeat = false;
  bool isLoop = false;


  final List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
  ];


  @override
  void initState() {
    super.initState();
    this.widget.advancedPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });

    this.widget.advancedPlayer.onPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });
    this.widget.advancedPlayer.setSourceUrl(this.widget.audiopath);

    this.widget.advancedPlayer.onPlayerComplete.listen((event){
      setState((){
        _position = Duration(seconds:0);
        if(isRepeat==true){
            isPlaying=true;
        }else{

        }
        isPlaying=false;
        isRepeat=false;
      });
    });
  }

  Widget btnStart() {
    return IconButton(
      padding: const EdgeInsets.only(bottom: 10),
      icon: isPlaying == false
          ? Icon(_icons[0], size: 50, color: Colors.blue,)
          : Icon(_icons[1], size: 50, color: Colors.blue,),
      onPressed: () {
        if (isPlaying == false) {
          this.widget.advancedPlayer.play(UrlSource(this.widget.audiopath));
          setState(() {
            isPlaying = true;
          });
        } else if (isPlaying == true) {
          this.widget.advancedPlayer.pause();
          setState(() {
            isPlaying = false;
          });
        }
      },
    );
  }
  Widget btnFast(){
    return
      IconButton(
        icon: const ImageIcon(
          AssetImage('img/forwardd.png'),
          size: 15,
          color: Colors.black,
        ),
        onPressed: (){
          this.widget.advancedPlayer.setPlaybackRate(1.5);
        },
      );
  }
  Widget btnSlow(){
    return IconButton(
      icon:  ImageIcon(
        AssetImage('img/backward.png'),
        size: 15,
        color: Colors.black,
      ),
      onPressed:(){
        this.widget.advancedPlayer.setPlaybackRate(0.5);
      },
    );
  }
  Widget btnLoop(){
    return IconButton(
        icon: ImageIcon(
          AssetImage('img/loop.png'),
          size: 15,
          color: Colors.black,
        ), onPressed: () {

    },
    );
  }
  Widget btnRepeat(){
    return IconButton(
        icon: ImageIcon(
          AssetImage('img/repeat.png'),
          size: 15,
        ),
        onPressed: (){
          if(isRepeat==false){
            this.widget.advancedPlayer.setReleaseMode(ReleaseMode.loop);
            setState(() {
              isRepeat=true;
              var color=Colors.blue;
            });
          }else if(isRepeat==true){
            this.widget.advancedPlayer.setReleaseMode(ReleaseMode.loop);
            var color = Colors.black;
            isRepeat=false;

          }
          },
    );
  }
  Widget slider() {
    return Slider(
        activeColor: Colors.red,
        inactiveColor: Colors.grey,
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            changeToSecond(value.toInt());
            value = value;
          });
        });
  }

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    this.widget.advancedPlayer.seek(newDuration);
  }


  Widget loadAsset() {
    return
      Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

           btnRepeat(),
            btnSlow(),
            btnStart(),
            btnFast(),
            btnLoop(),
          ],
        ),
      );
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Container(child:
      Column(
        children: [
          Padding(padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_position.toString().split(".")[0],
                  style: const TextStyle(fontSize: 16),),
                Text(_duration.toString().split(".")[0],
                  style: const TextStyle(fontSize: 16),),
              ],
            ),
          ),
          slider(),
          loadAsset(),

        ],
      )
      );
  }
}











