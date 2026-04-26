/// Horizontal subscription pricing cards + Razorpay checkout via Spring
/// `POST /api/v1/wallets/{userId}/subscription-intent`.
library;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profiler/data/models/wallet_api_models.dart';
import 'package:profiler/data/network/api_client.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

/// Display label (mock) vs whole rupees sent to your API as `amountRupees`.
///
/// Adjust [amountRupees] to your real INR tiers; Razorpay `amount` in the
/// intent response is in **paise** and is passed through to checkout unchanged.
class SubscriptionPlanTier {
  final String title;
  final Color headerColor;
  final String displayPrice;
  final int amountRupees;

  const SubscriptionPlanTier({
    required this.title,
    required this.headerColor,
    required this.displayPrice,
    required this.amountRupees,
  });
}

const _planTiers = [
  SubscriptionPlanTier(
    title: 'Basic User',
    headerColor: Color(0xFFC21872),
    displayPrice: r'$50',
    amountRupees: 50,
  ),
  SubscriptionPlanTier(
    title: 'Advanced User',
    headerColor: Color(0xFF7B1FA2),
    displayPrice: r'$65',
    amountRupees: 65,
  ),
  SubscriptionPlanTier(
    title: 'Premium User',
    headerColor: Color(0xFFE64A19),
    displayPrice: r'$70',
    amountRupees: 70,
  ),
  SubscriptionPlanTier(
    title: 'Exclusive User',
    headerColor: Color(0xFFFF9800),
    displayPrice: r'$80',
    amountRupees: 80,
  ),
];

const _featureLine =
    'Seamlessly deliver client centered of empowerment.';

class SubscriptionPricingScreen extends StatefulWidget {
  const SubscriptionPricingScreen({super.key});

  @override
  State<SubscriptionPricingScreen> createState() =>
      _SubscriptionPricingScreenState();
}

class _SubscriptionPricingScreenState extends State<SubscriptionPricingScreen> {
  final _api = ApiClient.instance;
  late final Razorpay _razorpay;
  String? _busyPlanTitle;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _onPaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _onPaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _onExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _onPaymentSuccess(PaymentSuccessResponse response) {
    if (!mounted) return;
    setState(() => _busyPlanTitle = null);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Payment recorded. Order: ${response.orderId ?? "—"}',
        ),
        backgroundColor: Colors.green.shade800,
      ),
    );
  }

  void _onPaymentError(PaymentFailureResponse response) {
    if (!mounted) return;
    setState(() => _busyPlanTitle = null);
    final msg = response.message ?? response.code ?? 'Payment failed';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red.shade800),
    );
  }

  void _onExternalWallet(ExternalWalletResponse response) {
    if (!mounted) return;
    setState(() => _busyPlanTitle = null);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('External wallet: ${response.walletName}')),
    );
  }

  Future<void> _startCheckout(SubscriptionPlanTier plan) async {
    if (kIsWeb) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Razorpay checkout runs on Android or iOS. Web needs a separate flow.',
          ),
        ),
      );
      return;
    }

    final userId = _api.currentUserId;
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign in first to subscribe.'),
        ),
      );
      return;
    }

    setState(() => _busyPlanTitle = plan.title);

    try {
      final RazorpayIntentData intent = await _api.createSubscriptionIntent(
        userId,
        amountRupees: plan.amountRupees,
      );

      if (!mounted) return;

      final user = _api.currentUser;
      final options = <String, dynamic>{
        'key': intent.key,
        'amount': intent.amount,
        'currency': intent.currency,
        'name': 'Victus One',
        'description': '${plan.title} — subscription',
        'order_id': intent.orderId,
        'prefill': <String, String>{
          if (user?.mobileNumber != null) 'contact': user!.mobileNumber!,
        },
      };

      _razorpay.open(options);
    } on ApiException catch (e) {
      if (mounted) {
        setState(() => _busyPlanTitle = null);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message)),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _busyPlanTitle = null);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Choose your plan'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: GoogleFonts.montserrat(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 900;
          if (isWide) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1120),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var i = 0; i < _planTiers.length; i++) ...[
                        if (i > 0) const SizedBox(width: 16),
                        Expanded(
                          child: _PricingPlanCard(
                            plan: _planTiers[i],
                            busy: _busyPlanTitle == _planTiers[i].title,
                            onSignUp: () => _startCheckout(_planTiers[i]),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          }
          return Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 420,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                itemCount: _planTiers.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final plan = _planTiers[index];
                  return SizedBox(
                    width: 220,
                    child: _PricingPlanCard(
                      plan: plan,
                      busy: _busyPlanTitle == plan.title,
                      onSignUp: () => _startCheckout(plan),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HeaderZigzagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const amplitude = 9.0;
    const teeth = 14;
    final toothW = size.width / teeth;
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - amplitude);
    var x = size.width;
    for (var i = 0; i < teeth; i++) {
      path.lineTo(x, size.height - amplitude);
      path.lineTo(x - toothW / 2, size.height);
      path.lineTo(x - toothW, size.height - amplitude);
      x -= toothW;
    }
    path.lineTo(0, size.height - amplitude);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _PricingPlanCard extends StatelessWidget {
  const _PricingPlanCard({
    required this.plan,
    required this.busy,
    required this.onSignUp,
  });

  final SubscriptionPlanTier plan;
  final bool busy;
  final VoidCallback onSignUp;

  @override
  Widget build(BuildContext context) {
    final titleStyle = GoogleFonts.montserrat(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: Colors.white.withOpacity(0.95),
    );
    final priceStyle = GoogleFonts.montserrat(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      height: 1.05,
    );
    final bodyStyle = GoogleFonts.montserrat(
      fontSize: 12,
      height: 1.45,
      color: const Color(0xFF4A4A4A),
    );

    return SizedBox(
      height: 400,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 100),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 6, 14, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        3,
                        (_) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.check_circle,
                                size: 18,
                                color: plan.headerColor,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(_featureLine, style: bodyStyle),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 0, 14, 16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: FilledButton(
                        onPressed: busy ? null : onSignUp,
                        style: FilledButton.styleFrom(
                          backgroundColor: plan.headerColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: busy
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Sign Up',
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: _HeaderZigzagClipper(),
              child: Container(
                height: 108,
                decoration: BoxDecoration(
                  color: plan.headerColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(plan.title, style: titleStyle),
                    const SizedBox(height: 6),
                    Text(plan.displayPrice, style: priceStyle),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 2,
            left: 0,
            right: 0,
            child: Center(
              child: Transform.rotate(
                angle: -0.12,
                child: Container(
                  width: 76,
                  height: 26,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.55),
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
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
