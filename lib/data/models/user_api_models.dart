/// DTOs for `/api/v1/users/...` endpoints (Spring Boot).
library;

class User {
  final String id;
  final String? firstName;
  final String? lastName;
  final String? mobileNumber;
  final bool registrationCompleted;
  final bool isSubscribed;
  final bool isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const User({
    required this.id,
    this.firstName,
    this.lastName,
    this.mobileNumber,
    required this.registrationCompleted,
    required this.isSubscribed,
    required this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    DateTime? parseDt(dynamic v) {
      if (v is String) return DateTime.tryParse(v);
      return null;
    }

    return User(
      id: '${json['id']}',
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      registrationCompleted: json['registrationCompleted'] as bool? ?? false,
      isSubscribed: json['isSubscribed'] as bool? ?? false,
      isDeleted: json['isDeleted'] as bool? ?? false,
      createdAt: parseDt(json['createdAt']),
      updatedAt: parseDt(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'mobileNumber': mobileNumber,
        'registrationCompleted': registrationCompleted,
        'isSubscribed': isSubscribed,
        'isDeleted': isDeleted,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}

class RegisterRequest {
  final String name;
  final String mobileNumber;

  const RegisterRequest({required this.name, required this.mobileNumber});

  Map<String, dynamic> toJson() => {
        'name': name,
        'mobileNumber': mobileNumber,
      };
}

class VerifyOtpRequest {
  final String mobileNumber;
  final String idToken;

  const VerifyOtpRequest({
    required this.mobileNumber,
    required this.idToken,
  });

  Map<String, dynamic> toJson() => {
        'mobileNumber': mobileNumber,
        'idToken': idToken,
      };
}

class SendLoginOtpRequest {
  final String mobileNumber;

  const SendLoginOtpRequest({required this.mobileNumber});

  Map<String, dynamic> toJson() => {'mobileNumber': mobileNumber};
}

/// Partial profile update — omit keys you do not change.
class ProfileUpdateRequest {
  final String? firstName;
  final String? lastName;
  final String? mobileNumber;
  final String? firebaseIdToken;

  const ProfileUpdateRequest({
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.firebaseIdToken,
  });

  Map<String, dynamic> toJson() {
    final m = <String, dynamic>{};
    if (firstName != null) m['firstName'] = firstName;
    if (lastName != null) m['lastName'] = lastName;
    if (mobileNumber != null) m['mobileNumber'] = mobileNumber;
    if (firebaseIdToken != null) m['firebaseIdToken'] = firebaseIdToken;
    return m;
  }
}
