import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ClickClickClick());
}

class ClickClickClick extends StatelessWidget {
  const ClickClickClick({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Click Click Click',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
          bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: Colors.transparent,
          )),
      home: const Clicker(title: 'Click Click Click'),
    );
  }
}

class Clicker extends StatefulWidget {
  const Clicker({super.key, required this.title});

  final String title;

  @override
  State<Clicker> createState() => _ClickerState();
}

class _ClickerState extends State<Clicker> {
  int _counter = 0;
  var _text = 'Click the button at the bottom right!';
  var _goal = "";
  var _clicks = "";
  var _second = "";
  var _increment = 0;

  void _checks() {
    setState(() {
      if (_counter == 1) {
        _text = "Wow! You learned how to click the button. Do it again.";
      } else if (_counter == 2) {
        _text = "Keep clicking that button!";
      } else if (_counter == 10) {
        _text = "Congrats! Your next goal is in the bottom left corner.";
        _goal = "Goal: 100 clicks";
      } else if (_counter >= 100 && _counter < 200) {
        _text = "Each click now increases the counter by two (2/click).";
        _goal = "Goal: 200 clicks";
        _clicks = "Clicks per click: 2";
      } else if (_counter >= 200 && _counter < 300) {
        _text = "The counter will now increase by 1 each second (1/sec)";
        _goal = "Goal: 300 clicks";
        _second = "Clicks per second: 1";
        _increment = 1;
      } else if (_counter >= 300 && _counter < 500) {
        _text = "The counter will now increase by 2/sec and 3/click";
        _goal = "Goal: 500 clicks";
        _second = "Clicks per second: 2";
        _clicks = "Clicks per click: 3";
        _increment = 2;
      } else if (_counter >= 500 && _counter < 1000) {
        _text = "The counter will now increase by 3/sec.";
        _goal = "Goal: 1000 clicks";
        _second = "Clicks per second: 3";
        _increment = 3;
      } else if (_counter >= 1000) {
        _text = "Congratulations! You have won the game. for now...";
        _goal = "All goals complete";
      }
    });
  }

  void _actions() {
    setState(() {
      if (_counter >= 100 && _counter < 200) {
        _counter++;
      } else if (_counter >= 200 && _counter < 300) {
        _counter++;
      } else if (_counter >= 300 && _counter < 500) {
        _counter++;
        _counter++;
      } else if (_counter >= 500 && _counter < 1000) {
        _counter++;
        _counter++;
      }
    });
  }

  void _timer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _counter += _increment;
        _checks();
      });
    });
  }

  @override
  void initState() {
    setState(() {
      _timer();
    });
    super.initState();
  }

  final clickSound =
      UrlSource('https://freesfx.co.uk/sound/16960_1461335343.mp3');

  void _incrementCounter() {
    setState(() async {
      final player = AudioPlayer();
      _actions();
      _counter++;
      _checks();
      await player.play(clickSound);
    });
  }

  void _reset() {
    setState(() {
      _counter = 0;
      _text = 'Click the button at the bottom right!';
      _goal = "";
      _clicks = "";
      _second = "";
      _increment = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _text,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(onPressed: _reset, child: const Text('Reset')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Click!',
        child: const Icon(Icons.add),
      ),
      bottomSheet: SizedBox(
        height: 75.0,
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[Text(_second), Text(_clicks), Text(_goal)],
          ),
        ),
      ),
    );
  }
}