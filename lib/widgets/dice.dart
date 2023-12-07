import 'package:flutter/material.dart';

class Dice extends StatefulWidget {
  final int number;
  final bool showNumber;

  Dice(this.number, this.showNumber, {super.key});

  @override
  State<Dice> createState() => _DiceState();
}

class _DiceState extends State<Dice> {
  final double size = 50;
  
  String _getText(){
    return widget.showNumber? widget.number.toString() : "?";
  }

  Color _getColor(){
    return widget.showNumber? Colors.transparent : Colors.black45;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          color: _getColor(),
        ),
        child: Center(
          child: Text(_getText())
        ),
    
      ),
    );
  }
}