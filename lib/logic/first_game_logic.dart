class FirstGameInfo {
  List<String>? picGame;

  final List<String> slotList = [
    "assets/images/slot_ruby.png",
    "assets/images/slot_emerald.png",
    "assets/images/slot_cherry.png",
    "assets/images/slot_diamond.png",
    "assets/images/slot_binoculars.png",
    "assets/images/slot_emerald.png",
    "assets/images/slot_star.png",
    "assets/images/slot_plum.png",
    "assets/images/slot_apple.png",
    "assets/images/slot_diamond.png",
    "assets/images/slot_ruby.png",
    "assets/images/slot_star.png",
    "assets/images/slot_binoculars.png",
    "assets/images/slot_plum.png",
    "assets/images/slot_apple.png",
    "assets/images/slot_cherry.png",
  ];

  final List<Map<int, String>> matchCheck = [

  ];

  final String slotEmpty = "assets/images/slot_empty.png";
  final int slotCount = 16;

  void initGame() {
    picGame = List.generate(slotCount, (index) => slotEmpty);
  }
}
