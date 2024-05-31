import 'package:flutter/material.dart';
import '../main.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateHome();
  }

  _navigateHome() async {
    await Future.delayed(Duration(seconds: 2), () {});
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
  }

  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            color: Theme.of(context).colorScheme.primary,
          ),
          Center(
            child: Image.asset(
              'assets/images/splash.png',
              height: 150,
              width: 150,
            ),
          ),
        ],
      ),
    );
    // Container(
    //   color: Colors.yellow,
    //   height: 200,
    // )
  }
}
