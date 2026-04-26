/// Helpers for Spring `ApiResponse<T>` envelopes.
library;

/// Extracts `data` when [success] is true; otherwise returns null.
Map<String, String>? validationFieldErrorsFromData(
  dynamic data,
  int statusCode,
) {
  if (statusCode != 400 || data is! Map) return null;
  final out = <String, String>{};
  for (final entry in data.entries) {
    final v = entry.value;
    if (v is String) {
      out[entry.key.toString()] = v;
    }
  }
  return out.isEmpty ? null : out;
}
