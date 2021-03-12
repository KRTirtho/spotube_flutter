import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/spotify.dart';
import 'package:spotube_flutter/components/TrackButton.dart';
import 'package:spotube_flutter/provider/SpotifyDI.dart';

class PlaylistView extends StatefulWidget {
  String playlist_id;
  PlaylistView(this.playlist_id);
  @override
  _PlaylistViewState createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SpotifyDI>(builder: (_, data, __) {
      return Scaffold(
        body: Container(
          child: Column(
            children: [
              Row(
                children: [
                  // nav back
                  BackButton(),
                  // heart playlist
                  IconButton(
                    icon: Icon(Icons.favorite_outline_rounded),
                    onPressed: () {},
                  ),
                  // play playlist
                  IconButton(
                    icon: Icon(Icons.play_arrow_rounded),
                    onPressed: () {},
                  ),
                ],
              ),
              Center(
                child: Text("Playlist Name",
                    style: Theme.of(context).textTheme.headline4),
              ),
              FutureBuilder<Iterable<Track>>(
                  future: data.spotfyApi.playlists
                      .getTracksByPlaylistId(widget.playlist_id)
                      .all(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text("Error occurred"));
                    }
                    if (!snapshot.hasData) {
                      return Center(child: Text("Loading.."));
                    }
                    List<Track> tracks = snapshot.data!.toList();
                    return Expanded(
                      child: Scrollbar(
                        isAlwaysShown: true,
                        child: ListView.builder(
                            itemCount: tracks.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return Column(
                                  children: [
                                    TrackButton(
                                        index: "#",
                                        trackName: "Title",
                                        artists: ["Artist"],
                                        album: "Album",
                                        playback_time: "Time"),
                                    Divider()
                                  ],
                                );
                              }
                              Track track = tracks[index - 1];
                              return TrackButton(
                                index: (index - 1).toString(),
                                thumbnail_url:
                                    "https://i.scdn.co/image/ab67616d00001e02b993cba8ff7d0a8e9ee18d46",
                                trackName: track.name,
                                artists:
                                    track.artists.map((e) => e.name).toList(),
                                album: track.album.name,
                                playback_time:
                                    track.duration.inMinutes.toString(),
                                onTap: () {},
                              );
                            }),
                      ),
                    );
                  }),
            ],
          ),
        ),
      );
    });
  }
}
