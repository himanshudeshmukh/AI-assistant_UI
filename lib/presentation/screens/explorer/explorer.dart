import 'dart:math';
import 'package:Kaivon/presentation/widgets/appBar.dart';
import 'package:flutter/material.dart';

class Explorer extends StatefulWidget {
  const Explorer({super.key});

  @override
  State<Explorer> createState() => _ExplorerState();
}

class _ExplorerState extends State<Explorer> {
  /// 🔥 SIMULATED BACKEND DATA (assets for now)
  final List<String> _allImages = [
    "assets/images/download (1).jpg",
    "assets/images/download (2).jpg",
    "assets/images/download (3).jpg",
    "assets/images/download (4).webp",
    "assets/images/images.jpg",
    "assets/images/images (1).jpg",
    "assets/images/images (2).jpg",
    "assets/images/images (3).jpg",
  ];

/// FOR API CALL TO FETCH IMAGES FROM BACKEND
  // Future<List<String>> fetchImagesFromAPI() async {
  //   final response = await http.get(...);
  //   return List<String>.from(jsonDecode(response.body));
  // }
  List<String> images = [];

  double _dragX = 0;
  double _dragY = 0;

  bool isFetching = false;

  @override
  void initState() {
    super.initState();
    _fetchMoreImages(); // ✅ initial load
  }

  /// 🔥 SIMULATED API CALL
  Future<void> _fetchMoreImages() async {
    if (isFetching) return;
    isFetching = true;

    await Future.delayed(const Duration(milliseconds: 500)); // simulate API

    List<String> newBatch = List.generate(
      15,
          (index) => _allImages[Random().nextInt(_allImages.length)],
    );

    setState(() {
      images.addAll(newBatch);
    });

    isFetching = false;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _dragX += details.delta.dx;
      _dragY += details.delta.dy;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (_dragX > 120) {
      _swipeCard(false);
    } else if (_dragX < -120) {
      _swipeCard(true);
    } else {
      setState(() {
        _dragX = 0;
        _dragY = 0;
      });
    }
  }

  void _swipeCard(bool isLike) {
    setState(() {
      images.removeAt(0);
      _dragX = 0;
      _dragY = 0;
    });

    /// 🔥 AUTO FETCH WHEN LOW
    if (images.length <= 4) {
      _fetchMoreImages();
    }

    debugPrint(isLike ? "LIKE ❤️" : "DISLIKE ❌");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: images.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Stack(
          alignment: Alignment.center,
          children: [
            /// BACK CARD
            if (images.length > 1)
              Positioned(
                child: _buildCard(images[1], scale: 0.95),
              ),

            /// FRONT CARD
            GestureDetector(
              onPanUpdate: _onPanUpdate,
              onPanEnd: _onPanEnd,
              child: Transform.translate(
                offset: Offset(_dragX, _dragY),
                child: Transform.rotate(
                  angle: _dragX * pi / 1800,
                  child: _buildCard(images[0]),
                ),
              ),
            ),

            /// ❤️ LIKE ICON
            Positioned(
              top: 80,
              left: 30,
              child: Opacity(
                opacity: _dragX < -40 ? 1 : 0,
                child: Transform.scale(
                  scale: min(_dragX.abs() / 100, 1.5),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 60,
                  ),
                ),
              ),
            ),

            /// ❌ DISLIKE ICON
            Positioned(
              top: 80,
              right: 30,
              child: Opacity(
                opacity: _dragX > 40 ? 1 : 0,
                child: Transform.scale(
                  scale: min(_dragX.abs() / 100, 1.5),
                  child: const Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 60,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔥 FULL SCREEN CARD
  Widget _buildCard(String imagePath, {double scale = 1}) {
    final size = MediaQuery.of(context).size;

    return Transform.scale(
      scale: scale,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Container(
            height: size.height * 0.7,
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 25,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}