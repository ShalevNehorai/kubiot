import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kubiot/models/game_model.dart';
import 'package:kubiot/models/player_model.dart';

class GameDataProvider extends ChangeNotifier{
  GameModel? _gameData;
  Stream<DocumentSnapshot<Object?>>? _roomSnapshot;
  late int playerIndex;

  List<PlayerModel> _players = List.empty(growable: true);

  GameModel? get gameData => _gameData; 
  List<PlayerModel> get players => _players;

  Stream<DocumentSnapshot<Object?>> get roomSnapshot => _roomSnapshot!;

  void updateRoomSnapshot(Stream<DocumentSnapshot<Object?>> snapshot) {
    _roomSnapshot = snapshot;
    notifyListeners();
  }

  void updatePlayerIndex(index) {
    playerIndex = index;
    notifyListeners();
  }

  void updateRoomData(GameModel data) {
    _gameData = data;
    notifyListeners();
  }

  int addPlayerMap(Map<String, dynamic> playerData){
    players.add(PlayerModel.fromMap(playerData));
    notifyListeners();

    return players.length - 1;
  }

  int addPlayer(PlayerModel player){
    players.add(player);
    notifyListeners();

    return players.length - 1;
  }
}