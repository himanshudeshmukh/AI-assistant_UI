/// Profile Menu Item Component
///
/// A reusable menu item for profile page navigation.
/// Features:
/// - Icon on the left
/// - Title text
/// - Arrow indicator on the right
/// - Tap feedback
/// - Fully responsive
///
/// Usage:
/// ```dart
/// ProfileMenuItem(
///   icon: Icons.group,
///   title: 'Friends',
///   onTap: () => Navigator.push(...),
/// )
/// ```

import 'package:flutter/material.dart';

class ProfileMenuItem extends StatefulWidget {
  /// Creates a profile menu item.
  ///
  /// Parameters:
  /// - [icon]: Icon to display on the left
  /// - [title]: Title text to display
  /// - [onTap]: Callback when menu item is tapped
  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  /// Icon to display
  final IconData icon;

  /// Title text
  final String title;

  /// Callback when tapped
  final VoidCallback onTap;

  @override
  State<ProfileMenuItem> createState() => _ProfileMenuItemState();
}

class _ProfileMenuItemState extends State<ProfileMenuItem> {
  /// Track if item is being pressed
  late bool _isPressed;

  @override
  void initState() {
    super.initState();
    _isPressed = false;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTapDown: (_) {
            setState(() => _isPressed = true);
          },
          onTapUp: (_) {
            setState(() => _isPressed = false);
            widget.onTap();
          },
          onTapCancel: () {
            setState(() => _isPressed = false);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                constraints.maxWidth * 0.06,
              ),
              boxShadow: [
                if (!_isPressed)
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
              ],
            ),
            padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth * 0.055,
              vertical: constraints.maxWidth * 0.04,
            ),
            transform: Matrix4.identity()
              ..scale(_isPressed ? 0.98 : 1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left side: Icon and title
                _buildLeftSection(context, constraints),

                // Right side: Arrow
                _buildArrowSection(context, constraints),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Builds the left section with icon and title
  Widget _buildLeftSection(
      BuildContext context,
      BoxConstraints constraints,
      ) {
    final iconSize = constraints.maxWidth * 0.065;
    final fontSize = constraints.maxWidth * 0.045;
    final spacing = constraints.maxWidth * 0.035;

    return Row(
      children: [
        // Icon
        Icon(
          widget.icon,
          size: iconSize,
          color: Colors.grey.shade700,
        ),

        // Horizontal spacing
        SizedBox(width: spacing),

        // Title
        Text(
          widget.title,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  /// Builds the arrow section
  Widget _buildArrowSection(
      BuildContext context,
      BoxConstraints constraints,
      ) {
    final iconSize = constraints.maxWidth * 0.055;

    return Icon(
      Icons.chevron_right,
      size: iconSize,
      color: Colors.grey.shade600,
    );
  }
}