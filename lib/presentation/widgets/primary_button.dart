/// [PrimaryButton] - Reusable primary action button widget
///
/// A material-style button with:
/// - Customizable text and loading state
/// - Full width or fixed size options
/// - Disabled state styling
/// - Loading indicator animation
/// - Proper padding and styling
/// - Tap feedback with scale animation
///
/// Usage:
/// ```
/// PrimaryButton(
///   text: 'Login',
///   isLoading: isLoading,
///   onPressed: isLoading ? null : handleLogin,
/// )
/// ```
library;

import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_dimensions.dart';
import '../../config/theme/app_text_styles.dart';

class PrimaryButton extends StatefulWidget {
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

  /// Loading indicator color (defaults to white)
  final Color loadingIndicatorColor;

  /// Custom loading widget (defaults to CircularProgressIndicator)
  final Widget? customLoadingWidget;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = true,
    this.height = AppDimensions.buttonHeight,
    this.loadingIndicatorColor = AppColors.surfaceColor,
    this.customLoadingWidget,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  /// Animation controller for tap feedback
  late AnimationController _animationController;

  /// Scale animation
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Setup scale animation for tap feedback
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

  /// Handle button press with animation
  void _handlePressed() {
    // Don't allow press if loading or no callback
    if (widget.isLoading || widget.onPressed == null) {
      return;
    }

    // Play tap animation
    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    // Call the callback
    widget.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    // Determine if button is enabled
    final isEnabled = widget.onPressed != null && !widget.isLoading;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: SizedBox(
        width: widget.isFullWidth ? double.infinity : null,
        height: widget.height,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            // ========== Visual Feedback ==========
            onTap: _handlePressed,
            borderRadius:
                BorderRadius.circular(AppDimensions.buttonBorderRadius),
            highlightColor: Colors.transparent,
            splashColor: Colors.white.withOpacity(0.1),

            // ========== Button Container ==========
            child: Container(
              decoration: BoxDecoration(
                // Button color based on state
                color: isEnabled
                    ? AppColors.authHeroAccent
                    : AppColors.textDisabled,

                // Border radius
                borderRadius: BorderRadius.circular(
                  AppDimensions.buttonBorderRadius,
                ),

                // Shadow for depth
                boxShadow: [
                  if (isEnabled)
                    BoxShadow(
                      color: AppColors.authHeroAccent.withOpacity(0.8),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                ],
              ),

              // ========== Button Content ==========
              child: Center(
                child: widget.isLoading
                    // ========== Loading State ==========
                    ? widget.customLoadingWidget ??
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              widget.loadingIndicatorColor,
                            ),
                          ),
                        )
                    // ========== Button Text ==========
                    : Text(
                        widget.text,
                        style: AppTextStyles.headingMedium,
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
