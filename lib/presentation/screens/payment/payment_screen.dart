// class SubscriptionStatus {
//   final bool isActive;
//   final DateTime expiresAt;
//   final DateTime cachedAt;
//
//   SubscriptionStatus({
//     required this.isActive,
//     required this.expiresAt,
//     required this.cachedAt,
//   });
//
//   factory SubscriptionStatus.fromJson(Map<String, dynamic> json) {
//     return SubscriptionStatus(
//       isActive: json['status'] == 'active',
//       expiresAt: DateTime.parse(json['expiresAt']),
//       cachedAt: DateTime.parse(json['cachedAt']),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'status': isActive ? 'active' : 'inactive',
//       'expiresAt': expiresAt.toIso8601String(),
//       'cachedAt': cachedAt.toIso8601String(),
//     };
//   }
// }
//
//
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// class SubscriptionCacheManager {
//   SubscriptionCacheManager._();
//   static final instance = SubscriptionCacheManager._();
//
//   final _storage = const FlutterSecureStorage();
//
//   SubscriptionStatus? _memoryCache;
//
//   static const _key = "subscription_cache";
//
//   /// ==============================
//   /// GET STATUS (MAIN ENTRY)
//   /// ==============================
//   Future<SubscriptionStatus> getStatus({
//     required Future<SubscriptionStatus> Function() apiCall,
//   }) async {
//     // 1️⃣ MEMORY CACHE (FASTEST)
//     if (_memoryCache != null &&
//         _memoryCache!.expiresAt.isAfter(DateTime.now())) {
//       return _memoryCache!;
//     }
//
//     // 2️⃣ SECURE STORAGE
//     final stored = await _storage.read(key: _key);
//     if (stored != null) {
//       final data = SubscriptionStatus.fromJson(jsonDecode(stored));
//
//       if (data.expiresAt.isAfter(DateTime.now())) {
//         _memoryCache = data;
//         return data;
//       }
//     }
//
//     // 3️⃣ API CALL (LAST OPTION)
//     final fresh = await apiCall();
//
//     await _save(fresh);
//     return fresh;
//   }
//
//   /// ==============================
//   /// FORCE REFRESH (AFTER PURCHASE)
//   /// ==============================
//   Future<SubscriptionStatus> forceRefresh({
//     required Future<SubscriptionStatus> Function() apiCall,
//   }) async {
//     _memoryCache = null;
//     await _storage.delete(key: _key);
//
//     final fresh = await apiCall();
//
//     await _save(fresh);
//     return fresh;
//   }
//
//   /// ==============================
//   /// SAVE TO ALL LAYERS
//   /// ==============================
//   Future<void> _save(SubscriptionStatus status) async {
//     _memoryCache = status;
//
//     await _storage.write(
//       key: _key,
//       value: jsonEncode(status.toJson()),
//     );
//   }
//
//   /// ==============================
//   /// CLEAR CACHE
//   /// ==============================
//   Future<void> clear() async {
//     _memoryCache = null;
//     await _storage.delete(key: _key);
//   }
// }
//
//
// class SubscriptionRepository {
//   Future<SubscriptionStatus> fetchStatus() async {
//     final response = await backendApi.checkStatus();
//
//     return SubscriptionStatus(
//       isActive: response['status'] == 'active',
//       expiresAt: DateTime.parse(response['expiresAt']),
//       cachedAt: DateTime.now(),
//     );
//   }
// }
//
//
//
// class SubscriptionService {
//   final repo = SubscriptionRepository();
//   final cache = SubscriptionCacheManager.instance;
//
//   Future<bool> isActive() async {
//     final status = await cache.getStatus(
//       apiCall: () => repo.fetchStatus(),
//     );
//
//     return status.isActive;
//   }
//
//   Future<void> afterPurchaseRefresh() async {
//     await cache.forceRefresh(
//       apiCall: () => repo.fetchStatus(),
//     );
//   }
// }



import 'package:flutter/material.dart';

import '../../../config/theme/app_colors.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedPlan = 0;
  bool isLoading = false;

  final List<Map<String, dynamic>> plans = [
    {
      "title": "Basic Plan",
      "price": "₹249",
      "duration": "1 Month",
      "features": ["Access to basic features", "Limited support"]
    },
    {
      "title": "Pro Plan",
      "price": "₹499",
      "duration": "3 Months",
      "features": ["All features unlocked", "Priority support", "No ads"]
    },
    {
      "title": "Premium Plan",
      "price": "₹899",
      "duration": "6 Months",
      "features": ["Everything in Pro", "1:1 support", "Early access"]
    },
  ];

  void onPayPressed() async {
    setState(() => isLoading = true);

    // 🔥 THIS WILL LATER CALL YOUR BACKEND (RAZORPAY ORDER API)
    await Future.delayed(const Duration(seconds: 2));

    setState(() => isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Proceeding to payment for ${plans[selectedPlan]['title']}",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Plan"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(w * 0.04),
        child: Column(
          children: [
            SizedBox(height: h * 0.02),

            Text(
              "Upgrade your experience",
              style: TextStyle(
                fontSize: w * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: h * 0.03),

            Expanded(
              child: ListView.builder(
                itemCount: plans.length,
                itemBuilder: (context, index) {
                  final plan = plans[index];

                  final isSelected = selectedPlan == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPlan = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: EdgeInsets.only(bottom: h * 0.02),
                      padding: EdgeInsets.all(w * 0.04),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.softTeal300
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                        color: isSelected
                            ? Colors.teal.withOpacity(0.08)
                            : Colors.white,
                        boxShadow: [
                          if (isSelected)
                            BoxShadow(
                              color: Colors.teal.withOpacity(0.2),
                              blurRadius: 10,
                              spreadRadius: 2,
                            )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plan['title'],
                            style: TextStyle(
                              fontSize: w * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: h * 0.005),

                          Text(
                            "${plan['price']} / ${plan['duration']}",
                            style: TextStyle(
                              fontSize: w * 0.04,
                              color: Colors.grey,
                            ),
                          ),

                          SizedBox(height: h * 0.02),

                          ...List.generate(
                            plan['features'].length,
                                (i) => Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                children: [
                                  const Icon(Icons.check,
                                      color: AppColors.softTeal300, size: 18),
                                  const SizedBox(width: 8),
                                  Text(plan['features'][i]),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: h * 0.01),

            SizedBox(
              width: double.infinity,
              height: h * 0.065,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.softTeal300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: isLoading ? null : onPayPressed,
                child: isLoading
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                    : Text(
                  "Pay ${plans[selectedPlan]['price']}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}