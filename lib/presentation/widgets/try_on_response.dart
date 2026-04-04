import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class TryOnResponse {
  final String requestId;
  final String fullResultUrl;
  final String? overlayResultUrl;
  final double personWidth;
  final double personHeight;
  final String recommendedBoxFit;

  const TryOnResponse({
    required this.requestId,
    required this.fullResultUrl,
    required this.overlayResultUrl,
    required this.personWidth,
    required this.personHeight,
    required this.recommendedBoxFit,
  });

  double get aspectRatio => personWidth / personHeight;

  factory TryOnResponse.fromJson(Map<String, dynamic> json) {
    final sizes = json['sizes'] as Map<String, dynamic>;

    final personOriginal = sizes['person_original'] as Map<String, dynamic>;
    final display = json['display'] as Map<String, dynamic>;

    return TryOnResponse(
      requestId: json['request_id'] as String,
      fullResultUrl: json['full_result_url'] as String,
      overlayResultUrl: json['overlay_result_url'] as String?,
      personWidth: (personOriginal['width'] as num).toDouble(),
      personHeight: (personOriginal['height'] as num).toDouble(),
      recommendedBoxFit: display['recommended_box_fit'] as String? ?? 'contain',
    );
  }
}

class TryOnApiService {
  TryOnApiService({required this.baseUrl})
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(minutes: 10),
            sendTimeout: const Duration(minutes: 10),
          ),
        );
  final String baseUrl;
  final Dio _dio;

  Future<TryOnResponse> createTryOn({
    required XFile personImage,
    required XFile garmentImage,
    required String category,
    String garmentPhotoType = 'flat-lay',
    bool segmentationFree = true,
    int numTimesteps = 30,
    double guidanceScale = 1.5,
    int seed = 42,
    bool returnOverlay = true,
  }) async {
    final formData = FormData.fromMap({
      'person_image': await MultipartFile.fromFile(
        personImage.path,
        filename: personImage.name,
      ),
      'garment_image': await MultipartFile.fromFile(
        garmentImage.path,
        filename: garmentImage.name,
      ),
      'category': category,
      'garment_photo_type': garmentPhotoType,
      'segmentation_free': segmentationFree.toString(),
      'num_timesteps': numTimesteps.toString(),
      'guidance_scale': guidanceScale.toString(),
      'seed': seed.toString(),
      'return_overlay': returnOverlay.toString(),
    });
    final response = await _dio.post<Map<String, dynamic>>(
      'api/v1/try-on',
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
    final data = response.data;
    if (data == null) {
      throw Exception('Empty response from try-on API');
    }
    return TryOnResponse.fromJson(data);
  }
}
