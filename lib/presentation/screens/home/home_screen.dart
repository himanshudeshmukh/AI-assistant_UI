library;

import 'package:flutter/material.dart';

import '../../../config/theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color _bg = Color(0xFFF7F6F3);
  static const Color _dark = Color(0xFF111111);
  static const Color _darkSurface = Color(0xFF1E1E1E);
  static const Color _gold = Color(0xFFC4A265);
  static const Color _goldLight = Color(0xFFD4B87A);

  final TextEditingController _searchController = TextEditingController();
  bool _searchFocused = false;
  String? _selectedCategoryId;
  final Set<int> _likedOutfits = <int>{};
  int _activeTab = 0;

  final List<_CategoryItem> _categories = const <_CategoryItem>[
    _CategoryItem(id: 'ai-stylist', label: 'AI Stylist', icon: Icons.auto_awesome),
    _CategoryItem(id: 'wardrobe', label: 'Wardrobe', icon: Icons.checkroom),
    _CategoryItem(id: 'style-guide', label: 'Style Guide', icon: Icons.menu_book),
    _CategoryItem(id: 'fitness', label: 'Fitness', icon: Icons.fitness_center),
    _CategoryItem(id: 'grooming', label: 'Grooming', icon: Icons.content_cut),
  ];

  final List<_OutfitItem> _outfits = const <_OutfitItem>[
    _OutfitItem(id: 1, name: 'Casual Friday', itemCount: 3, emoji: '☀️', tag: 'Everyday'),
    _OutfitItem(id: 2, name: 'Date Night', itemCount: 4, emoji: '🌙', tag: 'Special'),
    _OutfitItem(id: 3, name: 'Office Ready', itemCount: 5, emoji: '💼', tag: 'Work'),
    _OutfitItem(id: 4, name: 'Weekend Brunch', itemCount: 3, emoji: '🥂', tag: 'Leisure'),
    _OutfitItem(id: 5, name: 'Gym Session', itemCount: 2, emoji: '🏋️', tag: 'Active'),
  ];

  final List<_TrendingItem> _trending = const <_TrendingItem>[
    _TrendingItem(
      category: 'Style',
      title: 'Minimalist Summer',
      description: '12 curated looks',
      icon: Icons.trending_up,
    ),
    _TrendingItem(
      category: 'Grooming',
      title: 'Skin Routine',
      description: '8 daily steps',
      icon: Icons.local_fire_department,
    ),
  ];

  final List<_TipItem> _quickTips = const <_TipItem>[
    _TipItem(title: 'Color matching made simple', time: '3 min read', icon: Icons.star),
    _TipItem(title: '5 wardrobe essentials for men', time: '5 min read', icon: Icons.bolt),
    _TipItem(title: 'Grooming routine for beginners', time: '4 min read', icon: Icons.favorite),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _buildHeader(),
                    _buildCategories(),
                    _buildFeaturedBanner(),
                    _buildOutfitPlanner(),
                    _buildTrending(),
                    _buildQuickTips(),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        color: _dark,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.auto_awesome, size: 14, color: _gold),
                        SizedBox(width: 6),
                        Text(
                          'AI-POWERED STYLE',
                          style: TextStyle(
                            color: _gold,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Good Morning,',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Himanshu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Stack(
                  children: const <Widget>[
                    Icon(Icons.notifications_none, color: Color(0xFFCCCCCC)),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: CircleAvatar(radius: 4, backgroundColor: _gold),
                    ),
                  ],
                ),
              ),
              const CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xFF2A2A2A),
                child: Text(
                  'H',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Focus(
            onFocusChange: (bool value) {
              setState(() {
                _searchFocused = value;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              decoration: BoxDecoration(
                color: _searchFocused ? const Color(0xFF2A2A2A) : _darkSurface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: _searchFocused ? _gold.withOpacity(0.4) : Colors.transparent,
                ),
              ),
              child: Row(
                children: <Widget>[
                  Icon(Icons.search, color: _searchFocused ? _gold : const Color(0xFF666666)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      decoration: const InputDecoration(
                        hintText: 'Search styles, outfits, tips...',
                        hintStyle: TextStyle(color: Color(0xFF666666)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        children: _categories.map((final _CategoryItem item) {
          final bool isSelected = _selectedCategoryId == item.id;
          return Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedCategoryId = isSelected ? null : item.id;
                });
              },
              child: Column(
                children: <Widget>[
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: isSelected ? _gold : _dark,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      item.icon,
                      color: isSelected ? _dark : _gold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      color: isSelected ? _dark : const Color(0xFF888888),
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFeaturedBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _dark,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Row(
              children: <Widget>[
                Icon(Icons.auto_awesome, size: 12, color: _gold),
                SizedBox(width: 6),
                Text(
                  "TODAY'S PICK",
                  style: TextStyle(
                    color: _gold,
                    fontSize: 10,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Your Style Score',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "AI analyzed your wardrobe - see what's trending",
              style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 13),
            ),
            const SizedBox(height: 14),
            ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: _gold,
                foregroundColor: _dark,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              icon: const Text(
                'View Analysis',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
              label: const Icon(Icons.arrow_forward, size: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOutfitPlanner() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[
          _sectionHeader(title: 'Outfit Planner', actionText: 'See all'),
          const SizedBox(height: 8),
          SizedBox(
            height: 165,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemBuilder: (BuildContext context, int index) {
                final _OutfitItem outfit = _outfits[index];
                final bool liked = _likedOutfits.contains(outfit.id);
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
                    children: <Widget>[
                      Container(
                        height: 86,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0EDE8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Text(outfit.emoji, style: const TextStyle(fontSize: 30)),
                            ),
                            Positioned(
                              top: 6,
                              left: 6,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _dark.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  outfit.tag,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 6,
                              right: 6,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    if (liked) {
                                      _likedOutfits.remove(outfit.id);
                                    } else {
                                      _likedOutfits.add(outfit.id);
                                    }
                                  });
                                },
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
                      Text(
                        outfit.name,
                        style: const TextStyle(
                          color: _dark,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${outfit.itemCount} items',
                        style: const TextStyle(color: Color(0xFF888888), fontSize: 11),
                      ),
                    ],
                  ),
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

  Widget _buildTrending() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Column(
        children: <Widget>[
          _sectionHeader(title: 'Trending This Week', actionText: 'Explore'),
          const SizedBox(height: 10),
          Row(
            children: _trending.map((final _TrendingItem item) {
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: item == _trending.first ? 8 : 0),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: _dark,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: _gold.withOpacity(0.16),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(item.icon, color: _gold, size: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        item.category.toUpperCase(),
                        style: const TextStyle(
                          color: _gold,
                          fontSize: 10,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.description,
                        style: const TextStyle(color: Color(0xFFAAAAAA), fontSize: 11),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickTips() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 6),
      child: Column(
        children: <Widget>[
          _sectionHeader(title: 'Quick Style Tips', actionText: 'More'),
          const SizedBox(height: 8),
          SizedBox(
            height: 108,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemBuilder: (BuildContext context, int index) {
                final _TipItem tip = _quickTips[index];
                return Container(
                  width: 220,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFE8E5E0)),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: _bg,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(tip.icon, color: _gold, size: 18),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              tip.title,
                              style: const TextStyle(
                                color: _dark,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: <Widget>[
                                const Icon(Icons.schedule, size: 11, color: Color(0xFFAAAAAA)),
                                const SizedBox(width: 4),
                                Text(
                                  tip.time,
                                  style: const TextStyle(
                                    color: Color(0xFFAAAAAA),
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemCount: _quickTips.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    const List<_TabItem> tabs = <_TabItem>[
      _TabItem(label: 'Home', icon: Icons.home_outlined, activeIcon: Icons.home),
      _TabItem(label: 'Wardrobe', icon: Icons.checkroom_outlined, activeIcon: Icons.checkroom),
      _TabItem(label: 'AI Style', icon: Icons.auto_awesome_outlined, activeIcon: Icons.auto_awesome),
      _TabItem(label: 'Insights', icon: Icons.bar_chart_outlined, activeIcon: Icons.bar_chart),
      _TabItem(label: 'Profile', icon: Icons.person_outline, activeIcon: Icons.person),
    ];

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        left: 8,
        right: 8,
        top: 8,
        bottom: MediaQuery.of(context).padding.bottom > 0 ? 8 : 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List<Widget>.generate(tabs.length, (int index) {
          final bool isActive = _activeTab == index;
          final bool isCenter = index == 2;
          final _TabItem tab = tabs[index];
          return InkWell(
            onTap: () {
              setState(() {
                _activeTab = index;
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: isCenter ? 50 : 28,
                  height: isCenter ? 50 : 28,
                  decoration: isCenter
                      ? BoxDecoration(
                          color: _dark,
                          shape: BoxShape.circle,
                          border: Border.all(color: _gold, width: 3),
                        )
                      : null,
                  child: Icon(
                    isActive ? tab.activeIcon : tab.icon,
                    color: isCenter
                        ? (isActive ? _gold : Colors.white)
                        : (isActive ? _dark : const Color(0xFFCCCCCC)),
                    size: isCenter ? 22 : 22,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  tab.label,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                    color: isCenter
                        ? (isActive ? _gold : const Color(0xFFAAAAAA))
                        : (isActive ? _dark : const Color(0xFFAAAAAA)),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _sectionHeader({required String title, required String actionText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              color: _dark,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: _gold,
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Row(
              children: <Widget>[
                Text(
                  actionText,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 2),
                const Icon(Icons.chevron_right, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryItem {
  const _CategoryItem({required this.id, required this.label, required this.icon});

  final String id;
  final String label;
  final IconData icon;
}

class _OutfitItem {
  const _OutfitItem({
    required this.id,
    required this.name,
    required this.itemCount,
    required this.emoji,
    required this.tag,
  });

  final int id;
  final String name;
  final int itemCount;
  final String emoji;
  final String tag;
}

class _TrendingItem {
  const _TrendingItem({
    required this.category,
    required this.title,
    required this.description,
    required this.icon,
  });

  final String category;
  final String title;
  final String description;
  final IconData icon;
}

class _TipItem {
  const _TipItem({required this.title, required this.time, required this.icon});

  final String title;
  final String time;
  final IconData icon;
}

class _TabItem {
  const _TabItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
}