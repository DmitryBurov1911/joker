import 'package:flutter/material.dart';
import 'package:joker/components/bg.dart';
import 'package:joker/menu.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MenuScreen()),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          const BGScreen(backG: "assets/images/bg.png",),
          const BGScreen(backG: "assets/images/bg_1.png",),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/load_crystal.png",
                height: 70,),
              const SizedBox(height: 10,),
              const Text(
                "Loading...",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
