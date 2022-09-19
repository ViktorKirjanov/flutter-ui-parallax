import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parallax/_widgets/bg_layers/fog_layer.dart';
import 'package:parallax/_widgets/bg_layers/mountains_layer.dart';
import 'package:parallax/_widgets/slogan.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '_widgets/bg_layers/forest_layer.dart';
import '_widgets/content.dart';
import '_widgets/scroll_arrow.dart';
import '_widgets/top_menu.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AccelerometerEvent _acceleration = AccelerometerEvent(0, 0, 0);
  late StreamSubscription<AccelerometerEvent> _streamSubscription;
  late ScrollController _scrollController;

  // horisontal sensitivity
  final _forestSensitivity = 9;
  final _headerSensitivity = 3;
  final _mountainSensitivity = 6;
  final _fogSensitivity = 3;

  // offset multiply
  final _forestScrollOffsetMultiply = 1.5;
  final _headerScrollOffsetMultiply = 1.75;
  final _mountainScrollOffsetMultiply = 1.30;
  final _fogScrollOffsetMultiply = 1.15;

  final _duration = const Duration(milliseconds: 250);
  final _initAnimationDuration = const Duration(milliseconds: 1200);
  final __startAnimationTextOpacityAt = 50;
  final _arrowLineWidth = 2.0;
  final _arrowSize = 30.0;
  final _maxPortraitTopOffset = 250.0;
  final _maxLandscapeTopOffset = 380.0;

  var _scrollOffset = 0.0;
  var _opacity = 1.0;
  var _textOpacity = 0.0;
  var _startAnimation = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(() => _onScroll());
    _streamSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _acceleration = event;
      });
    });
  }

  void _onScroll() {
    setState(() {
      var maxOffset = MediaQuery.of(context).orientation == Orientation.portrait
          ? _maxPortraitTopOffset
          : _maxLandscapeTopOffset;
      if (_scrollController.offset <= maxOffset) {
        _scrollOffset = _scrollController.offset;
      } else {
        _scrollController.jumpTo(maxOffset);
      }

      // 1 to 0 opacity
      if (_scrollOffset <= 0) {
        _opacity = 1;
      } else if (_scrollOffset > 0 && _scrollOffset < 100) {
        _opacity = (1 - _scrollOffset / 100);
      } else {
        _opacity = 0;
      }

      // 0 to 1 opacity, text opacity
      if (_scrollOffset <= __startAnimationTextOpacityAt) {
        _textOpacity = 0.0;
      } else if (_scrollOffset >= 100 + __startAnimationTextOpacityAt) {
        _textOpacity = 1.0;
      } else {
        _textOpacity = (_scrollOffset - __startAnimationTextOpacityAt) / 100;
      }
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      setState(() {
        _startAnimation = false;
      });
    });

    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: OrientationBuilder(builder: (context, orientation) {
          if (orientation == Orientation.portrait &&
              _scrollOffset > _maxPortraitTopOffset) {
            Future.delayed(const Duration(milliseconds: 100)).then(
                (value) => _scrollController.jumpTo(_maxPortraitTopOffset));
          }

          return Stack(
            children: <Widget>[
              _buildFog(),
              _buildMountain(isPortrait),
              _buildHeader(),
              _buildForest(isPortrait),
              _buildScrollArrow(),
              _buildContent(),
              _buildTopMenu(),
              _buildScrollView(),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildFog() {
    return AnimatedPositioned(
      duration: _duration,
      top: 0 - _scrollOffset * _fogScrollOffsetMultiply,
      right: _acceleration.x * -_fogSensitivity - 100,
      left: _acceleration.x * _fogSensitivity - 100,
      child: const FogLayer(),
    );
  }

  Widget _buildMountain(bool isPortrait) {
    return AnimatedPositioned(
      duration: _duration,
      top: 200 - _scrollOffset * _mountainScrollOffsetMultiply,
      right: (isPortrait ? _acceleration.x : _acceleration.y) *
              -_mountainSensitivity -
          100,
      left: (isPortrait ? _acceleration.x : _acceleration.y) *
              _mountainSensitivity -
          100,
      child: const MountainsLayer(),
    );
  }

  Widget _buildForest(bool isPortrait) {
    return AnimatedPositioned(
      duration: _duration,
      top: 300 - _scrollOffset * _forestScrollOffsetMultiply,
      right: (isPortrait ? _acceleration.x : _acceleration.y) *
              -_forestSensitivity -
          200,
      left: (isPortrait ? _acceleration.x : _acceleration.y) *
              _forestSensitivity -
          200,
      child: const ForestLayer(),
    );
  }

  Widget _buildHeader() {
    var hasOrientationAnimation =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return AnimatedPositioned(
      duration: _duration,
      top: 85 - _scrollOffset * _headerScrollOffsetMultiply,
      right:
          hasOrientationAnimation ? _acceleration.x * -_headerSensitivity : 0,
      left: hasOrientationAnimation ? _acceleration.x * _headerSensitivity : 0,
      child: Slogan(opacity: _opacity),
    );
  }

  Widget _buildContent() {
    return AnimatedPositioned(
      duration: _duration,
      top: 450 - _scrollOffset,
      left: 15,
      right: 15,
      child: Content(opacity: _textOpacity),
    );
  }

  Widget _buildScrollArrow() {
    return AnimatedPositioned(
      duration: _initAnimationDuration,
      left: 0,
      right: 0,
      top: _startAnimation
          ? MediaQuery.of(context).size.height
          : MediaQuery.of(context).size.height / 2,
      child: Center(
        child: ScrollArrow(
          arrowLineHeight: MediaQuery.of(context).size.height / 2.3,
          arrowSize: _arrowSize,
          arrowLineWidth: _arrowLineWidth,
          opacity: _opacity,
        ),
      ),
    );
  }

  Widget _buildTopMenu() {
    return AnimatedPositioned(
      duration: _initAnimationDuration,
      top: _startAnimation ? -100 : 0,
      left: 0,
      right: 0,
      child: const TopMenu(),
    );
  }

  Widget _buildScrollView() {
    return Positioned.fill(
      child: SingleChildScrollView(
        controller: _scrollController,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 3,
        ),
      ),
    );
  }
}
