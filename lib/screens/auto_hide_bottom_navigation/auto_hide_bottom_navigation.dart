import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AutoHideBottomNavigation extends StatefulWidget {
  const AutoHideBottomNavigation({super.key});

  @override
  State<AutoHideBottomNavigation> createState() =>
      _AutoHideBottomNavigationState();
}

class _AutoHideBottomNavigationState extends State<AutoHideBottomNavigation> {
  late ScrollController
      _scrollController; // Define controller to detect user scrolling
  bool _isScrolling = false; // Check scrolling or not
  Timer? _scrollTimer; // Timer to detect when user stops scrolling

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // Add Listener to detect user scrolling
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _scrollTimer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void _onScroll() {
    // Cancel the timer if it was already running
    _scrollTimer?.cancel();

    final userScrollDirection = _scrollController
        .position.userScrollDirection; // User scrolling direction

    // Show or hide BottomNavigationBar based on scroll direction
    if (userScrollDirection == ScrollDirection.forward && _isScrolling) {
      setState(() {
        _isScrolling = false;
      });
    } else if (userScrollDirection == ScrollDirection.reverse &&
        !_isScrolling) {
      setState(() {
        _isScrolling = true;
      });
    }

    // Show the BottomNavigationBar again after 200 milliseconds of inactivity
    _scrollTimer = Timer(const Duration(milliseconds: 200), () {
      if (_isScrolling) {
        setState(() {
          _isScrolling = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context); // Cache MediaQuery size
    final phoneHeight = size.height; // Phone's height
    final phoneWidth = size.width; // Phone's width

    return Scaffold(
      appBar: AppBar(
        title: const Text("Auto Hide Bottom Navigation"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: Offstage(
        offstage: _isScrolling,
        child: const _BottomNavigation(), // Display BottomNavigationBar
      ),
      body: SafeArea(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return _ItemContainer(
              index,
              phoneHeight: phoneHeight,
              phoneWidth: phoneWidth,
            );
          },
        ),
      ),
    );
  }
}

class _ItemContainer extends StatelessWidget {
  final int _index;
  final double phoneHeight;
  final double phoneWidth;

  const _ItemContainer(
    this._index, {
    super.key,
    required this.phoneHeight,
    required this.phoneWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: phoneHeight * 0.2,
      width: phoneWidth,
      color: Colors.red,
      child: Center(
        child: Text(
          "$_index",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 50,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.blueAccent,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(0.7),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ],
    );
  }
}
