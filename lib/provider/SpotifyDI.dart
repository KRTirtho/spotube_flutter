import 'package:flutter/cupertino.dart';
import 'package:spotify/spotify.dart';

class SpotifyDI with ChangeNotifier {
  SpotifyApi _spotifyApi;

  SpotifyDI(this._spotifyApi);

  SpotifyApi get spotfyApi => _spotifyApi;
}
