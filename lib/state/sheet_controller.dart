import 'package:flutter/foundation.dart';

/// Global assist / capture bottom sheets (center orb flow).
class SheetController extends ChangeNotifier {
  bool orbSheetOpen = false;
  bool captureSheetOpen = false;

  void openOrbSheet() {
    orbSheetOpen = true;
    notifyListeners();
  }

  void closeOrbSheet() {
    orbSheetOpen = false;
    notifyListeners();
  }

  void openCaptureSheet() {
    captureSheetOpen = true;
    notifyListeners();
  }

  void closeCaptureSheet() {
    captureSheetOpen = false;
    notifyListeners();
  }
}
