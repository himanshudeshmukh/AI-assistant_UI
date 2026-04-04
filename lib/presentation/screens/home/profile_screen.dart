// import 'package:flutter/material.dart';
//
// import '../../../config/theme/app_text_styles.dart';
//
// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: const Center(
//         child: Text(
//           "Ankit will work on this Page",
//           style: AppTextStyles.headingLarge,
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EDED),

      body: SingleChildScrollView(
        child: Column(
          children: [

            /// 🔥 TOP RED HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 24),
              decoration: const BoxDecoration(
                color: Color(0xFFE35D5B),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(28),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// PROFILE ROW
                  Row(
                    children: [

                      /// PROFILE IMAGE
                      const CircleAvatar(
                        radius: 26,
                        backgroundImage: AssetImage("assets/profile.jpg"),
                      ),

                      const SizedBox(width: 12),

                      /// NAME + STATS
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "rajat",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.star, size: 14, color: Colors.amber),
                              SizedBox(width: 4),
                              Text("4.2"),
                              SizedBox(width: 10),
                              Icon(Icons.favorite, size: 14, color: Colors.red),
                              SizedBox(width: 4),
                              Text("20"),
                            ],
                          )
                        ],
                      ),

                      const Spacer(),

                      /// RIGHT ICONS
                      Row(
                        children: [
                          _circleIcon(Icons.notifications_none),
                          const SizedBox(width: 10),
                          _walletChip(),
                        ],
                      )
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// LIVE CARD
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3F0E8),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Row(
                      children: [

                        const Icon(Icons.circle, size: 10, color: Colors.green),

                        const SizedBox(width: 10),

                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "You Are Live 🚀",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "People can connect with you",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(Icons.check, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// STATS CARD
            _card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _statItem(Icons.call, "0", "Calls"),
                  _statItem(Icons.star, "4.2", "Rating"),
                  _statItem(Icons.access_time, "0m", "Today"),
                  _statItem(Icons.currency_rupee, "₹0", "Earned"),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// TWO SMALL CARDS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(child: _miniCard("0m", "of 4h", "Online")),
                  const SizedBox(width: 12),
                  Expanded(child: _miniCard("20", "Score", "Availability")),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// QUICK ACTIONS
            _sectionTitle("Quick Actions"),

            _gridActions(),

            const SizedBox(height: 16),

            /// SHARE BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFE04B3F),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Text(
                    "Share Your Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// RULES
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8EFD8),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Withdrawal Rules"),
                    Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// 🔹 REUSABLES

  static Widget _circleIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(icon),
    );
  }

  static Widget _walletChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          Icon(Icons.account_balance_wallet, size: 18),
          SizedBox(width: 4),
          Text("₹0"),
        ],
      ),
    );
  }

  static Widget _card({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: child,
      ),
    );
  }

  static Widget _statItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, size: 18),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  static Widget _miniCard(String title, String subtitle, String tag) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(subtitle),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(tag, style: const TextStyle(fontSize: 12)),
          )
        ],
      ),
    );
  }

  static Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }

  static Widget _gridActions() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _actionCard("Leaderboard")),
              const SizedBox(width: 12),
              Expanded(child: _actionCard("People")),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _actionCard("Withdraw")),
              const SizedBox(width: 12),
              Expanded(child: _actionCard("Call History")),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _actionCard(String title) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(title),
    );
  }
}