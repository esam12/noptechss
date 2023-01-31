import 'package:flutter/material.dart';

import 'login_shape_cipper.dart';

class LoginTop extends StatefulWidget {
  @override
  _LoginTopState createState() => _LoginTopState();
}

class _LoginTopState extends State<LoginTop>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _animation, _textAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.fastOutSlowIn),
    );
    _textAnimation = Tween(begin: 2.0, end: 0.0).animate(
        CurvedAnimation(parent: _animController, curve: Curves.decelerate));
    _animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: LoginShapeClipper(),
          child: Container(
            height: 300,
            color: Theme.of(context).primaryColor,
            /*decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF963668),
                  Color(0xFF6C0543),
                ],
              ),
            ),*/
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AnimatedBuilder(
                    animation: _animController,
                    builder: (BuildContext context, Widget? child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            _animation.value * width, 0.0, 0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(65),
                            color: Colors.white,
                          ),
                          child: Image.asset(
                            "assets/images/logo.png",
                            height: 130,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  AnimatedBuilder(
                    animation: _animController,
                    builder: (BuildContext context, Widget? child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            _textAnimation.value * width, 0.0, 0.0),
                        child: const Text(
                          "NopTechs",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Oswald",
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }
}
