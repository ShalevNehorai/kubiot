import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:gap/gap.dart';
import 'package:kubiot/models/game_model.dart';
import 'package:kubiot/models/player_model.dart';
import 'package:kubiot/providers/game_data_provider.dart';
import 'package:kubiot/screens/enter.dart';
import 'package:kubiot/services/firebase_methods.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class Lobby extends StatefulWidget {
  static const String ROUTE_NAME = "/lobby";

  Lobby();

  @override
  _LobbyState createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> {

  final String urlName = "http://localhost:57679/#"+Enter.ROUTE_NAME+"/";

  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
          )
        ),
        child: SafeArea(
          child: Column(
            children: [
              StreamBuilder<DocumentSnapshot>(
                stream: Provider.of<GameDataProvider>(context).roomSnapshot,
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if(snapshot.hasError){
                    return const Center(child: Text('error'),);
                  }
          
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LinearProgressIndicator();
                  }
          
                  if(snapshot.hasData){
                    Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                    GameModel roomData = GameModel.fromMap(snapshot.data!.id, data);
                    GameDataProvider provider = Provider.of<GameDataProvider>(context);

                    _textEditingController.text = urlName + roomData.gameId;
          
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: roomData.players.length,
                            itemBuilder: (context, index) {
                              PlayerModel player = roomData.players.elementAt(index);
                              
                              var gradientColor = GradientTemplate.gradientTemplate[index%GradientTemplate.gradientTemplate.length].colors;

                              return Container(
                                width: double.infinity,
                                height: 80,
                                margin: EdgeInsets.all(8),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: gradientColor),
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black, 
                                      blurRadius: 20,
                                      offset: const Offset(0, 4),
                                    )
                                  ]
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(backgroundColor: player.color, maxRadius: 15),
                                        Gap(10),
                                        Column(
                                          children: [
                                            Text(player.name, style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white
                                            ),),
                                            provider.playerIndex == index? Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("(you)", style: TextStyle(color: Colors.white),),
                                            ) : Container(),
                                          ],
                                        ),
                                      ],
                                    ),
                                    roomData.ownerIndex == index ? Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: FaIcon(FontAwesomeIcons.crown, color: Colors.amber, )
                                    ) : Container(),
                                  ],
                                ),
                              );
                            },
                          ),
                          Gap(20),
                          ElevatedButton(
                            onPressed: provider.playerIndex == roomData.ownerIndex? (){
                              //start game
                              print(provider.playerIndex);
                            } : null,
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(provider.playerIndex == roomData.ownerIndex? Colors.green : Color.fromARGB(255, 80, 115, 86)),
                            ),
                            child: Text("Start")
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: TextField(
                              controller: _textEditingController,
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: "Invite friends",
                                labelStyle: TextStyle(color: Colors.white),
                                fillColor: Colors.blueGrey[900],
                                filled: true,
                                focusedBorder:  OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(color: Colors.blue, width: 2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(color: Colors.blue, width: 2),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.copy, color: Colors.blue,),
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(text: _textEditingController.text)).then((value) => 
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("text copyed")))
                                    );
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
          
                  return Center();
          
                }
              ),  
            ],
          ),
        ),
      )
    );
  }
}

class NameTile extends StatelessWidget {
  final DocumentSnapshot userSnapshot;
  final String currentId;

  NameTile(this.userSnapshot, this.currentId);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: Text(
          userSnapshot["name"],
          style: TextStyle(color: userSnapshot.id == currentId ? Colors.blue : Colors.black),
        ));
  }
}

class GradientColors {
  final List<Color> colors;
  GradientColors(this.colors);

  static List<Color> sky = [const Color(0xFF6448FE), const Color(0xFF5FC6FF)];
  static List<Color> sunset = [const Color(0xFFFE6197), const Color(0xFFFFB463)];
  static List<Color> sea = [const Color(0xFF61A3FE), const Color(0xFF63FFD5)];
  static List<Color> mango = [const Color(0xFFFFA738), const Color(0xFFFFE130)];
  static List<Color> fire = [const Color(0xFFFF5DCD), const Color(0xFFFF8484)];
}

class GradientTemplate {
  static List<GradientColors> gradientTemplate = [
    GradientColors(GradientColors.sky),
    GradientColors(GradientColors.sunset),
    GradientColors(GradientColors.sea),
    GradientColors(GradientColors.mango),
    GradientColors(GradientColors.fire),
  ];
}
