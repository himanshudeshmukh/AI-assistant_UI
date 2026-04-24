import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import 'style_studio_widgets.dart';

class StyleStudioPage extends StatefulWidget {
  const StyleStudioPage({super.key});

  @override
  State<StyleStudioPage> createState() => _StyleStudioPageState();
}

class _StyleStudioPageState extends State<StyleStudioPage> {
  String _tab = 'occasion';
  String _activeOccasion = 'date';

  final List<Map<String, dynamic>> occasions = [
    {'id': 'date', 'label': 'Date'},
    {'id': 'party', 'label': 'Party'},
    {'id': 'meeting', 'label': 'Meeting'},
    {'id': 'wedding', 'label': 'Wedding'},
    {'id': 'dinner', 'label': 'Dinner'},
    {'id': 'vacation', 'label': 'Vacation'},
    {'id': 'office', 'label': 'Office'},
    {'id': 'custom', 'label': 'Custom', 'custom': true},
  ];

  @override
  Widget build(BuildContext context) {
    final pad = MediaQuery.paddingOf(context);
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20, pad.top + 14, 20, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CREATE YOUR LOOK',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.muted,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.12,
                    ),
                  ),
                  const Text(
                    'Style Studio',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.navy,
                      height: 1,
                      letterSpacing: -0.03,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.55),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: Colors.white.withOpacity(0.7)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.auto_awesome, size: 11, color: AppColors.gold),
                    SizedBox(width: 6),
                    Text(
                      'AI READY',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: AppColors.navy,
                        letterSpacing: 0.04,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Tab toggle
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.55),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: Colors.white.withOpacity(0.7)),
            ),
            padding: const EdgeInsets.all(3),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _tab = 'occasion'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: _tab == 'occasion'
                            ? AppColors.navy
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite,
                            size: 11,
                            color: _tab == 'occasion'
                                ? AppColors.gold
                                : AppColors.muted,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Occasion',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: _tab == 'occasion'
                                  ? Colors.white
                                  : AppColors.muted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _tab = 'trip'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: _tab == 'trip'
                            ? AppColors.navy
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 11,
                            color: _tab == 'trip'
                                ? AppColors.gold
                                : AppColors.muted,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Trip',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: _tab == 'trip'
                                  ? Colors.white
                                  : AppColors.muted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Recent Creations
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    'RECENT CREATIONS',
                    style: TextStyle(
                      fontSize: 9,
                      color: AppColors.muted,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.14,
                    ),
                  ),
                  const Text(
                    'See all →',
                    style: TextStyle(
                      fontSize: 9,
                      color: AppColors.navy,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              SizedBox(
                height: 90,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    RecentCard(
                      label: 'Sangeet',
                      ago: '2d ago',
                      kind: 'blazer',
                      dot: true,
                    ),
                    const SizedBox(width: 7),
                    RecentCard(label: 'Brunch', ago: '5d ago', kind: 'suit'),
                    const SizedBox(width: 7),
                    RecentCard(
                      label: 'Office Fri',
                      ago: '1w ago',
                      kind: 'trousers',
                    ),
                    const SizedBox(width: 7),
                    Container(
                      width: 86,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.navy.withOpacity(0.2),
                        ),
                        color: Colors.white.withOpacity(0.4),
                      ),
                      child: const Center(
                        child: Text(
                          '+',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.slate,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Occasion grid 4x2
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
              childAspectRatio: 0.9,
            ),
            itemCount: occasions.length,
            itemBuilder: (context, index) {
              final occasion = occasions[index];
              final isActive = occasion['id'] == _activeOccasion;
              final isCustom = occasion['custom'] ?? false;

              return GestureDetector(
                onTap: () => setState(() => _activeOccasion = occasion['id']),
                child: Container(
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.navy
                        : isCustom
                        ? Colors.white.withOpacity(0.4)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(11),
                    border: isActive
                        ? Border.all(color: AppColors.gold, width: 1.5)
                        : isCustom
                        ? Border.all(
                            color: AppColors.navy.withOpacity(0.3),
                            width: 1.5,
                          )
                        : null,
                    boxShadow: [
                      if (isActive)
                        BoxShadow(
                          color: AppColors.navy.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        )
                      else if (!isCustom)
                        BoxShadow(
                          color: AppColors.navy.withOpacity(0.06),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OccasionIcon(id: occasion['id'], active: isActive),
                      const SizedBox(height: 3),
                      Text(
                        occasion['label'],
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isActive ? Colors.white : AppColors.navy,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),

          // Composed For card
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: AppColors.navy.withOpacity(0.1),
                  blurRadius: 28,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'COMPOSED FOR',
                          style: TextStyle(
                            fontSize: 9,
                            color: AppColors.slate,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.12,
                          ),
                        ),
                        const SizedBox(height: 1),
                        const Text(
                          'Date Night · Indore',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.navy,
                            letterSpacing: -0.02,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFFFFF0C0), AppColors.gold],
                            ),
                            borderRadius: BorderRadius.circular(999),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.gold.withOpacity(0.35),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 9,
                                color: AppColors.warmLabel,
                              ),
                              SizedBox(width: 3),
                              Text(
                                'AI CURATED',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: AppColors.warmLabel,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.06,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F5F0),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF2F7A4D).withOpacity(0.25),
                            ),
                          ),
                          child: const Icon(
                            Icons.thumb_up,
                            size: 11,
                            color: Color(0xFF2F7A4D),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F7),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.slate.withOpacity(0.25),
                            ),
                          ),
                          child: const Icon(
                            Icons.thumb_down,
                            size: 11,
                            color: AppColors.slate,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Look preview
                Container(
                  height: 122,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(0.77, -0.64),
                      end: Alignment(-0.77, 0.64),
                      colors: [
                        Color(0xFFF0F1F7),
                        Color(0xFFD4D5DE),
                        Color(0xFFB8BBD0),
                      ],
                      stops: [0.0, 0.55, 1.0],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: AppColors.navy.withOpacity(0.25),
                                width: 1.5,
                              ),
                              top: BorderSide(
                                color: AppColors.navy.withOpacity(0.25),
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: AppColors.navy.withOpacity(0.25),
                                width: 1.5,
                              ),
                              top: BorderSide(
                                color: AppColors.navy.withOpacity(0.25),
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        left: 8,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: AppColors.navy.withOpacity(0.25),
                                width: 1.5,
                              ),
                              bottom: BorderSide(
                                color: AppColors.navy.withOpacity(0.25),
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: AppColors.navy.withOpacity(0.25),
                                width: 1.5,
                              ),
                              bottom: BorderSide(
                                color: AppColors.navy.withOpacity(0.25),
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                Colors.white.withOpacity(0.55),
                                Colors.transparent,
                              ],
                              stops: const [0.0, 0.65],
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: AppColors.navy.withOpacity(0.08),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.navy.withOpacity(0.25),
                                ),
                              ),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 16,
                                color: AppColors.navy.withOpacity(0.6),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'LOOK PREVIEW',
                              style: TextStyle(
                                fontSize: 9,
                                color: AppColors.navy,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.navy.withOpacity(0.78),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: const Text(
                            'Composed',
                            style: TextStyle(
                              fontSize: 8,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.06,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Piece thumbs row
                const Row(
                  children: [
                    PieceThumb(label: 'TURTLE', kind: 'turtle'),
                    SizedBox(width: 5),
                    PieceThumb(label: 'BLAZER', kind: 'blazer'),
                    SizedBox(width: 5),
                    PieceThumb(label: 'TROUSERS', kind: 'trousers'),
                    SizedBox(width: 5),
                    PieceThumb(
                      label: 'OXFORDS',
                      kind: 'missing',
                      missing: true,
                    ),
                    SizedBox(width: 5),
                    PieceThumb(label: 'WATCH', kind: 'watch'),
                  ],
                ),
                const SizedBox(height: 10),

                // Why this works
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F7),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.lightbulb_outline,
                        size: 11,
                        color: AppColors.navy,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 9,
                              color: AppColors.muted,
                              height: 1.35,
                            ),
                            children: const [
                              TextSpan(
                                text: 'Why this works: ',
                                style: TextStyle(
                                  color: AppColors.navy,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Turtleneck under blazer for cooler evening · Romantic yet polished',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Actions - FIXED: Removed weight property
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F7),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shuffle,
                              size: 11,
                              color: AppColors.navy,
                            ), // ✅ weight hata diya
                            const SizedBox(width: 4),
                            Text(
                              'Shuffle',
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColors.navy,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F7),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.bookmark_border,
                              size: 11,
                              color: AppColors.navy,
                            ), // ✅ weight hata diya
                            const SizedBox(width: 4),
                            Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColors.navy,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      flex: 13,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.navy,
                          borderRadius: BorderRadius.circular(9),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.navy.withOpacity(0.25),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check, size: 11, color: AppColors.gold),
                            const SizedBox(width: 4),
                            Text(
                              'Wear Today',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Missing piece warning - FIXED: Removed weight property
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFFF9ED), Color(0xFFFFEFC8)],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.gold.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: AppColors.gold.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Icon(
                        Icons.warning_amber_rounded,
                        size: 13,
                        color: AppColors.warmLabel,
                      ), // ✅ weight hata diya
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '1 piece short · Brown Oxfords',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.warmLabel,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                            color: AppColors.gold.withOpacity(0.4),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'See 3 wardrobe alternates',
                            style: TextStyle(
                              fontSize: 9,
                              color: AppColors.navy,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.navy,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Center(
                        child: Text(
                          'Shop',
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
  }
}
