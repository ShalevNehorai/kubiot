import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kubiot/models/game_model.dart';
import 'package:kubiot/models/player_model.dart';
import 'package:provider/provider.dart';

class FirebaseMethods {
  static const String GAMES_COLLACTION = "games";
  static const String USERS_COLLACTION = "users";

  static FirebaseMethods? _instance;

  FirebaseMethods._internal();
  factory FirebaseMethods(){
    _instance ??= FirebaseMethods._internal();

    return _instance!;
  }

  Future<Stream<DocumentSnapshot<Object?>>> createNewGame(PlayerModel player) async {
    GameModel gameModel = GameModel(player);

    DocumentReference gameDoc = await FirebaseFirestore.instance.collection(GAMES_COLLACTION).add(gameModel.toMap());
    return gameDoc.snapshots();
  }

  Future<(Stream<DocumentSnapshot<Object?>>, int)> joinGame(PlayerModel player, String gameId) async{
    if(gameId.isNotEmpty){
      DocumentSnapshot<Map<String, dynamic>> gameDoc =
          await FirebaseFirestore.instance.collection(GAMES_COLLACTION).doc(gameId).get();

      if(gameDoc.exists){
        GameModel gameData = GameModel.fromMap(gameId, gameDoc.data()!);
        if(gameData.started){
          return Future.error("game already in prograss");
        }
        if(gameData.winner != ''){
          return Future.error("game end");
        }

        gameData.addPlayer(player);
        int index = gameData.players.length - 1;

        await FirebaseFirestore.instance.collection(GAMES_COLLACTION).doc(gameId).update(gameData.toMap());//posibly error when two players enters at the same time

        Stream<DocumentSnapshot<Object?>> docSnapshot =
            FirebaseFirestore.instance.collection(GAMES_COLLACTION).doc(gameId).snapshots();

        return (docSnapshot, index);
      }
      else{
        return Future.error("game not exists");
      }
    }
    else{
      return Future.error("game id not cant be empty");
    }
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
