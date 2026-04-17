import 'package:flutter/material.dart';
import 'profile_header.dart';
import 'profile_sound_toggle.dart';

class ProfileScreen extends StatefulWidget {
  final VoidCallback onBackToHome;

  const ProfileScreen({
    super.key,
    required this.onBackToHome,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isSoundEnabled = true;

  // ================= HANDLERS =================
  void _handleBackPress() => widget.onBackToHome();

  void _handleEditProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Edit Profile")),
    );
  }

  void _handleHelpSupport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Help & Support")),
    );
  }

  void _handlePoints() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("My Points")),
    );
  }

  void _handleNotifications() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Notifications")),
    );
  }

  void _handleAbout() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("About")),
    );
  }

  void _handleLogout() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Logout")),
    );
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFA8D8D8),

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: _handleBackPress,
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        leadingWidth: 60,
      ),

      // ================= BODY =================
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: w * 0.04),
          child: Column(
            children: [
              SizedBox(height: w * 0.03),

              // PROFILE HEADER
              ProfileHeader(onBackPress: _handleBackPress),

              SizedBox(height: w * 0.05),

              // MENU SECTION
              _buildMenuSection(w),

              SizedBox(height: w * 0.05),

              // SOUND TOGGLE
              ProfileSoundToggle(
                isEnabled: _isSoundEnabled,
                onToggle: (val) {
                  setState(() => _isSoundEnabled = val);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= MENU =================
  Widget _buildMenuSection(double w) {
    return Column(
      children: [
        // ===== TOP CARDS =====
        Row(
          children: [
            Expanded(
              child: _MenuCard(
                icon: Icons.edit,
                title: "Edit Profile",
                onTap: _handleEditProfile,
              ),
            ),
            SizedBox(width: w * 0.04),
            Expanded(
              child: _MenuCard(
                icon: Icons.help_outline,
                title: "Help & Support",
                onTap: _handleHelpSupport,
              ),
            ),
          ],
        ),

        SizedBox(height: w * 0.04),

        // ===== FULL WIDTH ITEMS =====
        _FullWidthMenuCard(
          icon: Icons.star,
          title: "My Points",
          onTap: _handlePoints,
        ),

        SizedBox(height: w * 0.03),

        _FullWidthMenuCard(
          icon: Icons.notifications,
          title: "Notifications",
          onTap: _handleNotifications,
        ),

        SizedBox(height: w * 0.03),

        _FullWidthMenuCard(
          icon: Icons.info_outline,
          title: "About",
          onTap: _handleAbout,
        ),

        SizedBox(height: w * 0.03),

        _FullWidthMenuCard(
          icon: Icons.logout,
          title: "Logout",
          isDestructive: true,
          onTap: _handleLogout,
        ),
      ],
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: w * 0.06,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: w * 0.08, color: Colors.black87),
            SizedBox(height: w * 0.02),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: w * 0.035,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FullWidthMenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  const _FullWidthMenuCard({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: w * 0.04,
          vertical: w * 0.045,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive ? Colors.red : Colors.black87,
            ),
            SizedBox(width: w * 0.04),

            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: w * 0.04,
                  fontWeight: FontWeight.w600,
                  color: isDestructive ? Colors.red : Colors.black87,
                ),
              ),
            ),

            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }
}
