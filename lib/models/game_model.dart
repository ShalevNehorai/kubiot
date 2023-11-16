import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kubiot/models/player_model.dart';

class GameModel{
  late List<PlayerModel> players;
  late int turnIndex;
  late int ownerIndex;
  late bool started;
  late String winner;
  late Timestamp createdTime;

  late String _gameId;

  GameModel(PlayerModel player){
    players = List.empty(growable: true);
    players.add(player);

    ownerIndex = 0;
    turnIndex = 0;
    started = false;
    winner = '';
    createdTime = Timestamp.now();
  }

  set gameId(String id) => _gameId = id;
  String get gameId => _gameId;

  Map<String, dynamic> toMap(){
    return{
      'createdTime': createdTime,
      'players': PlayerModel.playerListToMap(players),
      'turnIndex': turnIndex,
      'ownerIndex': ownerIndex,
      'started': started,
      'winner': winner
    };
  }

  GameModel.fromMap(String gameId, Map<String, dynamic> map) : 
    _gameId = gameId,
    createdTime = map['createdTime'],
    players = PlayerModel.playerListFromMap(map['players']),
    turnIndex = map['turnIndex'],
    ownerIndex = map['ownerIndex'],
    started = map['started'],
    winner = map['winner'];


  void addPlayer(PlayerModel player){
    players.add(player);
  }
}