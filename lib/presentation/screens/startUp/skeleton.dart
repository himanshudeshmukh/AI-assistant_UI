import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../config/theme/app_theme.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SkeletonBox(height: 20, width: 150),
            const SizedBox(height: 8),
            const SkeletonBox(height: 28, width: 200),
            const SizedBox(height: 16),
            const SkeletonBox(height: 45, width: double.infinity),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                5,
                (_) => const SkeletonBox(height: 60, width: 60),
              ),
            ),

            const SizedBox(height: 20),

            MinimalCard(
              child: Row(
                children: const [
                  SkeletonBox(height: 40, width: 40),
                  SizedBox(width: 12),
                  Expanded(
                    child: SkeletonBox(height: 14, width: double.infinity),
                  ),
                ],
              ),
            ),

            const Spacer(), // ✅ FILLS REMAINING SPACE
            const SkeletonBox(height: 150, width: double.infinity),
          ],
        ),
      ),
    );
  }
}

class SkeletonBox extends StatelessWidget {
  final double height;
  final double width;

  const SkeletonBox({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
