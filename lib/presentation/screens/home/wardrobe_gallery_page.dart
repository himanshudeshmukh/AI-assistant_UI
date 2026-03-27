import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../config/utils/responsive.dart';

class WardrobeGalleryPage extends StatefulWidget {
  const WardrobeGalleryPage({super.key});

  @override
  State<WardrobeGalleryPage> createState() =>
      _WardrobeGalleryPageState();
}

class _WardrobeGalleryPageState extends State<WardrobeGalleryPage> {

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  /// 🔥 DUMMY DATA
  final List<Map<String, Image>> items = [
    {
      "image":
      Image.asset("assets/clothes/blazer.jpg"),
    },
    {
      "image":
      Image.asset("assets/clothes/green shirt.jpg"),
    },
    {
      "image":
      Image.asset("assets/clothes/red shirt.jpg"),
    },
    {
      "image":
      Image.asset("assets/clothes/images.jpg"),
    },
  ];

  /// 🔥 IMAGE PICK
  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  /// 🔥 PICKER UI
  void _showPicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [

              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text("Camera"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),

              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final contentWidth = Responsive.maxContentWidth(screenWidth);

    return Scaffold(

      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.pagePadding(contentWidth),
        ),

        child: Column(
          children: [

            /// 🔥 SELECTED IMAGE PREVIEW
            if (_selectedImage != null)
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    _selectedImage!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

            /// 🔥 GRID
            Expanded(
              child: GridView.builder(
                itemCount: items.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,

                  crossAxisSpacing:
                  Responsive.itemGap(contentWidth),

                  mainAxisSpacing:
                  Responsive.itemGap(contentWidth),

                  childAspectRatio:
                  Responsive.productAspectRatio(contentWidth),
                ),

                itemBuilder: (context, index) {
                  final item = items[index];

                  return _WardrobeCard(
                    image: item["image"]!,
                  );
                },
              ),
            ),
          ],
        ),
      ),

      /// 🔥 FLOATING BUTTON
      floatingActionButton: FloatingActionButton(
        onPressed: _showPicker,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _WardrobeCard extends StatelessWidget {
  final Image image;

  const _WardrobeCard({
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        /// 🔥 NO HARD BACKGROUND → keeps PNG transparent
        color: Colors.transparent,

        borderRadius: BorderRadius.circular(16),

        /// 🔥 SOFT BORDER
        border: Border.all(
          color: Colors.grey.shade200,
        ),

        /// 🔥 PREMIUM SHADOW
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          color: Colors.white, // subtle card base (optional)
          child: SizedBox.expand(
        child: FittedBox(
        fit: BoxFit.cover,
          child: image,
        ),
      ),
        ),
      ),
    );
  }
}