import 'package:flutter/material.dart';
import 'package:flutter_personal_expenses/main.dart';

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
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
  }

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            fit: FlexFit.loose,
            flex: 5,
            child: Container(
              color: Theme.of(context).colorScheme.primary,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Image.asset(
                      'assets/images/splash.png',
                      height: 150,
                      width: 150,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Container(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          // Container(
          //   color: Colors.yellow,
          //   height: 200,
          // )
        ],
      ),
    );
  }
}
