/// Profile Header Component
///
/// Displays user profile information including:
/// - Profile avatar (circular with image)
/// - User name
/// - Username handle
/// - All fully responsive and dynamic
///
/// Usage:
/// ```dart
/// ProfileHeader(
///   onBackPress: () => Navigator.pop(context),
///   onNotificationPress: () {},
/// )
/// ```

import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  /// Creates a profile header.
  ///
  /// Parameters:
  /// - [onBackPress]: Callback when back button is pressed
  const ProfileHeader({
    super.key,
    required this.onBackPress,
  });

  /// Callback when back button is pressed
  final VoidCallback onBackPress;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              constraints.maxWidth * 0.08,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: constraints.maxWidth * 0.06,
            vertical: constraints.maxWidth * 0.08,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile avatar
              _buildProfileAvatar(context, constraints),

              // Vertical spacing
              SizedBox(height: constraints.maxWidth * 0.06),

              // Name
              _buildUserName(context, constraints),

              // Vertical spacing
              SizedBox(height: constraints.maxWidth * 0.02),

            ],
          ),
        );
      },
    );
  }

  /// Builds the profile avatar
  Widget _buildProfileAvatar(BuildContext context,
      BoxConstraints constraints,) {
    final avatarSize = constraints.maxWidth * 0.35;

    return Container(
      width: avatarSize,
      height: avatarSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey.shade300,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: avatarSize * 0.15,
            offset: Offset(0, avatarSize * 0.08),
          ),
        ],
      ),
      child: ClipOval(
        child: Container(
          color: const Color(0xFFA8D8D8),
          child: Image.asset(
            'assets/avatars/Avatars - Default.png',
            fit: BoxFit.contain,
            // Fallback: Show placeholder if image doesn't exist
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Icon(
                  Icons.person,
                  size: avatarSize * 0.5,
                  color: Colors.grey.shade400,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /// Builds the user name
  Widget _buildUserName(BuildContext context,
      BoxConstraints constraints,) {
    final fontSize = constraints.maxWidth * 0.065;

    return Text(
      'Himanshu Deshmukh',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
        height: 1.2,
      ),
    );
  }
}



/// Profile Stats Card Component
///
/// Displays user statistics like steps with a label.
/// Features:
/// - Responsive sizing
/// - Icon display
/// - Steps count
/// - Custom label
/// - Soft color styling
///
/// Usage:
/// ```dart
/// ProfileStatsCard(
///   steps: 6859,
///   stepsLabel: 'Steps today',
/// )
/// ```

class ProfileStatsCard extends StatelessWidget {
  /// Creates a profile stats card.
  ///
  /// Parameters:
  /// - [steps]: Number of steps (defaults to 6859)
  /// - [stepsLabel]: Label for the steps (defaults to 'Steps today')
  const ProfileStatsCard({
    super.key,
    required this.steps,
    required this.stepsLabel,
  });

  /// Number of steps to display
  final int steps;

  /// Label for the stats
  final String stepsLabel;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF7EC4C4),
            borderRadius: BorderRadius.circular(
              constraints.maxWidth * 0.08,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: constraints.maxWidth * 0.06,
            vertical: constraints.maxWidth * 0.045,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side: Icon and steps
              _buildStepsSection(context, constraints),

              // Right side: Label
              _buildLabelSection(context, constraints),
            ],
          ),
        );
      },
    );
  }

  /// Builds the steps section with icon and count
  Widget _buildStepsSection(
      BuildContext context,
      BoxConstraints constraints,
      ) {
    final iconSize = constraints.maxWidth * 0.08;
    final fontSize = constraints.maxWidth * 0.062;
    final spacing = constraints.maxWidth * 0.03;

    return Row(
      children: [
        // Steps icon
        Icon(
          Icons.directions_walk,
          size: iconSize,
          color: Colors.white,
        ),

        // Horizontal spacing
        SizedBox(width: spacing),

        // Steps count
        Text(
          steps.toString(),
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            height: 1.2,
          ),
        ),
      ],
    );
  }

  /// Builds the label section
  Widget _buildLabelSection(
      BuildContext context,
      BoxConstraints constraints,
      ) {
    final fontSize = constraints.maxWidth * 0.035;

    return Text(
      stepsLabel,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: Colors.white,
        height: 1.4,
      ),
    );
  }
}