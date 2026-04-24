import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_routes.dart';
import '../../theme/app_colors.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pad = MediaQuery.paddingOf(context);
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20, pad.top + 18, 20, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Good Morning', style: TextStyle(fontSize: 12, color: AppColors.muted)),
                  const Text('Himanshu', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.navy)),
                ],
              ),
              Row(
                children: [
                  _roundIcon(Icons.notifications_none_rounded),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () => context.go(AppRoutes.profile),
                    customBorder: const CircleBorder(),
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(colors: [AppColors.goldDark, AppColors.gold]),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.7), width: 2),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          _weatherCard(),
          const SizedBox(height: 12),
          _outfitCard(),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.45,
            children: [
              _stat('Outfits Created', '42', '↑ 6 wk', const Color(0xFF2F7A4D)),
              _streak(),
              _stat('Saved Looks', '17', '4 moods', AppColors.slate),
              _stat('Wardrobe', '47', '+12 acc.', AppColors.slate),
            ],
          ),
          const SizedBox(height: 12),
          _tier(),
        ],
      ),
    );
  }

  Widget _roundIcon(IconData i) {
    return Container(
      width: 38,
      height: 38,
      alignment: Alignment.center,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withValues(alpha: 0.55), border: Border.all(color: Colors.white.withValues(alpha: 0.6))),
      child: Icon(i, size: 18, color: AppColors.navy),
    );
  }

  Widget _weatherCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: AppColors.navy, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: AppColors.navy.withValues(alpha: 0.18), blurRadius: 24, offset: const Offset(0, 8))]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: const Color(0xFFB8BBD0).withValues(alpha: 0.12)),
                    child: const Icon(Icons.nights_stay_outlined, color: AppColors.gold, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          children: [
                            const TextSpan(text: '29.5° ', style: TextStyle(fontSize: 20)),
                            TextSpan(text: 'Night', style: TextStyle(fontSize: 12, color: Color(0xFFB8BBD0), fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                      Text('Warm Night · Clear', style: TextStyle(fontSize: 11, color: const Color(0xFFB8BBD0).withValues(alpha: 0.95))),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('21:45', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text('GMT +5:30', style: TextStyle(fontSize: 10, color: const Color(0xFFB8BBD0).withValues(alpha: 0.95))),
                ],
              ),
            ],
          ),
          Divider(color: const Color(0xFFB8BBD0).withValues(alpha: 0.18)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [const Icon(Icons.location_on, size: 10, color: AppColors.gold), Text(' Indore, MP', style: TextStyle(fontSize: 11, color: const Color(0xFFB8BBD0).withValues(alpha: 0.95)))]),
              const Text('SUGGESTED →', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.gold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _outfitCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: AppColors.navy.withValues(alpha: 0.08), blurRadius: 24)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("TODAY'S OUTFIT", style: TextStyle(fontSize: 10, color: AppColors.slate, letterSpacing: 1, fontWeight: FontWeight.bold)),
                  const Text('The Midnight Formal', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.navy)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(999), gradient: const LinearGradient(colors: [Color(0xFFFFF0C0), AppColors.gold])),
                child: const Text('+25 XP', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.warmLabel)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 160,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), gradient: const LinearGradient(colors: [Color(0xFFEEEEF3), Color(0xFFD4D5DE)])),
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.navy.withValues(alpha: 0.75), borderRadius: BorderRadius.circular(999)),
                  child: const Text('WEATHER-MATCHED', style: TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            children: ['Blazer', 'Shirt', 'Trousers', 'Oxfords', 'Tie']
                .map(
                  (t) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: const Color(0xFFF5F5F7), borderRadius: BorderRadius.circular(999)),
                    child: Text(t, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.navy)),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _stat(String l, String v, String m, Color mc) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: AppColors.navy.withValues(alpha: 0.06), blurRadius: 12)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l.toUpperCase(), style: const TextStyle(fontSize: 9, color: AppColors.slate, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(v, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.navy)),
              const SizedBox(width: 6),
              Text(m, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: mc)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _streak() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColors.navy, borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.gold, width: 2)),
            child: const Text('12', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('STREAK', style: TextStyle(fontSize: 9, color: AppColors.gold, fontWeight: FontWeight.bold)),
                Text('day run', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tier() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          const ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(backgroundColor: AppColors.navy, child: Icon(Icons.diamond, color: AppColors.gold, size: 18)),
            title: Text('Connoisseur', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
            trailing: Text('340/500', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: 0.68,
              minHeight: 5,
              backgroundColor: const Color(0xFFEEEEF3),
              color: AppColors.gold.withValues(alpha: 1),
            ),
          ),
        ],
      ),
    );
  }
}
