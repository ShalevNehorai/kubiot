import 'package:flutter/material.dart';
import 'package:kubiot/models/game_model.dart';

class GamePage extends StatefulWidget {
  static const ROUTE_NAME = "/game";

  GameModel game;

  GamePage(this. game, {super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}