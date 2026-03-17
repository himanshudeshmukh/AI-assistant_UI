/// lib/presentation/screens/widgets/
///
/// Reusable UI components for authentication screens.
/// Follows component composition principles and single responsibility.
///

import 'package:flutter/material.dart';

/// ============================================================================
/// AUTH TEXT FIELD WIDGET
/// ============================================================================
/// Reusable text input field with validation feedback, icon support,
/// and customizable styling.
///
/// Features:
/// - Input validation with error display
/// - Prefix and suffix icons
/// - Password obscuring
/// - Suffix icon callback (for visibility toggle, etc.)
/// - Consistent styling across auth forms
///
class AuthTextField extends StatelessWidget {
  final String? value;
  final String hintText;
  final String? errorText;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final ValueChanged<String> onChanged;
  final VoidCallback? onSuffixIconPressed;
  final bool enabled;
  final int maxLines;
  final int minLines;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;

  const AuthTextField({
    Key? key,
    this.value,
    required this.hintText,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    required this.onChanged,
    this.onSuffixIconPressed,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines = 1,
    this.textInputAction = TextInputAction.next,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasError = errorText != null && errorText!.isNotEmpty;

    return TextFormField(
      initialValue: value,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      enabled: enabled,
      maxLines: obscureText ? 1 : maxLines,
      minLines: minLines,
      textInputAction: textInputAction,
      focusNode: focusNode,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.grey[400],
        ),
        prefixIcon: prefixIcon != null
            ? Icon(
          prefixIcon,
          color: hasError ? Colors.red : Colors.grey[600],
          size: 20,
        )
            : null,
        suffixIcon: suffixIcon != null
            ? IconButton(
          icon: Icon(
            suffixIcon,
            color: Colors.grey[600],
            size: 20,
          ),
          onPressed: onSuffixIconPressed,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        )
            : null,
        filled: true,
        fillColor: enabled ? Colors.grey[50] : Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: hasError ? Colors.red[300]! : Colors.grey[300]!,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey[300]!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: hasError ? Colors.red : Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.red[300]!,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        errorText: errorText,
        errorStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Colors.red[600],
          height: 1.2,
        ),
        errorMaxLines: 2,
      ),
    );
  }
}

/// ============================================================================
/// AUTH BUTTON WIDGET
/// ============================================================================
/// Primary call-to-action button for authentication forms.
///
/// Features:
/// - Loading state with spinner
/// - Disabled state handling
/// - Consistent sizing and styling
/// - Accessibility support
///
class AuthButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final double? width;
  final double height;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const AuthButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.width,
    this.height = 48,
    this.backgroundColor,
    this.foregroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDisabled = !isEnabled || isLoading || onPressed == null;

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
          foregroundColor: foregroundColor ?? Colors.white,
          disabledBackgroundColor: Colors.grey[400],
          disabledForegroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: isLoading
            ? SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              foregroundColor ?? Colors.white,
            ),
          ),
        )
            : Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: foregroundColor ?? Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

/// ============================================================================
/// ERROR SNACKBAR WIDGET
/// ============================================================================
/// Material Design snackbar for displaying error messages.
///
class ErrorSnackbar extends SnackBar {
  ErrorSnackbar({
    required String message,
    Duration duration = const Duration(seconds: 4),
    SnackBarAction? action,
  }) : super(
    content: Row(
      children: [
        const Icon(
          Icons.error_outline,
          color: Colors.white,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
    backgroundColor: Colors.red[600],
    duration: duration,
    action: action,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    margin: const EdgeInsets.all(16),
    behavior: SnackBarBehavior.floating,
  );
}

/// ============================================================================
/// SUCCESS SNACKBAR WIDGET
/// ============================================================================
/// Material Design snackbar for displaying success messages.
///
class SuccessSnackbar extends SnackBar {
  SuccessSnackbar({
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) : super(
    content: Row(
      children: [
        const Icon(
          Icons.check_circle_outline,
          color: Colors.white,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
    backgroundColor: Colors.green[600],
    duration: duration,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    margin: const EdgeInsets.all(16),
    behavior: SnackBarBehavior.floating,
  );
}


/// ============================================================================
/// DIVIDER WITH TEXT WIDGET
/// ============================================================================
/// Divider line with centered text (typically for "OR" separators).
///
class DividerWithText extends StatelessWidget {
  final String text;

  const DividerWithText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey[300],
            height: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey[300],
            height: 1,
          ),
        ),
      ],
    );
  }
}
