import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/sheet_controller.dart';
import '../../theme/app_colors.dart';

class WardrobePage extends StatefulWidget {
  const WardrobePage({super.key});

  @override
  State<WardrobePage> createState() => _WardrobePageState();
}

class _WardrobePageState extends State<WardrobePage> {
  String _cat = 'all';
  final _cats = const [('all', 'All', 47), ('shirts', 'Shirts', 12), ('trousers', 'Trousers', 8), ('blazers', 'Blazers', 4)];

  @override
  Widget build(BuildContext context) {
    final pad = MediaQuery.paddingOf(context);
    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, pad.top + 16, 20, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('YOUR CLOSET', style: TextStyle(fontSize: 10, color: AppColors.muted, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                      const Text('Wardrobe', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.navy)),
                    ],
                  ),
                  Row(
                    children: [
                      _iconBtn(Icons.search),
                      const SizedBox(width: 8),
                      _iconBtn(Icons.sort),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: AppColors.navy, borderRadius: BorderRadius.circular(18), boxShadow: [BoxShadow(color: AppColors.navy.withValues(alpha: 0.18), blurRadius: 24)]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _statCol('47', 'PIECES'),
                        Container(width: 1, height: 34, color: const Color(0xFFB8BBD0).withValues(alpha: 0.25)),
                        _statCol('12', 'ACCESSORIES', gold: true),
                        const SizedBox(width: 16),
                        _statCol('3', 'UNWORN 30D'),
                      ],
                    ),
                    Divider(color: const Color(0xFFB8BBD0).withValues(alpha: 0.18)),
                    Text('Your charcoal blazer has not been worn in 32 days →', style: TextStyle(fontSize: 11, color: const Color(0xFFB8BBD0).withValues(alpha: 0.95))),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _cats.length,
                  separatorBuilder: (_, index) => const SizedBox(width: 7),
                  itemBuilder: (_, i) {
                    final e = _cats[i];
                    final on = e.$1 == _cat;
                    return FilterChip(
                      selected: on,
                      label: Text('${e.$2} ${e.$3}'),
                      onSelected: (_) => setState(() => _cat = e.$1),
                      selectedColor: AppColors.navy,
                      checkmarkColor: AppColors.gold,
                      labelStyle: TextStyle(color: on ? Colors.white : AppColors.navy, fontWeight: FontWeight.w600, fontSize: 11),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.82),
                itemCount: 6,
                itemBuilder: (_, i) => _pieceCard(['Charcoal Blazer', 'White Oxford', 'Navy Wool Pants', 'Black Oxfords', 'Burgundy Tie', 'Silver Automatic'][i]),
              ),
            ],
          ),
        ),
        Positioned(
          right: 20,
          bottom: 100,
          child: Material(
            shape: const CircleBorder(),
            elevation: 6,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () => context.read<SheetController>().openCaptureSheet(),
              child: Ink(
                width: 54,
                height: 54,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [Color(0xFFFFE8A0), AppColors.gold, AppColors.goldDark]),
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 26),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _iconBtn(IconData i) {
    return Container(
      width: 38,
      height: 38,
      alignment: Alignment.center,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withValues(alpha: 0.55), border: Border.all(color: Colors.white.withValues(alpha: 0.7))),
      child: Icon(i, size: 16, color: AppColors.navy),
    );
  }

  Widget _statCol(String v, String l, {bool gold = false}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(v, style: TextStyle(fontSize: gold ? 20 : 28, fontWeight: FontWeight.bold, color: gold ? AppColors.gold : Colors.white)),
          Text(l, style: TextStyle(fontSize: 9, color: const Color(0xFFB8BBD0).withValues(alpha: 0.95), fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _pieceCard(String name) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: AppColors.navy.withValues(alpha: 0.07), blurRadius: 12)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
                gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFFF5F5F7), Color(0xFFE8E9F2)]),
              ),
              child: Icon(Icons.checkroom, size: 48, color: AppColors.navy.withValues(alpha: 0.35)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.navy)),
          ),
        ],
      ),
    );
  }
}
