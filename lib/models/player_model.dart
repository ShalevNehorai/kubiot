class PlayerModel{
  static const _startingDiceAmount = 5;

  final String name;
  late int diceAmount;
  late final int playerIndex;

  PlayerModel(this.name){
    diceAmount = _startingDiceAmount;
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'diceAmount': diceAmount
    };
  }

  PlayerModel.fromMap(Map<String, dynamic> map) : 
    name = map['name'], diceAmount = map['diceAmount'];


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
}