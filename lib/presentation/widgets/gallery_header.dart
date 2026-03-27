// import 'package:flutter/material.dart';
// import '../../config/constants/constants.dart';
// import '../../config/theme/app_colors.dart';
// import '../../config/utils/responsive.dart';
// import '../screens/home/WalletPage.dart';
// class GalleryHeader extends StatelessWidget {
//   const GalleryHeader({
//     super.key,
//     required this.contentWidth,
//     required this.searchController,
//     required this.onSearchChanged,
//     required this.onFilterSelected,
//   });
//   final double contentWidth;
//   final TextEditingController searchController;
//   final ValueChanged<String> onSearchChanged;
//   final ValueChanged<String> onFilterSelected;
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final gap = Responsive.sectionGap(contentWidth);
//     final titleSize = Responsive.titleSize(contentWidth);
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         SizedBox(height: gap * 1.6),
//         const SizedBox(height: 6),
//
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//
//             /// LEFT → Title
//             Text(
//               'Wardrobe',
//               style: theme.textTheme.titleLarge?.copyWith(
//                 fontSize: titleSize,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//
//             /// RIGHT → Wallet Icon
//             IconButton(
//               icon: const Icon(Icons.wallet),
//               iconSize: 30,
//               color: AppColors.textPrimary,
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => WalletPage()),
//                 );
//               },
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }