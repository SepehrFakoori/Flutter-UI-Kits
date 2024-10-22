import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/screens/fluid_app_bar/data/text_string.dart';

class FluidAppBarScreen extends StatefulWidget {
  const FluidAppBarScreen({super.key});

  @override
  State<FluidAppBarScreen> createState() => _FluidAppBarScreenState();
}

class _FluidAppBarScreenState extends State<FluidAppBarScreen> {
  late ScrollController
      scrollController; // Define controller to detect user scrolling
  double percentage = 0.0; // Tracks the percentage of the screen scrolled.

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    // Add Listener to detect user scrolling
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Get the maximum height of the screen
    final double scrollMaxHeight = scrollController.position.maxScrollExtent;
    // Get user current position on screen
    double currentScrollPosition = scrollController.offset;
    setState(() {
      // Calculate the percentage that user scrolled the screen
      percentage = currentScrollPosition / scrollMaxHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context); // Cache Phone Size
    final phoneHeight = size.height; // Phone's Height

    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: FluidAppBar(percentage),
      // Fluid App Bar Widget get the percentage
      body: SafeArea(
        // Simple scrollable items
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              SizedBox(
                height: phoneHeight * 0.4,
                child: Image.asset(
                  "assets/images/fluid_screen_sample_image.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Lord Of The Rings: Triology",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                TextString.theText,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Our custom AppBar should implement PreferredSizeWidget (It Should has size)
class FluidAppBar extends StatelessWidget implements PreferredSizeWidget {
  double? percentage;

  FluidAppBar(this.percentage, {super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final phoneWidth = size.width; // Phone's width (Uses as AppBar width)

    return Stack(
      children: [
        Container(
          width: phoneWidth,
          color: const Color(0xffffffff),
        ),
        // Use Offstage for the time that the percentage is 0 so the widget should not paint on screen
        Offstage(
          offstage: percentage == 0 ? true : false,
          child: Container(
            width: phoneWidth * percentage!,
            // It Defines Container width (It's the container that shows scroll percent)
            color: const Color(0xffe5e5e5),
          ),
        ),
        Container(
          width: phoneWidth,
          color: Colors.transparent,
          child: const Center(
            child: Text(
              "Fluid App Bar Screen",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
      kToolbarHeight); //kToolbarHeight is the height of the toolbar component of the AppBar.
}
