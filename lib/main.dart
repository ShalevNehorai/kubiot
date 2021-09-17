import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kubiot/screens/404page.dart';
import 'package:kubiot/screens/enter.dart';
import 'package:kubiot/services/databasemethods.dart';
import 'package:kubiot/services/dynamic_link.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Loading(),
    );
  }
}

class Loading extends StatefulWidget {
  const Loading();

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
    String? roomId = await DynamicLinkHelper().getLinkData().onError(
        (error, stackTrace) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Page404())));

    if ((roomId == null) ||
        (await DatabaseMethods().isGameExists(roomId)) && !(await DatabaseMethods().isGameStarted(roomId))) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Entrie(roomId)));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Page404()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: CircularProgressIndicator(),
    ));
  }
}
