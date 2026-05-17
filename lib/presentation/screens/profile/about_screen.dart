import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
          "About",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: w * 0.08),
            // --- APP LOGO / NAME ---
            Container(
              padding: EdgeInsets.all(w * 0.06),
              decoration: BoxDecoration(
                color: const Color(0xFFA8D8D8),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Icon(Icons.checkroom, size: w * 0.15, color: Colors.white),
            ),
            SizedBox(height: w * 0.04),
            Text(
              "Wardrobe-AI",
              style: TextStyle(fontSize: w * 0.06, fontWeight: FontWeight.bold),
            ),
            Text(
              "Version 1.0.0",
              style: TextStyle(fontSize: w * 0.035, color: Colors.black54),
            ),
            SizedBox(height: w * 0.08),

            // --- MISSION STATEMENT ---
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.06),
              child: Text(
                "Your AI-powered digital wardrobe and personal styling assistant. "
                "Effortlessly digitize your closet, plan outfits for upcoming trips, "
                "and visually preview clothing on yourself using advanced Artificial Intelligence.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: w * 0.038, color: Colors.black87, height: 1.5),
              ),
            ),
            SizedBox(height: w * 0.08),

            // --- LINKS ---
            Container(
              margin: EdgeInsets.symmetric(horizontal: w * 0.04),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildLinkTile(Icons.public, "Visit our Website", () {}),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  _buildLinkTile(
                      Icons.description_outlined, "Terms of Service", () {}),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  _buildLinkTile(
                      Icons.privacy_tip_outlined, "Privacy Policy", () {}),
                ],
              ),
            ),
            SizedBox(height: w * 0.1),
            Text("© ${DateTime.now().year} Victus One / Kaivon",
                style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right, color: Colors.black26),
      onTap: onTap,
    );
  }
}
