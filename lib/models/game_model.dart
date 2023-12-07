import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kubiot/models/player_model.dart';

class GameModel{
  late List<PlayerModel> players;
  late int turnIndex;
  late int ownerIndex;
  late bool started;
  late String winner;
  late Timestamp createdTime;
  late int currentDiceBet;
  late int currentAmountBet;

  late String _gameId;

  GameModel(PlayerModel player){
    players = List.empty(growable: true);
    players.add(player);

    ownerIndex = 0;
    turnIndex = -1;
    started = false;
    winner = '';
    createdTime = Timestamp.now();
    currentAmountBet = 0;
    currentDiceBet = 0;
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
      'winner': winner,
      'currentAmountBet':currentAmountBet,
      'currentDieBet':currentDiceBet
    };
  }

  GameModel.fromMap(String gameId, Map<String, dynamic> map) : 
    _gameId = gameId,
    createdTime = map['createdTime'],
    players = PlayerModel.playerListFromMap(map['players']),
    turnIndex = map['turnIndex'],
    ownerIndex = map['ownerIndex'],
    started = map['started'],
    winner = map['winner'],
    currentAmountBet = map['currentAmountBet'],
    currentDiceBet = map['currentDieBet'];


  void addPlayer(PlayerModel player){
    players.add(player);
  }

  void nextTrun(){
    do{
      turnIndex++;
      turnIndex %= players.length;
    } while(!players.elementAt(turnIndex).inGame());
  }

  String getCurrentBetString(){
    return "die: " + currentDiceBet.toString() + "  amount: " + currentAmountBet.toString();
  }

  bool newBet(int diceBet, int amountBet){
    if(diceBet < currentDiceBet || (diceBet == currentDiceBet && amountBet < currentAmountBet)){
      return false;
    }

    currentDiceBet = diceBet;
    currentAmountBet = amountBet;
    return true;
  }


}