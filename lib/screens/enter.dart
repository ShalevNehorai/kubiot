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
              late String userId;

              Map<String, dynamic> userMap = DatabaseMethods().createUserMap(tECname.text, diesColor);

              if (this.gameId == null) {
                this.gameId = await DatabaseMethods().createNewGame();

                userId = await DatabaseMethods().addGameOwner(this.gameId!, userMap);
                print("$gameId,  $userId");
              } else {
                userId = await DatabaseMethods().addUserToGame(this.gameId!, userMap);
              }

              //move to the lobby and create new game
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Lobby(
                            gameId: this.gameId!,
                            userId: userId,
                          )));
            },
            child: Text(this.gameId == null ? "create" : "join"),
          )
        ],
      ),
    );
  }
}
