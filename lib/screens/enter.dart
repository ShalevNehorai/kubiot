import 'package:flutter/material.dart';
import 'package:kubiot/screens/lobby.dart';
import 'package:kubiot/services/databasemethods.dart';

class Entrie extends StatelessWidget {
  String? gameId;

  Entrie(this.gameId);

  final TextEditingController tECname = TextEditingController();

  String diesColor = "rainbow";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(gameId ?? "No game id"), //TODO delete later
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text("Kubiot", style: TextStyle(fontSize: 40)),
          ), //TODO will be the logo

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: TextField(
              controller: tECname,
              decoration: InputDecoration(hintText: "Enter your name"),
            ),
          ),
          //TODO add die color picker
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ButtonStyle(),
            onPressed: () async {
              String gameId = await DatabaseMethods().createNewGame();

              String ownerId = await DatabaseMethods()
                  .addGameOwner(gameId, DatabaseMethods().createUserMap(tECname.text, diesColor));

              print("$gameId,  $ownerId");

              //move to the lobby and create new game
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Lobby(
                            gameId: gameId,
                            userId: ownerId,
                          )));
            },
            child: Text("create"),
          )
        ],
      ),
    );
  }
}
