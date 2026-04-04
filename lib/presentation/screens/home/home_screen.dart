import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:profiler/config/theme/app_colors.dart';
import 'package:profiler/config/theme/app_dimensions.dart';
import 'package:provider/provider.dart';
import '../../../data/controller/user_controller.dart';
import '../../../data/controller/weather_controller.dart';
import '../../widgets/weather.dart';
import '../startUp/CalenderPage.dart';

/// Main Home Screen - Displays user info, categories, and weather widget
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openCalendarPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => const CalendarPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Consumer<UserController>(
      //     builder: (context, userController, child) {
      //       return _WelcomeSection(
      //         userName: userController.currentUser?.name ?? 'Guest',
      //       );
      //     },
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppDimensions.paddingXXL),
              // Section 1: Welcome message with user name
              Consumer<UserController>(
                builder: (context, userController, child) {
                  return _WelcomeSection(
                    userName: userController.currentUser?.name ?? 'Guest',
                  );
                },
              ),

              const SizedBox(height: 40),

              // Section 2: Categories
              const _CategoriesSection(),

              const SizedBox(height: 40),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (_) => const CalendarPage(),
                    ),
                  );
                },
                icon: FaIcon(FontAwesomeIcons.calendarDay, size: 40),
                label: Text(
                  "Plan outfit",
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  backgroundColor: AppColors.authSocialLabel,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
              ),

              const SizedBox(height: 40),

              // Section 4: Recent Items
              const _RecentItemsSection(),

              const SizedBox(height: 40),
// Section 3: Weather Card (appears instantly from cache)
              const WeatherWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

/// Welcome section showing user name and personalized greeting
/// Welcome section showing user name and personalized greeting with card design
/// Welcome section showing user name and personalized greeting
/// Height is exactly 1/5 of screen height with very rounded borders
class _WelcomeSection extends StatelessWidget {
  final String userName;

  const _WelcomeSection({required this.userName});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28), // Very rounded corners
          side: BorderSide(
            width: 1.5,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.authPrimaryButton,
                  AppColors.authSocialLabel,
                ]),
            borderRadius:
                BorderRadius.circular(28), // Match card's borderRadius
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                // Text content - Expanded to take remaining space
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hello, ${_getDisplayName()}!',
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _getPersonalizedMessage(),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getDisplayName() {
    if (userName == 'Guest') return 'there';
    return userName.split(' ').first;
  }

  String _getPersonalizedMessage() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good morning! Ready to plan your outfit for today? 🌅';
    } else if (hour < 17) {
      return 'Good afternoon! Check the weather before you step out! ☀️';
    } else {
      return 'Good evening! Plan your outfit for tomorrow! 🌙';
    }
  }
}

/// Categories section - Shows different clothing categories with FontAwesome icons
class _CategoriesSection extends StatelessWidget {
  const _CategoriesSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Category',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        // First row of categories
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _CategoryChip('T-Shirts', FontAwesomeIcons.shirt),
            _CategoryChip('Shirts', FontAwesomeIcons.bacon),
            _CategoryChip('Pants', FontAwesomeIcons.gem),
            _CategoryChip('accessories', FontAwesomeIcons.clock),
          ],
        ),
      ],
    );
  }
}

/// Individual category chip widget with FontAwesome icons
class _CategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const _CategoryChip(this.label, this.icon);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add navigation or action when category is tapped
        print('Tapped on $label category');
        // You can navigate to category details page here
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.black,
                  AppColors.authTextOnCard,
                ],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: FaIcon(
              icon,
              size: 40,
              color: AppColors.authHeroAccent,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}

/// Recent items section - Shows recently added items
class _RecentItemsSection extends StatelessWidget {
  const _RecentItemsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Best for this Weather',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                width: 200,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.checkroom,
                        size: 40, color: Colors.grey.shade600),
                    const SizedBox(height: 8),
                    Text(
                      'Outfit ${index + 1}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
