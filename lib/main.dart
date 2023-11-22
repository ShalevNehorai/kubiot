import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:go_router/go_router.dart';
import 'package:kubiot/firebase_options.dart';
import 'package:kubiot/models/game_model.dart';
import 'package:kubiot/models/player_model.dart';
import 'package:kubiot/providers/game_data_provider.dart';
import 'package:kubiot/screens/enter.dart';
import 'package:kubiot/screens/game.dart';
import 'package:kubiot/screens/lobby.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  // usePathUrlStrategy();
  // SystemChrome.setEnabledSystemUIOverlays([]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    PlayerModel player = PlayerModel("first");
    GameModel game = GameModel(player);
    game.addPlayer(PlayerModel("second"));
    game.addPlayer(PlayerModel("third"));


    return ChangeNotifierProvider(
      create: (context) => GameDataProvider(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: Typography.whiteHelsinki,
          primarySwatch: Colors.blue,
          primaryColor: Colors.blueGrey[700]
        ),
        routerConfig: GoRouter(
          routes: [
            //GoRoute(path: '/', builder: ((context, state) => GamePage(game))),
            GoRoute(path: '/', builder: ((context, state) => Enter())), // starting page
            GoRoute(path: Enter.ROUTE_NAME, builder: ((context, state) => Enter())),
            GoRoute(path: Enter.ROUTE_NAME + Enter.ROUTE_PARAMETERS, builder: ((context, state) => Enter(gameId: state.pathParameters['gameId']))),
            GoRoute(path: Lobby.ROUTE_NAME, builder: (context, state) => Lobby()),
          ]
        ),
      ),
    );
  }
}
