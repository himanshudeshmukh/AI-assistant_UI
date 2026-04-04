// import 'package:flutter/material.dart';
// import 'package:profiler/presentation/screens/auth/login_screen.dart';
// import 'package:profiler/presentation/screens/splash_screen.dart';
// import 'config/theme/app_theme.dart';
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const WardrobeApp());
// }
//
// class WardrobeApp extends StatelessWidget {
//   const WardrobeApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: AppTheme.lightTheme,
//       // home: const MainNavigation(),
//       // home: PremiumSplash()
//       home: LoginScreen(),
//     );
//   }
//
//   // await AuthService.logout();
//   //
//   // Navigator.pushAndRemoveUntil(
//   // context,
//   // MaterialPageRoute(builder: (_) => const LoginScreen()),
//   // (route) => false,
//   // );
// }

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profiler/presentation/widgets/try_on_response.dart';

void main() {
  runApp(const TryOnDemoApp());
}

class TryOnDemoApp extends StatelessWidget {
  const TryOnDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FASHN VTON Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const TryOnDemoPage(),
    );
  }
}

class TryOnDemoPage extends StatefulWidget {
  const TryOnDemoPage({super.key});

  @override
  State<TryOnDemoPage> createState() => _TryOnDemoPageState();
}

class _TryOnDemoPageState extends State<TryOnDemoPage> {
  final ImagePicker _picker = ImagePicker();

  final TextEditingController _baseUrlController = TextEditingController(
    text: const String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'http://10.0.2.2:8000',
    ),
  );

  XFile? _personImage;
  XFile? _garmentImage;
  Size? _personSize;

  bool _loading = false;
  bool _useOverlay = true;

  String _category = 'tops';
  String _garmentPhotoType = 'flat-lay';

  TryOnResponse? _response;
  String? _error;

  String _cacheBust = '';

  @override
  void dispose() {
    _baseUrlController.dispose();
    super.dispose();
  }

  Future<void> _pickPersonImage() async {
    final file =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (file == null) return;

    final size = await _readImageSize(file);

    setState(() {
      _personImage = file;
      _personSize = size;
      _response = null;
      _error = null;
    });
  }

  Future<void> _pickGarmentImage() async {
    final file =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (file == null) return;

    setState(() {
      _garmentImage = file;
      _response = null;
      _error = null;
    });
  }

  Future<Size> _readImageSize(XFile file) async {
    final bytes = await file.readAsBytes();

    final image = await decodeImageFromList(bytes);

    return Size(
      image.width.toDouble(),
      image.height.toDouble(),
    );
  }

  Future<void> _runTryOn() async {
    if (_personImage == null || _garmentImage == null) {
      setState(() {
        _error = 'Please select both a person image and a garment image.';
      });
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
      _response = null;
    });

    try {
      final service = TryOnApiService(baseUrl: _baseUrlController.text.trim());

      final result = await service.createTryOn(
        personImage: _personImage!,
        garmentImage: _garmentImage!,
        category: _category,
        garmentPhotoType: _garmentPhotoType,
        returnOverlay: _useOverlay,
      );

      setState(() {
        _response = result;
        _cacheBust = DateTime.now().millisecondsSinceEpoch.toString();
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Widget _buildImageCard({
    required String title,
    required XFile? file,
    required VoidCallback onPressed,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            AspectRatio(
              aspectRatio: 3 / 4,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: file == null
                    ? const Center(child: Text('No image selected'))
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(file.path),
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 12),
            FilledButton.tonal(
              onPressed: onPressed,
              child: Text(file == null ? 'Choose image' : 'Change image'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTryOnPreview() {
    final personFile = _personImage;

    if (personFile == null) {
      return const Card(
        child: SizedBox(
          height: 420,
          child: Center(
            child: Text('Select a person image to preview the final fit.'),
          ),
        ),
      );
    }

    final aspectRatio = _personSize != null && _personSize!.height > 0
        ? _personSize!.width / _personSize!.height
        : 3 / 4;

    final overlayUrl = _response?.overlayResultUrl;
    final fullUrl = _response?.fullResultUrl;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rendered on the person image',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            AspectRatio(
              aspectRatio: aspectRatio,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.file(
                        File(personFile.path),
                        fit: BoxFit.contain,
                      ),
                      if (overlayUrl != null)
                        Image.network(
                          '$overlayUrl?v=$_cacheBust',
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                        )
                      else if (fullUrl != null)
                        Image.network(
                          '$fullUrl?v=$_cacheBust',
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                        ),
                      if (_loading)
                        const ColoredBox(
                          color: Color(0x88000000),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Use BoxFit.contain for both the base person image and the returned overlay/full result. '
              'Do not switch this preview to BoxFit.cover, because cover can crop differently and break alignment.',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FASHN VTON Flutter Demo'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _baseUrlController,
                decoration: const InputDecoration(
                  labelText: 'Python API base URL',
                  hintText: 'http://10.0.2.2:8000',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              /// BUTTON
              FilledButton.icon(
                onPressed: _loading ? null : _runTryOn,
                icon: const Icon(Icons.auto_awesome),
                label: Text(_loading ? 'Rendering...' : 'Run virtual try-on'),
              ),

              if (_error != null) ...[
                const SizedBox(height: 12),
                Text(
                  _error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
