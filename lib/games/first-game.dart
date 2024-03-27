import 'dart:async';
import 'package:flutter/material.dart';
import 'package:joker/components/bg.dart';
import 'package:joker/logic/first_game_logic.dart';
import 'package:joker/menu.dart';

class FirstGameScreen extends StatefulWidget {
  const FirstGameScreen({super.key});

  @override
  State<FirstGameScreen> createState() => _FirstGameScreenState();
}

class _FirstGameScreenState extends State<FirstGameScreen> {
  var goodMoves = 0;

  String hoursString = '00',
      minuteString = '00',
      secondString = '00';

  int hours = 0,
      minutes = 0,
      seconds = 0;


  bool isTimerRunning = false;
  late Timer _timer;

  void startTimer() {
    setState(() {
      isTimerRunning = true;
    });
    _timer = Timer.periodic(
        const Duration(seconds: 1),
            (timer) {
          _startSecond();
        }
    );
  }

  void pauseTimer() {
    _timer.cancel();
    isTimerRunning = false;
  }

  void resetTimer () {
    _timer.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;
      secondString = "00";
      minuteString = "00";
      hoursString = "00";
    });
  }

  void _startSecond() {
    setState(() {
      if (seconds < 59) {
        seconds++;
        secondString = seconds.toString();
        if (secondString.length == 1) {
          secondString = "0" + secondString;
        }
      } else {
        _startMinute();
      }
    });
  }

  void _startMinute() {
    setState(() {
      if (minutes < 59) {
        seconds = 0;
        secondString = "00";
        minutes++;
        minuteString = minutes.toString();
        if (minuteString.length == 1) {
          minuteString = "0" + minuteString;
        }
      } else {
        _startHour();
      }
    });
  }

  void _startHour() {
    setState(() {
      seconds = 0;
      minutes = 0;
      secondString = "00";
      minuteString = "00";
      hours++;
      hoursString = hours.toString();
      if (hoursString.length == 1) {
        hoursString = "0" + hoursString;
      }
    });
  }

  void win() {
    if(goodMoves == 8) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                backgroundColor: Colors.transparent,
                content: Stack(
                  children: [
                    Positioned(
                      top: 350,
                      child:  Container(
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/fon_win.png",
                                ),
                                fit: BoxFit.fill
                            )
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 20,
                      left: 1,
                      bottom: 40,
                      child: Image.asset("assets/images/you_win.png"),
                    ),
                    Positioned(
                        top: 500,
                        right: 10,
                        left: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              child: Image.asset(
                                "assets/images/undo_button.png", height: 40,),
                              onTap: () {
                                _gameInfo.initGame();
                                goodMoves = 0;
                                moves = 0;
                                resetTimer();
                                startTimer();
                                Navigator.pop(context);
                              },
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                const MenuScreen()),),
                              child: Image.asset(
                                "assets/images/menu_button.png", height: 40,),
                            )
                          ],
                        )
                    )
                  ],
                )
            );
          }
      );
    }
  }


  int moves = 0;
  final FirstGameInfo _gameInfo = FirstGameInfo();

  @override
  void initState() {
    super.initState();
    _gameInfo.initGame();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    var theme = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          const BGScreen(backG: "assets/images/bg_gameplay.png",),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 35
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset("assets/images/settings.png", height: 50,),
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset("assets/images/top_bar.png",
                      height: 50,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      width: theme.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "MOVES: ${moves.toString()}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w700
                            ),
                          ),
                          Text(
                            "TIME: $hoursString:$minuteString:$secondString",
                            style: const TextStyle(
                                fontWeight: FontWeight.w700
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: theme.height / 2,
                  width: theme.width,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4
                    ),
                    itemCount: _gameInfo.picGame!.length,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            moves++;
                            _gameInfo.picGame![i] = _gameInfo.slotList[i];
                            _gameInfo.matchCheck.add
                              ({i: _gameInfo.slotList[i]});
                          });
                          if(_gameInfo.matchCheck.length == 2) {
                            if(_gameInfo.matchCheck[0].values.first ==
                                _gameInfo.matchCheck[1].values.first) {
                              goodMoves += 1;
                              if(goodMoves == 8) {
                                win();
                              }
                              _gameInfo.matchCheck.clear();
                            } else {
                              Future.delayed(
                                  const Duration(milliseconds: 500),
                                      () {
                                    setState(() {
                                      _gameInfo.picGame![_gameInfo
                                          .matchCheck[0].keys.first] =
                                          _gameInfo.slotEmpty;
                                      _gameInfo.picGame![_gameInfo
                                          .matchCheck[1].keys.first] =
                                          _gameInfo.slotEmpty;
                                      _gameInfo.matchCheck.clear();
                                    });
                                  }
                              );
                            }
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  _gameInfo.picGame![i],
                                ),
                              )
                            ),
                          ),
                        )
                      );
                    }
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        pauseTimer();
                      },
                      child: Image
                          .asset("assets/images/pause_button.png", height: 50,),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Image
                          .asset("assets/images/left_button.png", height: 50,),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          moves = 0;
                          goodMoves = 0;
                          resetTimer();
                          startTimer();
                          _gameInfo.initGame();
                        });
                      },
                      child: Image
                          .asset("assets/images/undo_button.png", height: 50,),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
