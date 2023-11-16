import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kubiot/models/game_model.dart';
import 'package:kubiot/providers/game_data_provider.dart';
import 'package:kubiot/services/firebase_methods.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class Lobby extends StatefulWidget {
  static const String ROUTE_NAME = "/lobby";

  

  Lobby();

  @override
  _LobbyState createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.blueGrey,
            ],
            begin: AlignmentDirectional.topCenter,
            end: AlignmentDirectional.bottomCenter
          )
        ),
        child: SafeArea(
          child: Column(
            children: [
              StreamBuilder<DocumentSnapshot>(
                stream: Provider.of<GameDataProvider>(context).roomSnapshot,
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if(snapshot.hasError){
                    return const Center(child: Text('error'),);
                  }
          
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LinearProgressIndicator();
                  }
          
                  if(snapshot.hasData){
                    Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                    GameModel roomData = GameModel.fromMap(snapshot.data!.id, data);
          
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: roomData.players.length,
                      itemBuilder: (context, index) {
                        return ListTile(title: Text(roomData.players.elementAt(index).name),);
                      },
                    );
                  }
          
                  return Center();
          
                }
              ),  
              //if owner generate invite key
              // SelectableText(gameLink ?? "game link showd be here"),
              // SizedBox(
              //   height: 20, 
              // ),
              // ElevatedButton(onPressed: () => getGameLink(), child: Text("refresh link")),
            
              // ElevatedButton(onPressed: () => Share.share(gameLink ?? "no link"), child: Text("copy link")),
              //if owner start button
            ],
          ),
        ),
      )
    );
  }
}

class NameTile extends StatelessWidget {
  final DocumentSnapshot userSnapshot;
  final String currentId;

  NameTile(this.userSnapshot, this.currentId);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: Text(
          userSnapshot["name"],
          style: TextStyle(color: userSnapshot.id == currentId ? Colors.blue : Colors.black),
        ));
  }
}
