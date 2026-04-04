import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/utils/responsive.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  static const List<_NavItemData> _items = <_NavItemData>[
    _NavItemData(
        label: 'Home', icon: Icons.home_outlined, activeIcon: Icons.home),
    _NavItemData(
      label: 'Wardrobe',
      icon: Icons.checkroom_outlined,
      activeIcon: Icons.checkroom,
    ),
    _NavItemData(
      label: 'Style',
      icon: Icons.auto_awesome_outlined,
      activeIcon: Icons.auto_awesome,
    ),
    _NavItemData(
      label: 'Profile',
      icon: Icons.person_outline,
      activeIcon: Icons.person,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final navHeight = Responsive.navHeight(width);
    return SafeArea(
      top: false,
      child: Container(
        height: navHeight,
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
        decoration: BoxDecoration(
          color: AppColors.authHeroAccent,
          border: const Border(
            top: BorderSide(color: AppColors.authHeroAccent),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: List<Widget>.generate(_items.length, (index) {
            final item = _items[index];
            final isActive = index == currentIndex;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => onTap(index),
                    borderRadius: BorderRadius.circular(10),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 4),
                      decoration: BoxDecoration(
                        color: isActive
                            ? AppColors.authHeroAccent
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            isActive ? item.activeIcon : item.icon,
                            size: 18,
                            color: isActive
                                ? AppColors.authHeroAccent
                                : AppColors.authHeroAccent,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.label.toUpperCase(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: isActive
                                      ? AppColors.authHeroAccent
                                      : AppColors.authHeroAccent,
                                  fontWeight: isActive
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  letterSpacing: 0.8,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavItemData {
  const _NavItemData({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
}
