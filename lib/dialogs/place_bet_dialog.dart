import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kubiot/models/game_model.dart';
import 'package:kubiot/models/player_model.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class BetDialog extends StatefulWidget {
  final GameModel gameModel;

  BetDialog(this.gameModel, {super.key});

  @override
  State<BetDialog> createState() => _BetDialogState();
}

class _BetDialogState extends State<BetDialog> {

  late TextEditingController _diceBetController = TextEditingController();
  late TextEditingController _amountBetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    PlayerModel player = widget.gameModel.players[widget.gameModel.turnIndex];

    return Dialog(
      insetPadding: EdgeInsets.all(16),
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Text("Your dice: ${player.countDice().toString()}"),
            SizedBox(height: 50,),
            Text("last bet: ${widget.gameModel.getCurrentBetString()}", style: TextStyle(color: Colors.black, fontSize: 24),),
            SizedBox(height: 50,),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: NumberInputWithIncrementDecrement(
                    controller: _diceBetController,
                    initialValue: max(widget.gameModel.currentDiceBet, 1),
                    min: max(widget.gameModel.currentDiceBet, 1),
                    max: 6,
                    style: TextStyle(
                      fontSize: 24  
                    ),
                  ),
                ),
                Gap(10),
                Flexible(
                  flex: 1,
                  child: NumberInputWithIncrementDecrement(
                    controller: _amountBetController,
                    initialValue: max(widget.gameModel.currentAmountBet, 1),
                    min: _diceBetController.text == widget.gameModel.currentDiceBet.toString()?  max(widget.gameModel.currentAmountBet, 1) : 1,
                    style: TextStyle(
                      fontSize: 24  
                    ),
                  ),
                ),
              ],
            ),
            // SizedBox(height: 50,),
            ElevatedButton(
              onPressed: () {
                bool success = widget.gameModel.newBet(int.parse(_diceBetController.value.text), int.parse(_amountBetController.text));
                if(success)
                  Navigator.pop(context, "bet");
                
              },
              child: Text("PLACE BET")
            ),
            SizedBox(width: 20,),
            ElevatedButton(
              onPressed: () {
                
              },
              child: Text("Bull shit")
            ),
          ],
        ),
      ),
    );
  }
}