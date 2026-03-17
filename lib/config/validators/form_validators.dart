/// [FormValidators] - Reusable form field validators
///
/// Contains all validation logic for form fields:
/// - Email validation
/// - Password validation
/// - Username validation
/// - General input validation
///
/// All validation happens on the client-side for UX,
/// but backend will perform final validation for security.
///
/// Usage: FormValidators.validateEmail("email@example.com")

class FormValidators {
  // Private constructor to prevent instantiation
  FormValidators._();

  // ==================== Email Validation ====================

  /// Validates email format
  ///
  /// Returns error message if invalid, null if valid
  ///
  /// Rules:
  /// - Must not be empty
  /// - Must contain @ symbol
  /// - Must have valid email format (basic regex)
  /// - Must not exceed 254 characters (RFC 5321)
  ///
  /// Example:
  /// ```
  /// String? error = FormValidators.validateEmail("test@example.com");
  /// // Returns: null (valid)
  ///
  /// String? error = FormValidators.validateEmail("invalid-email");
  /// // Returns: "Please enter a valid email address"
  /// ```
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    // Basic email regex pattern (RFC 5322 simplified)
    final emailRegex =
    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');


    if (!emailRegex.hasMatch(value)) {
    return 'Please enter a valid email address';
    }

    if (value.length > 254) {
    return 'Email address is too long';
    }

    return null;
  }

  // ==================== Password Validation ====================

  /// Validates password strength
  ///
  /// Returns error message if invalid, null if valid
  ///
  /// Rules:
  /// - Must not be empty
  /// - Minimum 8 characters
  /// - Should contain at least one uppercase letter (optional but recommended)
  /// - Should contain at least one lowercase letter (optional but recommended)
  /// - Should contain at least one digit (optional but recommended)
  ///
  /// Note: Backend should enforce stronger password policies
  ///
  /// Example:
  /// ```
  /// String? error = FormValidators.validatePassword("SecurePass123");
  /// // Returns: null (valid)
  ///
  /// String? error = FormValidators.validatePassword("weak");
  /// // Returns: "Password must be at least 8 characters long"
  /// ```
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    // Optional: Check for password strength (comment out if backend handles this)
    // bool hasUppercase = value.contains(RegExp(r'[A-Z]'));
    // bool hasLowercase = value.contains(RegExp(r'[a-z]'));
    // bool hasDigits = value.contains(RegExp(r'[0-9]'));
    //
    // if (!hasUppercase || !hasLowercase || !hasDigits) {
    //   return 'Password must contain uppercase, lowercase, and numbers';
    // }

    return null;
  }

  // ==================== Username Validation ====================

  /// Validates username format
  ///
  /// Returns error message if invalid, null if valid
  ///
  /// Rules:
  /// - Must not be empty
  /// - Minimum 3 characters
  /// - Maximum 20 characters
  /// - Can contain letters, numbers, underscores, and hyphens
  /// - Must start with a letter
  /// - Cannot contain spaces
  ///
  /// Example:
  /// ```
  /// String? error = FormValidators.validateUsername("frank_123");
  /// // Returns: null (valid)
  ///
  /// String? error = FormValidators.validateUsername("ab");
  /// // Returns: "Username must be at least 3 characters long"
  /// ```
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }

    if (value.length < 3) {
      return 'Username must be at least 3 characters long';
    }

    if (value.length > 20) {
      return 'Username must not exceed 20 characters';
    }

    // Username regex: starts with letter, contains letters/numbers/underscore/hyphen
    final usernameRegex = RegExp(r'^[a-zA-Z][a-zA-Z0-9_-]*$');

    if (!usernameRegex.hasMatch(value)) {
      return 'Username can only contain letters, numbers, underscore, and hyphen';
    }

    return null;
  }

  // ==================== General Input Validation ====================

  /// Validates that a field is not empty
  ///
  /// Returns error message if empty, null if has content
  ///
  /// Parameters:
  ///   - value: The input value to validate
  ///   - fieldName: The name of the field (for error message)
  ///
  /// Example:
  /// ```
  /// String? error = FormValidators.validateRequired("input", "Email");
  /// // Returns: null (valid)
  ///
  /// String? error = FormValidators.validateRequired("", "Email");
  /// // Returns: "Email is required"
  /// ```
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Validates minimum length
  ///
  /// Returns error message if too short, null if valid
  ///
  /// Parameters:
  ///   - value: The input value to validate
  ///   - minLength: Minimum required length
  ///   - fieldName: The name of the field (for error message)
  ///
  /// Example:
  /// ```
  /// String? error = FormValidators.validateMinLength("abc", 5, "Username");
  /// // Returns: "Username must be at least 5 characters long"
  /// ```
  static String? validateMinLength(String? value, int minLength, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    if (value.length < minLength) {
      return '$fieldName must be at least $minLength characters long';
    }

    return null;
  }

  /// Validates maximum length
  ///
  /// Returns error message if too long, null if valid
  ///
  /// Parameters:
  ///   - value: The input value to validate
  ///   - maxLength: Maximum allowed length
  ///   - fieldName: The name of the field (for error message)
  static String? validateMaxLength(String? value, int maxLength, String fieldName) {
    if (value != null && value.length > maxLength) {
      return '$fieldName must not exceed $maxLength characters';
    }
    return null;
  }

  /// Validates that two values match (e.g., password confirmation)
  ///
  /// Returns error message if values don't match, null if they do
  ///
  /// Parameters:
  ///   - value: The first value
  ///   - matchValue: The value to match against
  ///   - fieldName: The name of the field (for error message)
  ///
  /// Example:
  /// ```
  /// String? error = FormValidators.validateMatch("password123", "password", "Passwords");
  /// // Returns: "Passwords do not match"
  /// ```
  static String? validateMatch(String? value, String? matchValue, String fieldName) {
    if (value != matchValue) {
      return '$fieldName do not match';
    }
    return null;
  }
}
