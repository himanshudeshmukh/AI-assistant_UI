/// [CustomTextField] - Reusable text input field widget
/// 
/// A customizable text input field with:
/// - Manual validation (only when you call validate())
/// - Error message display below field
/// - Password visibility toggle capability
/// - Prefix and suffix icons
/// - Custom styling following app design system
/// 
/// Features:
/// - NO automatic validation on change
/// - Displays error text below the field (when manually set)
/// - Shows red border when validation fails
/// - Supports obscured text (for passwords)
/// - Customizable keyboard types
/// - Disabled state support
/// 
/// Example Usage:
/// ```dart
/// CustomTextField(
///   label: 'Email',
///   hint: 'Enter your email',
///   controller: _emailController,
/// )
/// ```

import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_text_styles.dart';
import '../../config/theme/app_dimensions.dart';

class CustomTextField extends StatefulWidget {
  /// Placeholder text displayed inside the field
  final String hint;

  /// Controller for managing the text input
  final TextEditingController controller;

  /// Validation function that returns error message or null
  /// Called ONLY when you manually call it, not automatically
  final String? Function(String)? validator;

  /// Whether password text should be hidden (default: false)
  final bool obscureText;

  /// Keyboard type for the input field
  final TextInputType keyboardType;

  /// Maximum number of characters allowed
  final int? maxLength;

  /// Maximum number of lines (1 = single line text field)
  final int maxLines;

  /// Whether the field is enabled (default: true)
  final bool enabled;

  /// Icon to display before the text
  final Widget? prefixIcon;

  /// Icon to display after the text (e.g., visibility toggle)
  final Widget? suffixIcon;

  /// Callback when suffix icon is tapped
  final VoidCallback? onSuffixIconTap;

  /// Callback when text changes
  final ValueChanged<String>? onChanged;

  /// Callback when user submits (e.g., presses done)
  final ValueChanged<String>? onSubmitted;

  const CustomTextField({
    Key? key,
    required this.hint,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.maxLines = 1,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.onChanged,
    this.onSubmitted,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => CustomTextFieldState ();
}

class CustomTextFieldState  extends State<CustomTextField> {
  /// Current error message (null if no error)
  /// Only set manually, not automatically on change
  String? _errorMessage;

  /// Focus node for the input field
  late FocusNode _internalFocusNode;

  @override
  void initState() {
    super.initState();
    _internalFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _internalFocusNode.dispose();
    super.dispose();
  }

  /// Validate the current input value
  /// Call this manually from parent widget (e.g., on button click)
  /// Returns error message or null
  String? validateField() {
    if (widget.validator != null) {
      final error = widget.validator!(widget.controller.text);
      setState(() => _errorMessage = error);
      return error;
    }
    return null;
  }

  /// Clear the error message
  void clearError() {
    setState(() => _errorMessage = null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ==================== Input Field ====================
        TextField(
          controller: widget.controller,
          focusNode: _internalFocusNode,
          enabled: widget.enabled,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          minLines: 1,
          onChanged: (value) {
            // Only call parent's onChanged callback
            // Do NOT validate on change
            widget.onChanged?.call(value);
          },
          onSubmitted: widget.onSubmitted,
          textInputAction: widget.maxLines == 1
              ? TextInputAction.next
              : TextInputAction.done,
          style: AppTextStyles.inputText,
          decoration: InputDecoration(
            // ==================== Border Styling ====================
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
              borderSide: const BorderSide(
                color: AppColors.inputBorderColor,
                width: AppDimensions.inputBorderWidth,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
              borderSide: const BorderSide(
                color: AppColors.inputBorderColor,
                width: AppDimensions.inputBorderWidth,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
              borderSide: const BorderSide(
                color: AppColors.inputFocusBorderColor,
                width: AppDimensions.inputFocusBorderWidth,
              ),
            ),
            // Red border when there's an error
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
              borderSide: const BorderSide(
                color: AppColors.errorColor,
                width: AppDimensions.inputBorderWidth,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
              borderSide: const BorderSide(
                color: AppColors.errorColor,
                width: AppDimensions.inputFocusBorderWidth,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
              borderSide: const BorderSide(
                color: AppColors.textDisabled,
                width: AppDimensions.inputBorderWidth,
              ),
            ),

            // ==================== Background ====================
            filled: true,
            fillColor: widget.enabled
                ? AppColors.inputBackgroundColor
                : AppColors.textDisabled.withOpacity(0.1),

            // ==================== Hint Text ====================
            hintText: widget.hint,
            hintStyle: AppTextStyles.inputHint,

            // ==================== Content Padding ====================
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.inputPaddingHorizontal,
              vertical: AppDimensions.inputPaddingVertical,
            ),

            // ==================== Icons ====================
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon != null
                ? GestureDetector(
              onTap: widget.onSuffixIconTap,
              child: widget.suffixIcon,
            )
                : null,

            // ==================== IMPORTANT ====================
            // NO errorText or error parameters!
            // Error is displayed separately below the field
          ),
        ),

        // ==================== Error Message Display ====================
        // Display error message below the input field (only if set)
        if (_errorMessage != null && _errorMessage!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(
              top: AppDimensions.paddingS,
              left: AppDimensions.paddingM,
            ),
            child: Text(
              _errorMessage!,
              style: AppTextStyles.errorText,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
    );
  }
}