// lib/screens/home/widgets/outfit_planner_section.dart
import 'package:flutter/material.dart';

class OutfitPlannerSection extends StatefulWidget {
  const OutfitPlannerSection({super.key});

  @override
  State<OutfitPlannerSection> createState() => _OutfitPlannerSectionState();
}

class _OutfitPlannerSectionState extends State<OutfitPlannerSection> {
  final Set<int> _likedOutfits = <int>{};
  final List<_OutfitItem> _outfits = const [
    _OutfitItem(
        id: 1,
        name: 'Casual Friday',
        itemCount: 3,
        emoji: '☀️',
        tag: 'Everyday'),
    _OutfitItem(
        id: 2, name: 'Date Night', itemCount: 4, emoji: '🌙', tag: 'Special'),
    _OutfitItem(
        id: 3, name: 'Office Ready', itemCount: 5, emoji: '💼', tag: 'Work'),
    _OutfitItem(
        id: 4,
        name: 'Weekend Brunch',
        itemCount: 3,
        emoji: '🥂',
        tag: 'Leisure'),
    _OutfitItem(
        id: 5, name: 'Gym Session', itemCount: 2, emoji: '🏋️', tag: 'Active'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          _sectionHeader(title: 'Outfit Suggestions'),
          const SizedBox(height: 8),
          SizedBox(
            height: 165,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemBuilder: (context, index) {
                final outfit = _outfits[index];
                final liked = _likedOutfits.contains(outfit.id);
                return _OutfitCard(
                  outfit: outfit,
                  liked: liked,
                  onLikeToggle: () {
                    setState(() {
                      if (liked) {
                        _likedOutfits.remove(outfit.id);
                      } else {
                        _likedOutfits.add(outfit.id);
                      }
                    });
                  },
                );
              },
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemCount: _outfits.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader({required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),

        ],
      ),
    );
  }
}

class _OutfitCard extends StatelessWidget {
  final _OutfitItem outfit;
  final bool liked;
  final VoidCallback onLikeToggle;

  const _OutfitCard(
      {required this.outfit, required this.liked, required this.onLikeToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 145,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8E5E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 86,
            decoration: BoxDecoration(
              color: const Color(0xFFF0EDE8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                Center(
                    child: Text(outfit.emoji,
                        style: const TextStyle(fontSize: 30))),
                Positioned(
                  top: 6,
                  left: 6,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(outfit.tag,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 9)),
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: InkWell(
                    onTap: onLikeToggle,
                    child: Icon(
                      liked ? Icons.favorite : Icons.favorite_border,
                      size: 16,
                      color: liked ? Colors.red : const Color(0xFFCCCCCC),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(outfit.name,
              style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          const SizedBox(height: 2),
          Text('${outfit.itemCount} items',
              style: const TextStyle(color: Color(0xFF888888), fontSize: 11)),
        ],
      ),
    );
  }
}

class _OutfitItem {
  final int id;
  final String name;
  final int itemCount;
  final String emoji;
  final String tag;

  const _OutfitItem(
      {required this.id,
      required this.name,
      required this.itemCount,
      required this.emoji,
      required this.tag});
}
