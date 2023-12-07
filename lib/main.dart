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

    GameModel game = GameModel(PlayerModel("first", color: Colors.blue));
    game.addPlayer(PlayerModel("second", color: Colors.green));
    game.addPlayer(PlayerModel("third", color: Colors.red));
    game.addPlayer(PlayerModel("fourth", color: Colors.indigo));
    game.addPlayer(PlayerModel("fifth", color: Colors.cyan));

    game.started = true;

    return ChangeNotifierProvider(
      create: (context) => GameDataProvider(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: buildLiarDiceTheme(),
        routerConfig: GoRouter(
          routes: [
            GoRoute(path: '/', builder: ((context, state) => GamePage(game))),
            //GoRoute(path: '/', builder: ((context, state) => Enter())), // starting page
            GoRoute(path: Enter.ROUTE_NAME, builder: ((context, state) => Enter())),
            GoRoute(path: Enter.ROUTE_NAME + Enter.ROUTE_PARAMETERS, builder: ((context, state) => Enter(gameId: state.pathParameters['gameId']))),
            GoRoute(path: Lobby.ROUTE_NAME, builder: (context, state) => Lobby()),
          ]
        ),
      ),
    );
  }
}

ThemeData buildLiarDiceTheme() {
  return ThemeData(
    primaryColor: Color(0xFF00796B), // Tabletop green primary color
    colorScheme: ColorScheme.fromSwatch(
      accentColor: Color(0xFFCDDC39)
    ),
    scaffoldBackgroundColor: Color(0xFFC8E6C9), // Light green background color
    // useMaterial3: true,

    fontFamily: 'Roboto', // Use your preferred font family

    textTheme: TextTheme(
      titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 16.0),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF43A047), // Darker green for elevated buttons
        textStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    ),

    appBarTheme: AppBarTheme(
      color: Color(0xFF00796B), // Dark green for app bar
      titleTextStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    ),
  );
}
