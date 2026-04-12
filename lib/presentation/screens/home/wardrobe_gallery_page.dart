import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'package:Kaivon/config/utils/responsive.dart';

import '../../../config/theme/app_colors.dart';

/// ================= MODEL =================
class WardrobeItem {
  final String imageUrl;
  final bool isAsset;
  final List<String> tags;

  WardrobeItem({
    required this.imageUrl,
    required this.isAsset,
    required this.tags,
  });

  factory WardrobeItem.fromJson(Map<String, dynamic> json) {
    return WardrobeItem(
      imageUrl: json["imageUrl"],
      isAsset: false,
      tags: List<String>.from(json["tags"] ?? []),
    );
  }
}

/// ================= PAGE =================
class WardrobeGalleryPage extends StatefulWidget {
  const WardrobeGalleryPage({super.key});

  @override
  State<WardrobeGalleryPage> createState() => _WardrobeGalleryPageState();
}

class _WardrobeGalleryPageState extends State<WardrobeGalleryPage> {


  bool isLoading = false;

  final List<String> filters = [
    "All",
    "Topwear",
    "Bottomwear",
    "Formal",
    "Casual",
    "Party",
  ];

  String selectedFilter = "All";

  List<WardrobeItem> items = [];

  @override
  void initState() {
    super.initState();
    loadStaticItems();
  }

  void loadStaticItems() {
    items = [
      WardrobeItem(
        imageUrl: "assets/clothes/blazer.jpg",
        isAsset: true,
        tags: ["topwear", "formal"],
      ),
      WardrobeItem(
        imageUrl: "assets/clothes/green shirt.jpg",
        isAsset: true,
        tags: ["topwear", "casual"],
      ),
      WardrobeItem(
        imageUrl: "assets/clothes/red shirt.jpg",
        isAsset: true,
        tags: ["topwear", "party"],
      ),
      WardrobeItem(
        imageUrl: "assets/clothes/images.jpg",
        isAsset: true,
        tags: ["bottomwear", "casual"],
      ),
    ];
  }

  List<WardrobeItem> get filteredItems {
    if (selectedFilter == "All") return items;

    return items.where((item) {
      return item.tags
          .map((e) => e.toLowerCase())
          .contains(selectedFilter.toLowerCase());
    }).toList();
  }




  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final contentWidth = Responsive.maxContentWidth(screenWidth);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),

      appBar: AppBar(
        elevation: 0,
        title: const Text("Wardrobe", style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.pagePadding(contentWidth),
        ),
        child: Column(
          children: [
            const SizedBox(height: 15),
            /// ================= CHIPS (SEPARATE WIDGET) =================
            WardrobeFilterChips(
              filters: filters,
              selected: selectedFilter,
              onChanged: (value) {
                setState(() => selectedFilter = value);
              },
            ),

            const SizedBox(height: 15),

            /// ================= GRID =================
            Expanded(
              child: GridView.builder(
                itemCount: filteredItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  return _WardrobeCard(item: filteredItems[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class WardrobeFilterChips extends StatelessWidget {
  final List<String> filters;
  final String selected;
  final Function(String) onChanged;

  const WardrobeFilterChips({
    super.key,
    required this.filters,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = filter == selected;

          return GestureDetector(
            onTap: () => onChanged(filter),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFEAF2FF)
                    : Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF8AB4FF)
                      : Colors.grey.shade300,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                filter,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? const Color(0xFF4A6CF7)
                      : Colors.grey.shade600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


class _WardrobeCard extends StatelessWidget {
  final WardrobeItem item;

  const _WardrobeCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: item.isAsset
            ? Image.asset(item.imageUrl, fit: BoxFit.cover)
            : Image.network(item.imageUrl, fit: BoxFit.cover),
      ),
    );
  }
}