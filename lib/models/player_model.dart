import 'dart:math';

import 'package:flutter/material.dart';

class PlayerModel{
  static const _startingDiceAmount = 5;

  final String name;
  final Color color; // will change to avatar picture
  late List<int> dice;
  late final int playerIndex;

  PlayerModel(this.name, {this.color = Colors.white}){
    dice = List.filled(_startingDiceAmount, 0);
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'color': color,
      'dice': dice,
    };
  }

  PlayerModel.fromMap(Map<String, dynamic> map) : 
    name = map['name'], color = map['color'], dice = map['dice'];


  void rollDice(){
    for(int i = 0; i < dice.length; i++){
      dice[i] = Random().nextInt(6) + 1;
    }
  }

  static List<Map<String, dynamic>> playerListToMap(List<PlayerModel> players) {
    List<Map<String, dynamic>> list = List.empty(growable: true);
    for (var element in players) {
      list.add(element.toMap());
    }

    return list;
  }

  static List<PlayerModel> playerListFromMap(List<dynamic> players) {
    List<PlayerModel> list = List.empty(growable: true);
    for (var element in players) {
      list.add(PlayerModel.fromMap(element));
    }

    return list;
  }

  void removeDie(){
    dice.removeAt(0);
  }

  bool inGame(){
    return dice.isNotEmpty;
  }

  List<int> countDice(){
    List<int> counts = List.filled(6, 0, growable: false);

    for(int die in dice){
      counts[die-1]++;
    }

    return counts;
  }
}