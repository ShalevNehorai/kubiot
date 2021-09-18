import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  static const String GAMES_COLLACTION = "games";
  static const String USERS_COLLACTION = "users";

  Map<String, dynamic> createUserMap(String name, String dieColor) {
    return {"name": name, "die amount": 5, "die color": dieColor};
  }

  Future<String> createNewGame() async {
    Map<String, dynamic> gameInfo = {
      "started": false,
      "current tern": "rolling",
      "created ts": Timestamp.now()
    };

    DocumentReference gameDoc = await FirebaseFirestore.instance.collection(GAMES_COLLACTION).add(gameInfo);
    return gameDoc.id;
  }

  Future<bool> isGameExists(String? gameId) async {
    if (gameId == null) {
      return false;
    }

    DocumentSnapshot gameDoc = await FirebaseFirestore.instance.collection(GAMES_COLLACTION).doc(gameId).get();

    return gameDoc.exists;
  }

  Future<bool> isGameStarted(String? gameId) async {
    if (gameId == null) {
      return false;
    }

    DocumentSnapshot gameDoc = await FirebaseFirestore.instance.collection(GAMES_COLLACTION).doc(gameId).get();

    return gameDoc["started"];
  }

  Future<String> addGameOwner(String gameId, Map<String, dynamic> ownerInfo) async {
    DocumentReference gameDoc = FirebaseFirestore.instance.collection(GAMES_COLLACTION).doc(gameId);
    DocumentReference ownerDoc = await gameDoc.collection(USERS_COLLACTION).add(ownerInfo);

    Map<String, dynamic> updateGameInfo = {"ownerId": ownerDoc.id};

    gameDoc.set(updateGameInfo, SetOptions(merge: true));
    return ownerDoc.id;
  }

  Future<String> addUserToGame(String gameId, Map<String, dynamic> userInfo) async {
    DocumentReference gameDoc = FirebaseFirestore.instance.collection(GAMES_COLLACTION).doc(gameId);
    DocumentReference userDoc = await gameDoc.collection(USERS_COLLACTION).add(userInfo);

    return userDoc.id;
  }

  Future<Stream<QuerySnapshot>> getUsersInGame(String gameId) async {
    return FirebaseFirestore.instance.collection(GAMES_COLLACTION).doc(gameId).collection(USERS_COLLACTION).snapshots();
  }
}
