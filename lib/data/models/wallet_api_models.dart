/// DTOs for `/api/v1/wallets/...` (Spring Boot + Razorpay intent payloads).
library;

enum WalletTransactionType { credit, debit, refund, adjust }

enum WalletTransactionStatus { pending, success, failed }

WalletTransactionType _parseType(String? raw) {
  switch ((raw ?? '').toUpperCase()) {
    case 'CREDIT':
      return WalletTransactionType.credit;
    case 'DEBIT':
      return WalletTransactionType.debit;
    case 'REFUND':
      return WalletTransactionType.refund;
    case 'ADJUST':
      return WalletTransactionType.adjust;
    default:
      return WalletTransactionType.adjust;
  }
}

WalletTransactionStatus _parseStatus(String? raw) {
  switch ((raw ?? '').toUpperCase()) {
    case 'PENDING':
      return WalletTransactionStatus.pending;
    case 'SUCCESS':
      return WalletTransactionStatus.success;
    case 'FAILED':
      return WalletTransactionStatus.failed;
    default:
      return WalletTransactionStatus.pending;
  }
}

class WalletTransaction {
  final String id;
  final String walletId;
  final WalletTransactionType type;
  final int amount;
  final String? currency;
  final WalletTransactionStatus status;
  final String? reason;
  final String? externalRef;
  final dynamic metadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const WalletTransaction({
    required this.id,
    required this.walletId,
    required this.type,
    required this.amount,
    this.currency,
    required this.status,
    this.reason,
    this.externalRef,
    this.metadata,
    this.createdAt,
    this.updatedAt,
  });

  factory WalletTransaction.fromJson(Map<String, dynamic> json) {
    DateTime? parseDt(dynamic v) {
      if (v is String) return DateTime.tryParse(v);
      return null;
    }

    return WalletTransaction(
      id: '${json['id']}',
      walletId: '${json['walletId']}',
      type: _parseType(json['type'] as String?),
      amount: (json['amount'] as num?)?.toInt() ?? 0,
      currency: json['currency'] as String?,
      status: _parseStatus(json['status'] as String?),
      reason: json['reason'] as String?,
      externalRef: json['externalRef'] as String?,
      metadata: json['metadata'],
      createdAt: parseDt(json['createdAt']),
      updatedAt: parseDt(json['updatedAt']),
    );
  }
}

/// Razorpay checkout fields from top-up / subscription intent.
class RazorpayIntentData {
  final String orderId;
  final int amount;
  final String currency;
  final String key;
  final String? purpose;

  const RazorpayIntentData({
    required this.orderId,
    required this.amount,
    required this.currency,
    required this.key,
    this.purpose,
  });

  factory RazorpayIntentData.fromJson(Map<String, dynamic> json) {
    return RazorpayIntentData(
      orderId: json['orderId'] as String? ?? '',
      amount: (json['amount'] as num?)?.toInt() ?? 0,
      currency: json['currency'] as String? ?? 'INR',
      key: json['key'] as String? ?? '',
      purpose: json['purpose'] as String?,
    );
  }
}
