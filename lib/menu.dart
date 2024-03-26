import 'package:flutter/material.dart';
import 'package:joker/components/bg.dart';
import 'package:joker/games/first-game.dart';
import 'package:joker/games/second-game.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          const BGScreen(backG: "assets/images/bg.png",),
          const BGScreen(backG: "assets/images/bg_1.png",),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/joker.png",
                  height: theme.size.height / 3,),
                const SizedBox(height: 10,),
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder:
                          (context) => const FirstGameScreen())
                  ),
                  child: Image.asset(
                    "assets/images/game1.png",
                    height: theme.size.height / 12,
                    width: theme.size.width / 1.5,
                  ),
                ),
                const SizedBox(height: 10,),
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder:
                          (context) => const SecondGameScreen())
                  ),
                  child: Image.asset(
                    "assets/images/game2.png",
                    height: theme.size.height / 12,
                    width: theme.size.width / 1.5,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 50,
            child: InkWell(
              onTap: () {},
              child: Image.asset(
                "assets/images/privatePolicy.png",
                height: theme.size.height / 18,
                width: theme.size.width / 1.5,
              ),
            ),
          )
        ],
      ),
    );
  }
}
