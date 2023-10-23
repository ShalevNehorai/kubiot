import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:go_router/go_router.dart';
import 'package:kubiot/firebase_options.dart';
import 'package:kubiot/screens/404page.dart';
import 'package:kubiot/screens/enter.dart';
import 'package:kubiot/services/databasemethods.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  usePathUrlStrategy();
  // SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: GoRouter(
        routes: [
          GoRoute(path: '/', builder: ((context, state) => Entrie(null))),
          GoRoute(path: '/:gameId', builder: ((context, state) => Entrie(state.pathParameters['gameId'])))
        ]
      ),
    );
  }
}
