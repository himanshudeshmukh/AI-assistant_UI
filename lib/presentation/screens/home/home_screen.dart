// import 'package:flutter/material.dart';
//
// import '../../../config/theme/app_colors.dart';
// import '../../../config/theme/app_dimensions.dart';
// import '../../../config/theme/app_text_styles.dart';
// import '../../../data/models/outfit_model.dart';
//
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   // ==================== State ====================
//   /// List of outfit recommendations
//   late List<OutfitModel> _outfits;
//
//   /// Featured outfit
//   late OutfitModel _featuredOutfit;
//
//   /// Loading state
//   bool _isLoading = false;
//
//   // ==================== Lifecycle ====================
//   @override
//   void initState() {
//     super.initState();
//     _loadOutfits();
//   }
//
//   /// Loads outfit data (dummy for now, backend later)
//   ///
//   /// To convert to backend:
//   /// Replace DummyOutfitData.getOutfits() with API call:
//   /// ```dart
//   /// _outfits = await OutfitService.fetchOutfits();
//   /// _featuredOutfit = await OutfitService.fetchFeaturedOutfit();
//   /// ```
//   void _loadOutfits() {
//     setState(() => _isLoading = true);
//
//     // Simulate network delay
//     Future.delayed(const Duration(milliseconds: 500), () {
//       if (mounted) {
//         setState(() {
//           _outfits = DummyOutfitData.getOutfits();
//           _featuredOutfit = DummyOutfitData.getTodaysOutfit();
//           _isLoading = false;
//         });
//       }
//     });
//   }
//
//   // ==================== Build ====================
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       body: _buildBody(),
//     );
//   }
//
//   /// Builds the body content
//   Widget _buildBody() {
//     if (_isLoading) {
//       return const Center(
//         child: CircularProgressIndicator(
//           valueColor: AlwaysStoppedAnimation<Color>(
//             AppColors.primaryOrange,
//           ),
//         ),
//       );
//     }
//
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ==================== Greeting ====================
//           _buildGreeting(),
//
//           // ==================== Featured Outfit ====================
//           SizedBox(height: AppDimensions.paddingL),
//           _buildFeaturedOutfit(),
//
//           // ==================== Style Picks Header ====================
//           SizedBox(height: AppDimensions.paddingXXL),
//           _buildStylePicksHeader(),
//
//           // ==================== Outfit Cards (Scrollable) ====================
//           SizedBox(height: AppDimensions.paddingL),
//           _buildOutfitCardsList(),
//
//           // ==================== Bottom Spacing ====================
//           SizedBox(height: AppDimensions.paddingXXL),
//         ],
//       ),
//     );
//   }
//
//   /// Builds the greeting section
//   Widget _buildGreeting() {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(
//         AppDimensions.paddingXL,
//         AppDimensions.paddingXL,
//         AppDimensions.paddingXL,
//         0,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 DummyOutfitData.getGreeting('Sarah'),
//                 style: AppTextStyles.bodySmall.copyWith(
//                   color: AppColors.textSecondary,
//                   fontSize: 14,
//                 ),
//               ),
//             ],
//           ),
//           // Dropdown indicator
//           const Icon(
//             Icons.keyboard_arrow_down,
//             color: AppColors.textSecondary,
//             size: 20,
//           ),
//         ],
//       ),
//     );
//   }
//
//   /// Builds the featured outfit card
//   Widget _buildFeaturedOutfit() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: AppDimensions.paddingXL,
//       ),
//       child: Container(
//         height: 300,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Colors.purple.withOpacity(0.15),
//               Colors.pink.withOpacity(0.1),
//             ],
//           ),
//           borderRadius: BorderRadius.circular(AppDimensions.borderRadiusL),
//         ),
//         child: Stack(
//           children: [
//             // ==================== Background Image ====================
//             Positioned(
//               right: -50,
//               top: -50,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(AppDimensions.borderRadiusL),
//                 // child: Image.network(
//                 //   _featuredOutfit.imageUrl,
//                 //   width: 400,
//                 //   height: 400,
//                 //   fit: BoxFit.cover,
//                 //   errorBuilder: (context, error, stackTrace) {
//                 //     return Container(
//                 //       width: 400,
//                 //       height: 400,
//                 //       color: AppColors.primaryOrange.withOpacity(0.2),
//                 //       child: const Icon(Icons.image),
//                 //     );
//                 //   },
//                 // ),
//                 child: Image.asset(
//
//                 ),
//               ),
//             ),
//
//             // ==================== Content ====================
//             Padding(
//               padding: const EdgeInsets.all(AppDimensions.paddingXL),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Title
//                   Text(
//                     _featuredOutfit.title,
//                     style: AppTextStyles.headingLarge.copyWith(
//                       color: const Color(0xFF1a1a2e),
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//
//                   // Description and button
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         _featuredOutfit.description,
//                         style: AppTextStyles.bodySmall.copyWith(
//                           color: AppColors.textSecondary,
//                           fontSize: 16,
//                         ),
//                       ),
//
//                       const SizedBox(height: AppDimensions.paddingL),
//
//                       // View Outfit Button
//                       ElevatedButton(
//                         onPressed: () {
//                           debugPrint('View outfit tapped');
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           elevation: 0,
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: AppDimensions.paddingXL,
//                             vertical: AppDimensions.paddingM,
//                           ),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(50),
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(
//                               'View Outfit',
//                               style: AppTextStyles.bodyMedium.copyWith(
//                                 color: const Color(0xFF1a1a2e),
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             SizedBox(width: AppDimensions.paddingS),
//                             const Icon(
//                               Icons.arrow_forward,
//                               color: Color(0xFF1a1a2e),
//                               size: 18,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// Builds the "Style Picks for You" header
//   Widget _buildStylePicksHeader() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: AppDimensions.paddingXL,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             'Style Picks for You',
//             style: AppTextStyles.headingSmall.copyWith(
//               color: AppColors.textPrimary,
//               fontSize: 20,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           Icon(
//             Icons.arrow_forward,
//             color: AppColors.textSecondary,
//           ),
//         ],
//       ),
//     );
//   }
//
//   /// Builds the scrollable list of outfit cards
//   ///
//   /// Uses ListView.builder for efficient rendering
//   /// Easy to switch to backend API data
//   Widget _buildOutfitCardsList() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: AppDimensions.paddingXL,
//       ),
//       child: ListView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: _outfits.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: EdgeInsets.only(
//               bottom: AppDimensions.paddingL,
//             ),
//             child: _buildOutfitCard(_outfits[index]),
//           );
//         },
//       ),
//     );
//   }
//
//   /// Builds a single outfit card
//   ///
//   /// [outfit] - The outfit to display
//   Widget _buildOutfitCard(OutfitModel outfit) {
//     return GestureDetector(
//       onTap: () {
//         debugPrint('Tapped outfit: ${outfit.title}');
//       },
//       child: Container(
//         height: 250,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(AppDimensions.borderRadiusL),
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: _getCardGradientColors(outfit.category ?? ''),
//           ),
//         ),
//         child: Stack(
//           children: [
//             // ==================== Background Image ====================
//             // Positioned(
//             //   right: -30,
//             //   top: -30,
//             //   bottom: -30,
//             //   child: ClipRRect(
//             //     borderRadius: BorderRadius.circular(AppDimensions.borderRadiusL),
//             //     child: Image.network(
//             //       outfit.imageUrl,
//             //       width: 280,
//             //       fit: BoxFit.cover,
//             //       errorBuilder: (context, error, stackTrace) {
//             //         return Container(
//             //           width: 280,
//             //           color: AppColors.primaryOrange.withOpacity(0.2),
//             //           child: const Icon(Icons.image),
//             //         );
//             //       },
//             //     ),
//             //   ),
//             // ),
//             Positioned( right: -30,
//             top: -30,
//             bottom: -30,
//             child: Image.asset(
//               'assets/clothes/images.jpg'),
//             ),
//             // ==================== Content ====================
//             Padding(
//               padding: const EdgeInsets.all(AppDimensions.paddingL),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Title
//                   Text(
//                     outfit.title,
//                     style: AppTextStyles.headingSmall.copyWith(
//                       color: const Color(0xFF1a1a2e),
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//
//                   // Description and button
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         outfit.description,
//                         style: AppTextStyles.bodySmall.copyWith(
//                           color: AppColors.textSecondary,
//                           fontSize: 13,
//                         ),
//                       ),
//
//                       SizedBox(height: AppDimensions.paddingL),
//
//                       // View Outfit Button
//                       ElevatedButton(
//                         onPressed: () {
//                           debugPrint('View ${outfit.title} tapped');
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           elevation: 0,
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: AppDimensions.paddingL,
//                             vertical: AppDimensions.paddingS,
//                           ),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(50),
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(
//                               'View Outfit',
//                               style: AppTextStyles.bodySmall.copyWith(
//                                 color: const Color(0xFF1a1a2e),
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             SizedBox(width: AppDimensions.paddingXS),
//                             const Icon(
//                               Icons.arrow_forward,
//                               color: Color(0xFF1a1a2e),
//                               size: 14,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// Gets gradient colors based on outfit category
//   ///
//   /// [category] - The outfit category
//   /// Returns appropriate gradient colors
//   List<Color> _getCardGradientColors(String category) {
//     switch (category.toLowerCase()) {
//       case 'casual':
//         return [
//           Colors.amber.withOpacity(0.15),
//           Colors.orange.withOpacity(0.1),
//         ];
//       case 'professional':
//         return [
//           Colors.pink.withOpacity(0.15),
//           Colors.red.withOpacity(0.1),
//         ];
//       case 'athletic':
//         return [
//           Colors.purple.withOpacity(0.15),
//           Colors.blue.withOpacity(0.1),
//         ];
//       case 'formal':
//         return [
//           Colors.blue.withOpacity(0.15),
//           Colors.indigo.withOpacity(0.1),
//         ];
//       default:
//         return [
//           Colors.grey.withOpacity(0.15),
//           Colors.blueGrey.withOpacity(0.1),
//         ];
//     }
//   }
// }


/// [HomeScreen] - Home screen with featured outfit and outfit recommendations
///
/// Displays:
/// - Greeting message
/// - Featured "Today's Outfit" card with asset image
/// - Vertically scrollable outfit cards with asset images
/// - Easy to switch from dummy to backend data
///
/// Following: Clean architecture, Responsive design, Professional UX
library;


import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_text_styles.dart';
import '../../../config/theme/app_dimensions.dart';
import '../../../data/models/outfit_model.dart';

/// Home screen displaying outfit recommendations and featured outfit
///
/// Features:
/// - Greeting message that changes by time of day
/// - Featured "Today's Outfit" card with asset image
/// - Scrollable list of style recommendations with asset images
/// - Designed for easy backend integration
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ==================== State ====================
  /// List of outfit recommendations
  late List<OutfitModel> _outfits;

  /// Featured outfit
  late OutfitModel _featuredOutfit;

  /// Loading state
  bool _isLoading = false;

  // ==================== Lifecycle ====================
  @override
  void initState() {
    super.initState();
    _loadOutfits();
  }

  /// Loads outfit data (dummy for now, backend later)
  ///
  /// To convert to backend:
  /// Replace DummyOutfitData.getOutfits() with API call:
  /// ```dart
  /// _outfits = await OutfitService.fetchOutfits();
  /// _featuredOutfit = await OutfitService.fetchFeaturedOutfit();
  /// ```
  void _loadOutfits() {
    setState(() => _isLoading = true);

    // Simulate network delay
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() {
          _outfits = DummyOutfitData.getOutfits();
          _featuredOutfit = DummyOutfitData.getTodaysOutfit();
          _isLoading = false;
        });
      }
    });
  }

  // ==================== Build ====================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _buildBody(),
    );
  }

  /// Builds the body content
  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            AppColors.authHeroAccent,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==================== Greeting ====================
          _buildGreeting(),

          // ==================== Featured Outfit ====================
          const SizedBox(height: AppDimensions.paddingL),
          _buildFeaturedOutfit(),

          // ==================== Style Picks Header ====================
          const SizedBox(height: AppDimensions.paddingXXL),
          _buildStylePicksHeader(),

          // ==================== Outfit Cards (Scrollable) ====================
          const SizedBox(height: AppDimensions.paddingL),
          _buildOutfitCardsList(),

          // ==================== Bottom Spacing ====================
          const SizedBox(height: AppDimensions.paddingXXL),
        ],
      ),
    );
  }

  /// Builds the greeting section
  Widget _buildGreeting() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.paddingXL,
        AppDimensions.paddingXL,
        AppDimensions.paddingXL,
        0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DummyOutfitData.getGreeting('Sarah'),
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          // Dropdown indicator
          const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white54,
            size: 20,
          ),
        ],
      ),
    );
  }

  /// Featured outfit — dark card, no background image.
  Widget _buildFeaturedOutfit() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingXL,
      ),
      child: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height / 5.5,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF141414),
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusL),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingXL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _featuredOutfit.title,
                style: AppTextStyles.headingLarge.copyWith(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppDimensions.paddingM),
              Text(
                _featuredOutfit.description,
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.white70,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the "Style Picks for You" header
  Widget _buildStylePicksHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingXL,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Style Picks for You',
            style: AppTextStyles.headingSmall.copyWith(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Icon(
            Icons.arrow_forward,
            color: Colors.white54,
          ),
        ],
      ),
    );
  }

  /// Outfit cards as a single scroll (no nested ListView physics).
  Widget _buildOutfitCardsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingXL,
      ),
      child: Column(
        children: [
          for (final outfit in _outfits)
            Padding(
              padding: const EdgeInsets.only(bottom: AppDimensions.paddingL),
              child: _buildOutfitCard(outfit),
            ),
        ],
      ),
    );
  }

  /// Single outfit row — dark surface, no image.
  Widget _buildOutfitCard(OutfitModel outfit) {
    return GestureDetector(
      onTap: () {
        debugPrint('Tapped outfit: ${outfit.title}');
      },
      child: Container(
        constraints: const BoxConstraints(minHeight: 120),
        decoration: BoxDecoration(
          color: const Color(0xFF141414),
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusL),
          border: Border.all(color: Colors.white.withOpacity(0.06)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                outfit.title,
                style: AppTextStyles.headingSmall.copyWith(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppDimensions.paddingS),
              Text(
                outfit.description,
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.white60,
                  fontSize: 13,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}