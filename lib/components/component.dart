import 'dart:async';

import 'package:flutter/material.dart';

class SplashButton extends StatelessWidget {
  SplashButton(
      {this.key,
      this.child,
      this.elevation: 0,
      this.onTap,
      this.onLongPress,
      this.padding,
      this.color,
      this.splash,
      this.highlightColor,
      this.radius,
      this.margin,
      this.shape, this.enableSplash: true,
      this.border});

  final Key key;
  final Widget child;
  final Function onTap;
  final Function onLongPress;
  final EdgeInsetsGeometry padding, margin;
  final Color color, splash, highlightColor;
  final BorderRadiusGeometry radius;
  final BoxBorder border;
  final double elevation;
  final ShapeBorder shape;
  final bool enableSplash;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.all(0),
      child: Material(
        key: key,
        elevation: elevation,
        color: color ?? Colors.transparent,
        // color: color == null ? Colors.transparent : color,
        borderRadius: radius,
        shape: shape,
        child: InkWell(
            onLongPress: onLongPress,
            splashColor: !enableSplash ? Colors.transparent : splash == null ? Color.fromRGBO(0, 0, 0, .03) : splash,
            highlightColor: !enableSplash ? Colors.transparent : highlightColor == null
                ? Color.fromRGBO(0, 0, 0, .03)
                : highlightColor,
            onTap: onTap,
            borderRadius: radius,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: radius,
                  border: border,
                  // color: color,
                ),
                padding: padding == null ? EdgeInsets.all(0) : padding,
                child: child)),
      ),
    );
  }
}

class ZoomIn extends StatefulWidget {
  ZoomIn({this.child}); final Widget child;

  @override
  _ZoomInState createState() => _ZoomInState();
}

class _ZoomInState extends State<ZoomIn> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      key: _scaffoldKey,
      scale: scaleAnimation,
      child: widget.child
    );
  }
}

class SlideUp extends StatefulWidget {
  final Widget child; final int delay; final double speed;
  SlideUp({@required this.child, this.delay, this.speed: 0.50});
  @override
  _SlideUpState createState() => _SlideUpState();
}

class _SlideUpState extends State<SlideUp> with TickerProviderStateMixin {
  AnimationController _animController; Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    final curve = CurvedAnimation(curve: Curves.decelerate, parent: _animController);
    _animOffset = Tween<Offset>(begin: Offset(0.0, widget.speed), end: Offset.zero).animate(curve);
    widget.delay == null ? _animController.forward() :Timer(Duration(milliseconds: widget.delay), () { _animController.forward(); });
  }

  @override
  void dispose() { _animController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return FadeTransition( child: SlideTransition( position: _animOffset, child: widget.child ), opacity: _animController );
  }
}