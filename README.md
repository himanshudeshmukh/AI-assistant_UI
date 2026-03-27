# authenticator

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.




# Wardrobe Gallery Flutter Sample
Replace the `baseUrl` in `lib/main.dart` with your backend URL.
Expected API response:
```json
{
"data": [
{
"id": "1",
"title": "Oversized Blazer",
"category": "Outerwear",
"style": "City Tailored",
"color": "Beige",
"imageUrl": "https://cdn.example.com/images/blazer.png",
"tags": ["outerwear", "neutral"]
}
]
}
```
The service also accepts a top-level JSON array instead of `{
"data": [] }`.
