import 'package:flutter/material.dart';

import '../../notifications/notification.dart';

// import your notification service
// import 'notification_service.dart';

class ProfileSoundToggle extends StatefulWidget {
  const ProfileSoundToggle({
    super.key,
    required this.isEnabled,
    required this.onToggle,
  });

  final bool isEnabled;
  final Function(bool) onToggle;

  @override
  State<ProfileSoundToggle> createState() => _ProfileSoundToggleState();
}

class _ProfileSoundToggleState extends State<ProfileSoundToggle> {
  late bool isEnabled;

  @override
  void initState() {
    super.initState();
    isEnabled = widget.isEnabled;
  }

  void _handleToggle() {
    setState(() {
      isEnabled = !isEnabled;
    });

    widget.onToggle(isEnabled);

    if (isEnabled) {
      NotificationService().startAutoScheduler(
        title: "Outfit Update 👕",
        message: "Your outfit is ready",
        intervalInMinutes: 2,
      );
    } else {
      NotificationService().stopAutoScheduler();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final iconSize = constraints.maxWidth * 0.065;
        final fontSize = constraints.maxWidth * 0.045;
        final spacing = constraints.maxWidth * 0.035;

        final switchWidth = constraints.maxWidth * 0.15;
        final switchHeight = switchWidth * 0.6;
        final toggleSize = switchHeight * 0.85;

        const activeBgColor = Color(0xFF7EC4C4);
        const inactiveBgColor = Color(0xFFE0E0E0);

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              constraints.maxWidth * 0.06,
            ),
            boxShadow: [
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ================= LEFT =================
              Row(
                children: [
                  Icon(
                    Icons.volume_up,
                    size: iconSize,
                    color: Colors.grey.shade700,
                  ),
                  SizedBox(width: spacing),
                  Text(
                    'Sound',
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),

              // ================= TOGGLE =================
              GestureDetector(
                onTap: _handleToggle,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: switchWidth,
                  height: switchHeight,
                  decoration: BoxDecoration(
                    color: isEnabled
                        ? activeBgColor
                        : inactiveBgColor,
                    borderRadius:
                    BorderRadius.circular(switchHeight / 2),
                    boxShadow: [
                      BoxShadow(
                        color: (isEnabled
                            ? activeBgColor
                            : inactiveBgColor)
                            .withOpacity(0.4),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 300),
                        left: isEnabled
                            ? switchWidth * 0.5
                            : switchWidth * 0.05,
                        top: (switchHeight - toggleSize) / 2,
                        child: Container(
                          width: toggleSize,
                          height: toggleSize,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
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
      },
    );
  }
}