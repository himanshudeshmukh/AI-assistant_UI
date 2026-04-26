/// Firebase Phone Auth + `POST /api/v1/users/verify-otp` (Spring).
library;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../config/theme/app_colors.dart';
import '../../../data/models/user_api_models.dart' show VerifyOtpRequest;
import '../../../data/network/api_client.dart';
import '../../widgets/auth_hero_primary_button.dart';
import '../../widgets/auth_hero_text_field.dart';

class PhoneVerificationRouteArgs {
  final String mobileNumber;
  final bool afterRegistration;

  const PhoneVerificationRouteArgs({
    required this.mobileNumber,
    this.afterRegistration = false,
  });
}

class PhoneVerificationScreen extends StatefulWidget {
  final String mobileNumber;
  final bool afterRegistration;

  const PhoneVerificationScreen({
    super.key,
    required this.mobileNumber,
    this.afterRegistration = false,
  });

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final _api = ApiClient.instance;
  final _otpController = TextEditingController();
  final _otpFieldKey = GlobalKey<AuthHeroTextFieldState>();

  String? _verificationId;
  int? _resendToken;
  bool _smsSent = false;
  bool _loadingSend = false;
  bool _loadingVerify = false;
  String? _errorMessage;

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  String? _validateOtp(String value) {
    final t = value.trim();
    if (t.isEmpty) return 'Enter the SMS code';
    if (t.length < 4) return 'Code looks too short';
    return null;
  }

  Future<void> _sendSms() async {
    setState(() {
      _errorMessage = null;
      _loadingSend = true;
    });

    final phone = widget.mobileNumber.trim();

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        forceResendingToken: _resendToken,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-retrieval (Android) — sign in then backend verify.
          try {
            await FirebaseAuth.instance.signInWithCredential(credential);
            final token =
                await FirebaseAuth.instance.currentUser?.getIdToken();
            if (token == null || !mounted) return;
            await _completeBackendVerify(token);
          } catch (e) {
            if (mounted) {
              setState(() => _errorMessage = e.toString());
            }
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          if (!mounted) return;
          setState(() {
            _errorMessage = e.message ?? e.code;
            _loadingSend = false;
          });
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          if (!mounted) return;
          setState(() {
            _verificationId = verificationId;
            _resendToken = forceResendingToken;
            _smsSent = true;
            _loadingSend = false;
            _errorMessage = null;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('SMS code sent')),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId ??= verificationId;
        },
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage =
              'Firebase error: $e. Did you add Firebase config (flutterfire configure)?';
          _loadingSend = false;
        });
      }
    }
  }

  Future<void> _completeBackendVerify(String idToken) async {
    setState(() {
      _errorMessage = null;
      _loadingVerify = true;
    });

    try {
      final user = await _api.verifyOtp(
        VerifyOtpRequest(
          mobileNumber: widget.mobileNumber.trim(),
          idToken: idToken,
        ),
      );

      if (!mounted) return;

      setState(() => _loadingVerify = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            user.registrationCompleted
                ? 'Signed in as ${user.firstName ?? user.mobileNumber}'
                : 'Phone verified',
          ),
          backgroundColor: AppColors.successColor,
        ),
      );

      Navigator.of(context).pushNamedAndRemoveUntil('/home', (r) => false);
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.message;
        _loadingVerify = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString();
        _loadingVerify = false;
      });
    }
  }

  Future<void> _onVerifyPressed() async {
    setState(() => _errorMessage = null);
    if (_otpFieldKey.currentState?.validateField() != null) return;

    final vid = _verificationId;
    if (vid == null) {
      setState(() => _errorMessage = 'Request an SMS code first');
      return;
    }

    setState(() => _loadingVerify = true);

    try {
      final cred = PhoneAuthProvider.credential(
        verificationId: vid,
        smsCode: _otpController.text.trim(),
      );
      await FirebaseAuth.instance.signInWithCredential(cred);
      final token = await FirebaseAuth.instance.currentUser?.getIdToken();
      if (token == null) {
        throw StateError('No Firebase ID token after sign-in');
      }
      await _completeBackendVerify(token);
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.message ?? e.code;
          _loadingVerify = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _loadingVerify = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final subtitle = widget.afterRegistration
        ? 'We sent a verification code to confirm your number.'
        : 'Sign in with the code sent to your phone.';

    return Scaffold(
      backgroundColor: AppColors.authCardSurface,
      appBar: AppBar(
        title: const Text('Verify phone'),
        backgroundColor: AppColors.backgroundColor,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.mobileNumber,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.authTextOnCard,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.authTextSecondary,
                ),
              ),
              const SizedBox(height: 28),
              if (!_smsSent)
                AuthHeroPrimaryButton(
                  text: _loadingSend ? 'Sending…' : 'Send SMS code',
                  isLoading: _loadingSend,
                  onPressed: _loadingSend ? null : _sendSms,
                )
              else ...[
                AuthHeroTextField(
                  key: _otpFieldKey,
                  label: 'SMS code',
                  placeholder: '6-digit code',
                  prefixIcon: Icons.sms_outlined,
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  validator: _validateOtp,
                ),
                const SizedBox(height: 20),
                AuthHeroPrimaryButton(
                  text: 'Verify & continue',
                  isLoading: _loadingVerify,
                  onPressed: _loadingVerify ? null : _onVerifyPressed,
                ),
                TextButton(
                  onPressed: (_loadingSend || _loadingVerify) ? null : _sendSms,
                  child: const Text('Resend SMS'),
                ),
              ],
              if (_errorMessage != null && _errorMessage!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.errorLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(
                        color: AppColors.errorColor,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
