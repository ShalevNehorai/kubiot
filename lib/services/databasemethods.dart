import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  final String GAMES_COLLACTION = "games";
  final String USERS_COLLACTION = "users";

  Map<String, dynamic> createUserMap(String name, String dieColor) {
    return {"name": name, "die amount": 5, "die color": dieColor};
  }

  Future<String> createNewGame() async {
    Map<String, dynamic> gameInfo = {
      "started": false,
      "current tern": "rolling",
    };

    DocumentReference gameDoc = await FirebaseFirestore.instance.collection(GAMES_COLLACTION).add(gameInfo);
    return gameDoc.id;
  }

  Future<String> addGameOwner(String gameId, Map<String, dynamic> ownerInfo) async {
    DocumentReference gameDoc = FirebaseFirestore.instance.collection(GAMES_COLLACTION).doc(gameId);
    DocumentReference ownerDoc = await gameDoc.collection(USERS_COLLACTION).add(ownerInfo);

    Map<String, dynamic> updateGameInfo = {"ownerId": ownerDoc.id};

    gameDoc.set(updateGameInfo, SetOptions(merge: true));
    return ownerDoc.id;
  }
}
