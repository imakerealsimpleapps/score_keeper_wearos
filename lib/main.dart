import 'package:flutter/material.dart';
import 'package:score_keeper/widgets/round_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wear_plus/wear_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Wear App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const WatchScreen(),
        debugShowCheckedModeBanner: false,
      );
}

class WatchScreen extends StatelessWidget {
  const WatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WatchShape(
      builder: (BuildContext context, WearShape shape, Widget? child) {
        return AmbientMode(
          builder: (context, mode, child) {
            return mode == WearMode.active
                ? const ActiveWatchFace()
                : const AmbientWatchFace();
          },
        );
      },
    );
  }
}

class AmbientWatchFace extends StatelessWidget {
  const AmbientWatchFace({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'FlutterOS',
                style: TextStyle(color: Colors.blue[600], fontSize: 30),
              ),
              const SizedBox(height: 15),
              const FlutterLogo(size: 60.0),
            ],
          ),
        ),
      );
}

class ActiveWatchFace extends StatefulWidget {
  const ActiveWatchFace({super.key});

  @override
  State<StatefulWidget> createState() => _ActiveWatchFaceState();
}

class _ActiveWatchFaceState extends State<ActiveWatchFace> {
  final Future<SharedPreferencesWithCache> _prefs =
      SharedPreferencesWithCache.create(
          cacheOptions: const SharedPreferencesWithCacheOptions(
              // This cache will only accept the key 'counter'.
              allowList: <String>{'lightScore', 'darkScore'}));

  int lightScore = 0;
  int darkScore = 0;

  static const String lightScoreName = 'lightScore';
  static const String darkScoreName = 'darkScore';

  @override
  void initState() {
    _loadScores();
    super.initState();
  }

  Future<void> _loadScores() async {
    final prefs = await _prefs;

    setState(() {
      lightScore = prefs.getInt(lightScoreName) ?? 0;
      darkScore = prefs.getInt(darkScoreName) ?? 0;
    });
  }

  void _incrementLightScore() {
    setState(() {
      lightScore++;
    });

    setScore(lightScoreName, lightScore);
  }

  void _decremenDarkScore() async {
    setState(() {
      if (darkScore > 0) {
        darkScore--;
      }
    });

    setScore(darkScoreName, darkScore);
  }

  void _incrementDarkScore() async {
    setState(() {
      darkScore++;
    });

    setScore(darkScoreName, darkScore);
  }

  void _decrementLightScore() {
    setState(() {
      if (lightScore > 0) {
        lightScore--;
      }
    });

    setScore(lightScoreName, lightScore);
  }

  void _clearScores() {
    setState(() {
      lightScore = 0;
      darkScore = 0;
    });
    setScore(lightScoreName, lightScore);
    setScore(darkScoreName, darkScore);
  }

  Future<void> setScore(String name, int value) async {
    final SharedPreferencesWithCache prefs = await _prefs;

    prefs.setInt(name, value);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 32.0,
              ),
              RoundButton(
                color: Colors.blue,
                onPressed: () {
                  _clearScores();
                },
                child: const Text('clear'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RoundButton(
                    color: Colors.white,
                    onPressed: () {
                      _incrementLightScore();
                    },
                    onLongPressed: () {
                      _decrementLightScore();
                    },
                    child: Text('$lightScore'),
                  ),
                  RoundButton(
                    color: Colors.blueGrey,
                    child: Text(
                      '$darkScore',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      _incrementDarkScore();
                    },
                    onLongPressed: () {
                      _decremenDarkScore();
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///
/// Idea
/// Score: Light, Dark -- stateful widget
/// center row
/// button with child
/// (white) (black)