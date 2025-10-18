import 'package:flutter_tts/flutter_tts.dart';

/// Service untuk Text-to-Speech (membacakan teks hasil analisis)
class TtsService {
  final FlutterTts _tts = FlutterTts();

  /// Membacakan teks dengan suara Bahasa Indonesia
  Future<void> speak(String text) async {
    await _tts.setLanguage("id-ID");
    await _tts.setSpeechRate(0.9); // kecepatan bicara
    await _tts.setPitch(1.0); // nada
    await _tts.speak(text);
  }

  /// Hentikan suara
  Future<void> stop() async {
    await _tts.stop();
  }
}
