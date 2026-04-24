import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_routes.dart';
import '../../theme/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final pad = MediaQuery.paddingOf(context);
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20, pad.top + 12, 20, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => context.go(AppRoutes.home),
                style: IconButton.styleFrom(backgroundColor: Colors.white),
                icon: const Icon(Icons.arrow_back, color: AppColors.navy),
              ),
              const Text('PROFILE', style: TextStyle(fontSize: 10, letterSpacing: 3.2, fontWeight: FontWeight.bold, color: AppColors.navy)),
              const SizedBox(width: 40),
            ],
          ),
          const SizedBox(height: 20),
          const CircleAvatar(radius: 48, backgroundColor: Color(0xFFDCE8E4), child: Icon(Icons.person, size: 56, color: AppColors.slate)),
          const SizedBox(height: 12),
          const Text('Himanshu Deshmukh', textAlign: TextAlign.center, style: TextStyle(fontSize: 22, color: AppColors.navy)),
          Text('Member · No. 0142 · MMXXV', textAlign: TextAlign.center, style: TextStyle(fontSize: 10.5, color: AppColors.warmLabel.withValues(alpha: 0.9), fontStyle: FontStyle.italic)),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.gold.withValues(alpha: 0.25))),
            child: Row(
              children: [
                const Expanded(child: _StatCell('LEVEL', 'Debut')),
                Container(width: 1, height: 40, color: AppColors.navy.withValues(alpha: 0.1)),
                const Expanded(child: _StatCell('POINTS', '1,240', gold: true)),
                Container(width: 1, height: 40, color: AppColors.navy.withValues(alpha: 0.1)),
                const Expanded(child: _StatCell('PIECES', '24')),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('ACCOUNT', style: TextStyle(fontSize: 9, letterSpacing: 2.4, fontWeight: FontWeight.bold, color: AppColors.warmLabel)),
          Card(
            child: Column(
              children: [
                ListTile(title: const Text('Edit Profile'), trailing: const Icon(Icons.chevron_right), onTap: () {}),
                const Divider(height: 1),
                ListTile(title: const Text('My Points'), trailing: const Icon(Icons.chevron_right), onTap: () {}),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Text('PREFERENCES', style: TextStyle(fontSize: 9, letterSpacing: 2.4, fontWeight: FontWeight.bold, color: AppColors.warmLabel)),
          Card(
            child: Column(
              children: [
                ListTile(title: const Text('Notifications'), trailing: const Icon(Icons.chevron_right), onTap: () {}),
                const Divider(height: 1),
                ListTile(title: const Text('Help & Support'), trailing: const Icon(Icons.chevron_right), onTap: () {}),
                const Divider(height: 1),
                ListTile(title: const Text('About'), trailing: const Icon(Icons.chevron_right), onTap: () {}),
              ],
            ),
          ),
          TextButton(onPressed: () => context.go(AppRoutes.welcome), child: const Text('SIGN OUT')),
        ],
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell(this.label, this.value, {this.gold = false});
  final String label;
  final String value;
  final bool gold;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 9, color: AppColors.slate.withValues(alpha: 0.8), fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: gold ? AppColors.goldDark : AppColors.navy)),
      ],
    );
  }
}
