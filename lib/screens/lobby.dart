import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kubiot/services/databasemethods.dart';
import 'package:kubiot/services/dynamic_link.dart';
import 'package:share/share.dart';

class Lobby extends StatefulWidget {
  final String gameId;
  final String userId;

  Lobby({required this.gameId, required this.userId});

  @override
  _LobbyState createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> {
  late Stream<QuerySnapshot> userStream;
  String? gameLink;

  getUserStream() async {
    userStream = await DatabaseMethods().getUsersInGame(widget.gameId);
    setState(() {});
  }

  getGameLink() async {
    gameLink = await DynamicLinkHelper().createDynamicLink(widget.gameId);
    setState(() {});
  }

  @override
  void initState() {
    getUserStream();
    getGameLink();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        StreamBuilder(
            stream: userStream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot ds = snapshot.data!.docs[index];
                        return NameTile(ds, widget.userId);
                      },
                    )
                  : Text("loading");
            }),
        //if owner generate invite key
        SelectableText(gameLink ?? "game link showd be here"),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(onPressed: () => getGameLink(), child: Text("refresh link")),

        ElevatedButton(onPressed: () => Share.share(gameLink ?? "no link"), child: Text("copy link")),
        //if owner start button
      ],
    ));
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
