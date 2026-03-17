/// [SecondaryButton] - Reusable secondary action button widget
///
/// An outline-style button for secondary actions with:
/// - Outlined style with colored border and text
/// - Full width or fixed size options
/// - Loading state support
/// - Disabled state styling
/// - Consistent with primary button API
///
/// Usage:
/// ```
/// SecondaryButton(
///   text: 'Register Now',
///   onPressed: () => navigateToSignup(),
/// )
/// ```

import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_dimensions.dart';
import '../../config/theme/app_text_styles.dart';

class SecondaryButton extends StatefulWidget {
  /// Button label text
  final String text;

  /// Callback when button is pressed
  /// If null, button is disabled
  final VoidCallback? onPressed;

  /// Whether button is in loading state
  final bool isLoading;

  /// Whether button should take full width
  final bool isFullWidth;

  /// Button height
  final double height;

  /// Border color (defaults to primary orange)
  final Color borderColor;

  /// Text color (defaults to primary orange)
  final Color textColor;

  /// Background color (defaults to white)
  final Color backgroundColor;

  /// Loading indicator color
  final Color loadingIndicatorColor;

  const SecondaryButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = true,
    this.height = AppDimensions.buttonHeight,
    this.borderColor = AppColors.primaryOrange,
    this.textColor = AppColors.primaryOrange,
    this.backgroundColor = AppColors.surfaceColor,
    this.loadingIndicatorColor = AppColors.primaryOrange,
  }) : super(key: key);

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton>
    with SingleTickerProviderStateMixin {
  /// Animation controller for tap feedback
  late AnimationController _animationController;

  /// Scale animation
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: AppDimensions.animationDurationFast,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handlePressed() {
    if (widget.isLoading || widget.onPressed == null) {
      return;
    }

    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    widget.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null && !widget.isLoading;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: SizedBox(
        width: widget.isFullWidth ? double.infinity : null,
        height: widget.height,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _handlePressed,
            borderRadius: BorderRadius.circular(AppDimensions.buttonBorderRadius),
            highlightColor: Colors.transparent,
            splashColor: widget.borderColor.withOpacity(0.1),
            child: Container(
              decoration: BoxDecoration(
                // Background color
                color: isEnabled ? widget.backgroundColor : Colors.grey[100],

                // Border
                border: Border.all(
                  color: isEnabled
                      ? widget.borderColor
                      : AppColors.textDisabled,
                  width: AppDimensions.inputBorderWidth,
                ),

                // Border radius
                borderRadius: BorderRadius.circular(
                  AppDimensions.buttonBorderRadius,
                ),
              ),

              child: Center(
                child: widget.isLoading
                    ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      widget.loadingIndicatorColor,
                    ),
                  ),
                )
                    : Text(
                  widget.text,
                  style: AppTextStyles.buttonLarge.copyWith(
                    color: isEnabled
                        ? widget.textColor
                        : AppColors.textDisabled,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
