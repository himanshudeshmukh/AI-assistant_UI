class WardrobeItem {
  const WardrobeItem({
    required this.id,
    required this.title,
    required this.category,
    required this.style,
    required this.color,
    required this.imageUrl,
    required this.tags,
  });
  final String id;
  final String title;
  final String category;
  final String style;
  final String color;
  final String imageUrl;
  final List<String> tags;
  factory WardrobeItem.fromJson(Map<String, dynamic> json) {
    final rawTags = json['tags'];
    return WardrobeItem(
      id: (json['id'] ?? '').toString(),
      title: (json['title'] ?? json['name'] ?? '').toString(),
      category: (json['category'] ?? 'Fashion').toString(),
      style: (json['style'] ?? json['subtitle'] ?? '').toString(),
      color: (json['color'] ?? 'Neutral').toString(),
      imageUrl: (
          json['imageUrl'] ??
              json['image'] ??
              json['image_url'] ??
              json['thumbnail'] ??
              ''
      ).toString(),
      tags: rawTags is List
          ? rawTags.map((tag) => tag.toString()).toList(growable:
      false)
          : const <String>[],
    );
  }
  bool matchesFilter(String filter) {
    final normalizedFilter = filter.toLowerCase();
    return category.toLowerCase().contains(normalizedFilter) ||
        style.toLowerCase().contains(normalizedFilter) ||
        tags.any((tag) =>
            tag.toLowerCase().contains(normalizedFilter));
  }
  bool matchesQuery(String query) {
    final normalizedQuery = query.toLowerCase();
    return title.toLowerCase().contains(normalizedQuery) ||
        category.toLowerCase().contains(normalizedQuery) ||
        style.toLowerCase().contains(normalizedQuery) ||
        color.toLowerCase().contains(normalizedQuery) ||
        tags.any((tag) =>
            tag.toLowerCase().contains(normalizedQuery));
  }
}
