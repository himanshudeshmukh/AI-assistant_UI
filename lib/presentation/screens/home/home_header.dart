import 'package:Kaivon/presentation/screens/home/liked_outfits.dart';
import 'package:Kaivon/presentation/screens/home/recommendation_screen.dart';
import 'package:Kaivon/presentation/screens/home/silhouette.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_dimensions.dart';
import '../../../config/theme/app_theme.dart';
import '../../widgets/ip_startup_info_service.dart';
import '../category_section/RateOutfits.dart';
import '../category_section/explore_page.dart';
import '../category_section/play_zone.dart';
import '../category_section/saved_outfits.dart';
import '../tripPlanner/trip_planner.dart';
import '../category_section/try_on.dart';
import 'CalenderPage.dart';
import '../startUp/StartUpInfo.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      child: SizedBox(
        width: double.infinity, // ✅ forces full width
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Good Morning,",
                  style: TextStyle(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Himanshu",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                 IconButton(onPressed: (){}, icon: Icon(
                  Icons.notifications_active
                )),
                const SizedBox(height: 4),
                IconButton(onPressed: (){}, icon: Icon(
                    Icons.account_balance_wallet
                )
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TryOn()),
              );
            },
            label: const FaIcon(
              FontAwesomeIcons.heart,
              size: 30,
              color: Colors.white,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueGrey,
              padding: const EdgeInsets.all(12),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16), // 👈 rounded
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LikedOutfits()),
              );
            },
            label: Icon(
              Icons.bookmark_border,
              size: 30,
              color: Colors.white,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueGrey,
              padding: const EdgeInsets.all(12),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16), // 👈 rounded
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PlayZone()),
              );
            },
            label: const FaIcon(
              FontAwesomeIcons.gamepad,
              size: 30,
              color: Colors.white,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueGrey,
              padding: const EdgeInsets.all(12),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16), // 👈 rounded
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RateOutfits()),
              );
            },
            label:
              FaIcon(FontAwesomeIcons.rankingStar,
              size: 30,
              color: Colors.white,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueGrey,
              padding: const EdgeInsets.all(12),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16), // 👈 rounded
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ExplorePage()),
              );
            },
            label:
            FaIcon(FontAwesomeIcons.images,
              size: 30,
              color: Colors.white,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueGrey,
              padding: const EdgeInsets.all(12),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16), // 👈 rounded
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class DateCard extends StatelessWidget {
  const DateCard({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CalendarPage()),
        );
      },
      child: Container(
        height: 90,
        width: 90,
        padding: const EdgeInsets.all(10), // 👈 slightly reduced

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// 🔼 TOP TEXT (AUTO FIT)
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown, // 👈 auto shrink
                child: Text(
                  "${_dayName(now.weekday)}, ${_monthName(now.month)}",
                  style: TextStyle(
                    fontSize: 14, // 👈 base size
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 4),

            /// 🔽 BIG DATE (AUTO FIT)
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "${now.day}",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _dayName(int day) {
    const days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return days[day - 1];
  }

  String _monthName(int month) {
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[month - 1];
  }
}

class DataCard extends StatelessWidget {
  const DataCard({super.key});

  @override
  Widget build(BuildContext context) {
     return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const GenerateScreen()),
        );
      },
      child: Container(
        width: 90,  // 👈 smaller size
        height: 90,

        padding: const EdgeInsets.all(10),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.mark_chat_unread_outlined,
              size: 30,
            ),

            const SizedBox(height: 6),

            Flexible( // 👈 IMPORTANT (prevents overflow)
              child: Text(
                "Style Chat",
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14), // 👈 smaller text
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StyleYourSelf extends StatelessWidget {
  const StyleYourSelf({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const LikedOutfits()),
        );
      },
      child: Container(
        width: 90,  // 👈 smaller size
        height: 90,

        padding: const EdgeInsets.all(10),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Icon(
            Icons.accessibility_new_outlined, // 👈 reduced icon size
               size: 35,
             ),

            const SizedBox(height: 6),

            Flexible( // 👈 IMPORTANT (prevents overflow)
              child: Text(
                "Find Fit",
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14), // 👈 smaller text
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Liked extends StatelessWidget {
  const Liked({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const LikedOutfits()),
        );
      },
      child: Container(
        width: 90,  // 👈 smaller size
        height: 90,

        padding: const EdgeInsets.all(10),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              FontAwesomeIcons.heart,
              size: 30, // 👈 reduced icon size
            ),

            const SizedBox(height: 6),

            Flexible( // 👈 IMPORTANT (prevents overflow)
              child: Text(
                "Liked Outfits",
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12), // 👈 smaller text
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Trip extends StatelessWidget {
  const Trip({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TripPlanner()),
        );
      },
      child: Container(
        width: 90,  // 👈 smaller size
        height: 90,

        padding: const EdgeInsets.all(10),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

              Icon(Icons.luggage, size: 40),
            const SizedBox(height: 6),

            Flexible( // 👈 IMPORTANT (prevents overflow)
              child: Text(
                "Trip Planner",
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12), // 👈 smaller text
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OutfitCard extends StatelessWidget {
  const OutfitCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          children: [
            // 🔥 Bottom Section
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFFEAEAEA),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text
                  const Text(
                    "Today's Outfit",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),

                  // Icon Button
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              barrierColor: Colors.transparent,
                              // no dark background
                              builder: (context) {
                                return Stack(
                                  children: [
                                    // Position popup near button (center-right style)
                                    Positioned(
                                      top: 200, // adjust as needed
                                      right: 20, // adjust as needed
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Container(
                                          width: 260,
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(14),
                                            boxShadow: const [
                                              BoxShadow(
                                                blurRadius: 10,
                                                color: Colors.black26,
                                              )
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              // Header
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Text(
                                                    "Outfit Info",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () =>
                                                        Navigator.pop(context),
                                                    child: const Icon(Icons.close,
                                                        size: 18),
                                                  ),
                                                ],
                                              ),

                                              const SizedBox(height: 10),

                                              const Text(
                                                  "👕 Topwear: Black Hoodie"),
                                              const Text(
                                                  "👖 Bottomwear: Cargo Pants"),

                                              const SizedBox(height: 10),
                                              const Divider(),

                                              const Text(
                                                "✨ Accessories",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              const SizedBox(height: 6),

                                              const Text("• Watch"),
                                              const Text("• Sneakers"),
                                              const Text("• Cap"),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: const FaIcon(FontAwesomeIcons.eye),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: IconButton(onPressed: (){}, icon: Icon(
                            Icons.bookmark_border
                        ),
                          iconSize: 40,),
                      ),
                      SizedBox(width: 5,),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 🔥 Mannequin Image
            AspectRatio(
              aspectRatio: 5 / 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Image.asset(
                  'assets/images/dummy.webp',
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(height: 16),

          ],
        ),
      ),
    );
  }
}
