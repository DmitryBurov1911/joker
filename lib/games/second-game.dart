import 'dart:async';
import 'package:flutter/material.dart';
import 'package:joker/components/bg.dart';
import 'package:joker/components/grid-button.dart';
import 'package:joker/logic/first_game_logic.dart';
import 'package:joker/menu.dart';

class SecondGameScreen extends StatefulWidget {
  const SecondGameScreen({super.key});

  @override
  State<SecondGameScreen> createState() => _SecondGameScreenState();
}

class _SecondGameScreenState extends State<SecondGameScreen> {
  var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
  bool statusPause = true;
  bool isActive = false;

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

  int moves = 0;
  final FirstGameInfo _gameInfo = FirstGameInfo();

  @override
  void initState() {
    super.initState();
    _gameInfo.initGame();
    startTimer();
    numbers.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    var theme = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          const BGScreen(backG: "assets/images/bg_gameplay1.png",),
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
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Image.asset("assets/images/fon.png",),
                    Positioned(
                      top: 15,
                      child: SizedBox(
                        height: theme.height / 2,
                        width: theme.width / 1.5,
                        child: statusPause ? GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4
                            ),
                            itemCount: numbers.length,
                            itemBuilder: (context, i) {
                              return numbers[i] != 0 ? GridButton(
                                numbers[i].toString(),
                                  () {
                                    clickGrid(i);
                                  },
                              ): const SizedBox.shrink();
                            }
                          ) : GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4
                            ),
                            itemCount: numbers.length,
                            itemBuilder: (context, i) {
                              return numbers[i] != 0 ? GridButton(
                                numbers[i].toString(),
                                    () {
                                  () {};
                                },
                              ): const SizedBox.shrink();
                            }
                        ),
                        ),
                    )

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    statusPause ? InkWell(
                      onTap: () {
                        statusPause = false;
                        pauseTimer();
                        setState(() {

                        });
                      },
                      child: Image
                          .asset("assets/images/pause_button.png", height: 50,),
                    ) :
                    InkWell(
                      onTap: () {
                        startTimer();
                        statusPause = true;
                        setState(() {

                        });
                      },
                      child: Image
                          .asset("assets/images/play_button.png", height: 50,),
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

  void clickGrid(i) {
    if (i - 1 >= 0 && numbers[i - 1] == 0 && i % 4 != 0 ||
        i + 1 < 16 && numbers[i + 1] == 0 && (i + 1) % 4 != 0 ||
        (i - 4 >= 0 && numbers[i - 4] == 0) ||
        (i + 4 < 16 && numbers[i + 4] == 0)) {
      setState(() {
        moves++;
        numbers[numbers.indexOf(0)] = numbers[i];
        numbers[i] = 0;
      });
    }
    checkWin();
  }

  bool isSorted(List list) {
    int prev = list.first;
    for (var i = 1; i < list.length - 1; i++) {
      int next = list[i];
      if (prev > next) return false;
      prev = next;
    }
    return true;
  }

  void checkWin() {
    if (isSorted(numbers)) {
      isActive = false;
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
}
