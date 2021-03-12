import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Player extends StatefulWidget {
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  AudioPlayer audioPlayer = AudioPlayer();
  @override
  void initState() {
    super.initState();
    AudioPlayer.logEnabled = true;
    audioPlayer.play("/home/krtirtho/Downloads/play.mp3");
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Material(
        type: MaterialType.transparency,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //  title of the currently playing track
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  Text(
                    "Track name",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("Artist's name")
                ],
              ),
            ),
            // controls
            Flexible(
              flex: 3,
              child: Container(
                constraints: BoxConstraints(maxWidth: 700),
                child: Column(
                  children: [
                    Slider.adaptive(
                      value: .3,
                      onChanged: (value) {},
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            icon: Icon(Icons.shuffle_rounded),
                            onPressed: () {}),
                        IconButton(
                            icon: Icon(Icons.skip_previous_rounded),
                            onPressed: () {}),
                        IconButton(
                            icon: Icon(Icons.play_arrow_rounded),
                            onPressed: () {}),
                        IconButton(
                            icon: Icon(Icons.skip_next_rounded),
                            onPressed: () {}),
                      ],
                    )
                  ],
                ),
              ),
            ),
            // add to saved tracks
            Expanded(
              flex: 1,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(Icons.favorite_outline_rounded),
                      onPressed: () {}),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 200),
                    child: Slider.adaptive(
                      value: .2,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
