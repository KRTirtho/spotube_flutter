import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/spotify.dart';
import 'package:spotube_flutter/components/Home.dart';
import 'package:spotube_flutter/provider/Auth.dart';
import 'package:spotube_flutter/provider/SpotifyDI.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(create: (context) => Auth()),
        ChangeNotifierProvider<SpotifyDI>(create: (context) {
          Auth authState = Provider.of<Auth>(context, listen: false);
          return SpotifyDI(SpotifyApi(SpotifyApiCredentials(
              authState.cliendId, authState.clientSecret)));
        })
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.greenAccent[400],
          primarySwatch: Colors.green,
          buttonColor: Colors.greenAccent[400],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.greenAccent[400],
          ),
        ),
        home: Home(),
      ),
    );
  }
}
