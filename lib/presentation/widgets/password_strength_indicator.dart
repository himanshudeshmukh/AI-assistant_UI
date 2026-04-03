/// lib/presentation/widgets/password_strength_indicator.dart
///
/// Visual indicator for password strength with requirements checklist.
library;

import 'package:flutter/material.dart';

/// ============================================================================
/// PASSWORD STRENGTH INDICATOR WIDGET
/// ============================================================================
/// Visual indicator for password strength.
///
/// Shows:
/// - Color-coded strength bar (red, orange, yellow, green)
/// - Text description of strength level
/// - Requirements checklist
///
class PasswordStrengthIndicator extends StatelessWidget {
  final String password;

  const PasswordStrengthIndicator({
    super.key,
    required this.password,
  });

  /// Calculates password strength (0-4).
  int _calculateStrength() {
    int strength = 0;

    if (password.length >= 8) strength++;
    if (password.length >= 12) strength++;
    if (RegExp(r'[A-Z]').hasMatch(password) &&
        RegExp(r'[a-z]').hasMatch(password)) {
      strength++;
    }
    if (RegExp(r'[0-9]').hasMatch(password)) strength++;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) strength++;

    return (strength / 5 * 4).toInt();
  }

  /// Gets strength level text.
  String _getStrengthText() {
    final strength = _calculateStrength();
    switch (strength) {
      case 0:
        return 'Very Weak';
      case 1:
        return 'Weak';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      case 4:
        return 'Strong';
      default:
        return 'Unknown';
    }
  }

  /// Gets strength level color.
  Color _getStrengthColor() {
    final strength = _calculateStrength();
    switch (strength) {
      case 0:
        return Colors.red[600]!;
      case 1:
        return Colors.red[400]!;
      case 2:
        return Colors.orange[600]!;
      case 3:
        return Colors.amber[600]!;
      case 4:
        return Colors.green[600]!;
      default:
        return Colors.grey[400]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (password.isEmpty) {
      return const SizedBox.shrink();
    }

    final strength = _calculateStrength();
    final strengthColor = _getStrengthColor();
    final strengthText = _getStrengthText();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Password Strength',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            Text(
              strengthText,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: strengthColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: (strength + 1) / 5,
            minHeight: 4,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(strengthColor),
          ),
        ),
        const SizedBox(height: 8),
        _buildRequirementsChecklist(context),
      ],
    );
  }

  /// Builds password requirements checklist.
  Widget _buildRequirementsChecklist(BuildContext context) {
    final hasLength = password.length >= 8;
    final hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
    final hasLowercase = RegExp(r'[a-z]').hasMatch(password);
    final hasDigit = RegExp(r'[0-9]').hasMatch(password);
    final hasSpecial = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);

    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: [
        _buildRequirement('8+ chars', hasLength),
        _buildRequirement('Uppercase', hasUppercase),
        _buildRequirement('Lowercase', hasLowercase),
        _buildRequirement('Number', hasDigit),
        _buildRequirement('Special', hasSpecial),
      ],
    );
  }

  /// Builds individual requirement chip.
  Widget _buildRequirement(String label, bool isMet) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isMet ? Colors.green[50] : Colors.grey[100],
        border: Border.all(
          color: isMet ? Colors.green[300]! : Colors.grey[300]!,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.circle_outlined,
            size: 14,
            color: isMet ? Colors.green[600] : Colors.grey[600],
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}