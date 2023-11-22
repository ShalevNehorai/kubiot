import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kubiot/models/player_model.dart';
import 'package:kubiot/providers/game_data_provider.dart';
import 'package:kubiot/screens/lobby.dart';
import 'package:kubiot/services/firebase_methods.dart';
import 'package:kubiot/widgets/glowing_button.dart';
import 'package:provider/provider.dart';
import 'package:gap/gap.dart';

class Enter extends StatefulWidget {
  static final String ROUTE_NAME = '/enter';
  static final String ROUTE_PARAMETERS = '/:gameId';

  String? gameId;

  Enter({this.gameId});

  @override
  State<Enter> createState() => _EnterState();
}

class _EnterState extends State<Enter> {
  final TextEditingController tECname = TextEditingController();
  String? _errorText = null;

  void createGame(BuildContext context){
    PlayerModel player = PlayerModel(tECname.text);
    FirebaseMethods().createNewGame(player).then((snapshot) {
      Provider.of<GameDataProvider>(context, listen: false).updateRoomSnapshot(snapshot);
      Provider.of<GameDataProvider>(context, listen: false).updatePlayerIndex(0);

      context.go(Lobby.ROUTE_NAME);
    }).onError((error, stackTrace) {
      print(stackTrace);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
    });
  }

  void joinGame(BuildContext context){
    PlayerModel player = PlayerModel(tECname.text);
    FirebaseMethods().joinGame(player, widget.gameId!).then((record) {
      var (snapshot, index) = record;
      Provider.of<GameDataProvider>(context, listen: false).updateRoomSnapshot(snapshot);
      Provider.of<GameDataProvider>(context, listen: false).updatePlayerIndex(index);

      context.go(Lobby.ROUTE_NAME);
    }).onError((error, stackTrace) {
      print(stackTrace);
    });
  }

  @override
  void dispose() {
    tECname.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          
          gradient: LinearGradient(
            colors: [
              const Color(0xFF032400),
              const Color(0xFF1a4a2a),
              const Color(0xFF0b5323),
              const Color(0xFF086927),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: const [0.0, 0.2, 0.6, 1.0],
            tileMode: TileMode.clamp
          
        ),
          // image: DecorationImage(
          //   image: AssetImage("assets/photos/backgroud.jpg"),
          //   fit: BoxFit.fitHeight,
          // )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.gameId ?? "No game id", style: TextStyle(color: Colors.white),), //TODO delete later
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text("Kubiot", style: TextStyle(color: Colors.white, fontSize: 40)),
            ), //TODO will be the logo
      
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: TextField(
                controller: tECname,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
                decoration: InputDecoration(
                  hintText: "Enter your name",
                  errorText: _errorText,
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
            ),
            //TODO add die color picker
            Gap(20),

            GlowingButton(
              onTap: () async {
                String text = tECname.value.text;
          
                if(text.isEmpty){
                  setState(() {
                    _errorText = "name mast not be empty";
                  });
                  return;
                }          
                
                if (this.widget.gameId == null) {
                  createGame(context);
                } else {
                  joinGame(context);
                }    
              },
              colorStart: Colors.blueGrey, 
              colorEnd: Colors.lightBlue,
              child: Center(
                child: Text(this.widget.gameId == null ? "create" : "join", style: TextStyle(
                  fontSize: 24
                ),)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
