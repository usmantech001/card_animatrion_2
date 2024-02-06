import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(brightness: Brightness.dark),
      theme: ThemeData(brightness: Brightness.dark),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _topAnimationController;
  late Animation _topAnimation;
  late Animation _leftAnimation;
  late Animation _colorAnimation;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _topAnimationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    _leftAnimation =
        Tween<double>(begin: 0, end: 300).animate(_animationController);
    _colorAnimation = ColorTween(begin: Colors.blue, end: Colors.red)
        .animate(_animationController);
    _topAnimation =
        Tween<double>(begin: 0, end: 300).animate(_topAnimationController);

        

  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _topAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 30),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Button(
            text: 'Stop',
            onTap: () {
              if (_animationController.status == AnimationStatus.forward ||
                  _animationController.status == AnimationStatus.reverse) {
                _animationController.stop();
                _animationController.removeStatusListener((status) {});
              } else if (_topAnimationController.status ==
                      AnimationStatus.forward ||
                  _topAnimationController.status == AnimationStatus.reverse) {
                _topAnimationController.stop();
                _topAnimationController.removeStatusListener((status) {});
              
               
              }
            },
          ),
          Button(
            text: 'Animate',
            onTap: () {
              if (_topAnimationController.status ==
                  AnimationStatus.reverse) {
                    _topAnimationController.reverse();
           
              }else
              if (_animationController.status == AnimationStatus.dismissed) {
                _animationController.forward();
              } else if (_animationController.status ==
                  AnimationStatus.forward) {
                    
                _animationController.forward();
              } else if (_animationController.status ==
                  AnimationStatus.reverse) {
                   
                _animationController.reverse();
              } else if (_topAnimationController.status ==
                  AnimationStatus.dismissed) {
                _topAnimationController.forward();
              } else if (_topAnimationController.status ==
                  AnimationStatus.forward) {
                _topAnimationController.forward();
              } 

              _animationController.addStatusListener((status) {
                if (status == AnimationStatus.completed) {
                  _topAnimation = Tween<double>(
                          begin: 0, end: 300)
                      .animate(_topAnimationController);
                  _topAnimationController.forward();
                } else if (status == AnimationStatus.dismissed) {
                  _topAnimationController.reverse();
                }
              });
              _topAnimationController.addStatusListener((status) {
                if (status == AnimationStatus.completed) {
                  _animationController.reverse();
                } else if (status == AnimationStatus.dismissed) {
                  _animationController.forward();
                }
              });
            },
          )
        ]),
      ),
      body: AnimatedBuilder(
        animation: _animationController,

        builder: (context, child) {
          return SafeArea(
            child: AnimatedBuilder(
                animation: _topAnimationController,
                builder: (BuildContext context, Widget? child) {
                  return Container(
                    margin: EdgeInsets.only(
                      left: _leftAnimation.value,
                      top: _topAnimation.value,
                    ),
                    height: 100,
                    width: 100,
                    color: _colorAnimation.value,
                  );
                  
                },
                child: child),
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class Button extends StatelessWidget {
  String text;
  VoidCallback onTap;
  Button({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 80,
        height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.blue,
          ),
       
          child: Text(text)),
    );
  }
}
