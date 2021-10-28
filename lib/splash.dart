
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {


  late AnimationController _controller;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xff121212),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: const [
           AnimatedImageContainer(imagePath: "assets/bengal-cat.png"),
           AnimatedImageContainer(imagePath: "assets/bulldog.png"),
          ],
        ),
      )
    );

  }

}


class AnimatedImageContainer extends StatelessWidget {
  final String imagePath;

  const AnimatedImageContainer({Key? key, required this.imagePath, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      height: 100,
      alignment: Alignment.center,
      curve: Curves.easeIn,
      decoration:BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath,),

        )
      ),
    );
  }
}

