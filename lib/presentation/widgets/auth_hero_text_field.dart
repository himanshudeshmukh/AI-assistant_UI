import 'package:flutter/material.dart';

import '../../config/theme/app_colors.dart';

/// Labeled text field styled for Victus-style auth cards (matches victus_one UI).
class AuthHeroTextField extends StatefulWidget {
  const AuthHeroTextField({
    super.key,
    required this.label,
    required this.placeholder,
    required this.prefixIcon,
    required this.controller,
    this.isPassword = false,
    this.obscureText = true,
    this.onToggleVisibility,
    this.validator,
    this.hint,
    this.onChanged,
  });

  final String label;
  final String placeholder;
  final IconData prefixIcon;
  final TextEditingController controller;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onToggleVisibility;
  final String? Function(String value)? validator;
  final String? hint;
  final ValueChanged<String>? onChanged;

  @override
  State<AuthHeroTextField> createState() => AuthHeroTextFieldState();
}

class AuthHeroTextFieldState extends State<AuthHeroTextField> {
  String? _errorMessage;

  String? validateField() {
    if (widget.validator != null) {
      final error = widget.validator!(widget.controller.text);
      setState(() => _errorMessage = error);
      return error;
    }
    return null;
  }

  void clearError() {
    setState(() => _errorMessage = null);
  }

  @override
  Widget build(BuildContext context) {
    final showLabel = widget.label.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) ...[
          Text(
            widget.label.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
              color: AppColors.authTextOnCard,
            ),
          ),
          const SizedBox(height: 8),
        ],
        Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: _errorMessage != null
                  ? AppColors.errorColor
                  : AppColors.authInputBorder,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(
                widget.prefixIcon,
                size: 18,
                color: AppColors.authInputIcon,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  obscureText: widget.isPassword ? widget.obscureText : false,
                  keyboardType: widget.isPassword
                      ? TextInputType.visiblePassword
                      : TextInputType.emailAddress,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.authTextOnCard,
                  ),
                  decoration: InputDecoration(
                    hintText: widget.placeholder,
                    hintStyle: const TextStyle(
                      color: AppColors.authPlaceholder,
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: (v) {
                    if (_errorMessage != null) {
                      setState(() => _errorMessage = null);
                    }
                    widget.onChanged?.call(v);
                  },
                ),
              ),
              if (widget.isPassword)
                GestureDetector(
                  onTap: widget.onToggleVisibility,
                  child: Icon(
                    widget.obscureText
                        ? Icons.visibility_off
                        : Icons.visibility,
                    size: 18,
                    color: AppColors.authInputIcon,
                  ),
                ),
            ],
          ),
        ),
        if (widget.hint != null) ...[
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              widget.hint!,
              style: const TextStyle(
                color: AppColors.authTextMuted,
                fontSize: 11,
              ),
            ),
          ),
        ],
        if (_errorMessage != null && _errorMessage!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 4),
            child: Text(
              _errorMessage!,
              style: const TextStyle(
                color: AppColors.errorColor,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}
