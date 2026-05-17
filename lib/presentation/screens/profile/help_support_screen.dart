import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Help & Support",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(w * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Frequently Asked Questions",
              style: TextStyle(
                fontSize: w * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: w * 0.04),
            _buildFAQTile(
              "How does the Virtual Try-On (VTON) work?",
              "Simply upload a clear, front-facing photo of yourself and select a garment from your digital wardrobe. Our AI will seamlessly generate a realistic preview of how the outfit looks on your body.",
            ),
            _buildFAQTile(
              "How are daily outfits recommended?",
              "Our AI acts as your personal stylist. It analyzes your local real-time weather data and the items saved in your digital wardrobe to suggest comfortable and stylish outfits for the day.",
            ),
            _buildFAQTile(
              "What are Coins and Streaks?",
              "We love rewarding consistency! You earn coins by maintaining a daily streak of logging or planning outfits. You can view your progress on the Home screen and soon redeem these coins for exclusive app perks.",
            ),
            _buildFAQTile(
              "Why can't I see my wardrobe without the internet?",
              "Wardrobe-AI includes an offline mode so you can browse your saved items anywhere! However, generating new AI try-ons or fetching live weather data requires an active internet connection.",
            ),
            SizedBox(height: w * 0.08),
            Text(
              "Need more help?",
              style: TextStyle(
                fontSize: w * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: w * 0.02),
            Text(
              "If you're experiencing issues or have feedback, our support team is here to help.",
              style: TextStyle(fontSize: w * 0.035, color: Colors.black54),
            ),
            SizedBox(height: w * 0.06),
            SizedBox(
              width: double.infinity,
              height: w * 0.12,
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implement email launch logic
                  // Example: launchUrl(Uri.parse('mailto:support@wardrobe-ai.com'));
                },
                icon: const Icon(Icons.email_outlined, color: Colors.white),
                label: const Text(
                  "Contact Us (support@wardrobe-ai.com)",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E1E2E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQTile(String question, String answer) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            question,
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: Colors.black87),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Text(answer,
                  style: const TextStyle(color: Colors.black54, height: 1.5)),
            ),
          ],
        ),
      ),
    );
  }
}
