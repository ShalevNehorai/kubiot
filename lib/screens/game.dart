import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kubiot/models/game_model.dart';
import 'package:kubiot/models/player_model.dart';
import 'package:kubiot/widgets/dice.dart';
import 'package:kubiot/dialogs/place_bet_dialog.dart';

class GamePage extends StatefulWidget {
  static const ROUTE_NAME = "/game";

  GameModel game;

  GamePage(this.game, {super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(widget.game.turnIndex == -1)//rolling
      {
        for(var player in widget.game.players){
          player.rollDice();
        }
        setState(() { 
          widget.game.nextTrun();
        });
      }
    });
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    showDialog(context: context, barrierDismissible: false, builder: (context) {
      return BetDialog(widget.game);
    },).then((value) => {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF032400),
              const Color(0xFF1a4a2a),
              const Color(0xFF0b5323),
              const Color(0xFF086927),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: const [0.0, 0.2, 0.6, 1.0],
            tileMode: TileMode.clamp
          ),
        ),
        child: ListView.builder(
          // shrinkWrap: true,
          itemCount: widget.game.players.length,
          itemBuilder: (context, index) {
            PlayerModel player = widget.game.players.elementAt(index);
            // player.rollDice();
            return Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: Color.fromARGB(157, 96, 90, 90),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: index == widget.game.turnIndex? Colors.blue :Colors.white, width: 4,),
                boxShadow: [
                  BoxShadow(color: index == widget.game.turnIndex? Colors.blue : Colors.white, blurRadius: 5, spreadRadius: 2)
                ], 
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(backgroundColor: player.color,),
                  Gap(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(player.name, style: TextStyle(
                        color: Colors.black, fontSize: 24, 
                      ),),
                      Gap(10),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.75,
                        height: 50,
                        child: Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
                            children: List.generate(5, (i) => Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Dice(player.dice[i], true),
                            ))
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}