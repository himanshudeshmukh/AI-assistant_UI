class Responsive {
  Responsive._();
  static double maxContentWidth(double screenWidth) {
    return screenWidth > 560 ? 560 : screenWidth;
  }
  static double pagePadding(double width) {
    return (width * 0.06).clamp(10.0, 24.0).toDouble();
  }
  static double sectionGap(double width) {
    return (width * 0.04).clamp(8.0, 16.0).toDouble();
  }
  static double itemGap(double width) {
    return (width * 0.05).clamp(14.0, 22.0).toDouble();
  }
  static double titleSize(double width) {
    return (width * 0.075).clamp(20.0, 30.0).toDouble();
  }
  static double productAspectRatio(double width) {
    if (width < 360) return 0.78;
    if (width < 600) return 0.84;
    return 0.95;
  }
  static double navHeight(double width) {
    return width < 360 ? 72 : 76;
  }

  static double cardWidth(double width) {
    final padding = pagePadding(width);
    final gap = itemGap(width);
    return (width - (padding * 2) - gap) / 1;
  }

  static double cardHeight(double width) {
    final cardW = cardWidth(width);
    final aspectRatio = productAspectRatio(width);

    return cardW / aspectRatio;
  }

  static double imageHeight(double width) {
    return cardHeight(width) * 1; // 75% for image
  }
  static double fullCardHeight(double width) {
    return imageHeight(width) + 60; // 60 for text + spacing
  }
}