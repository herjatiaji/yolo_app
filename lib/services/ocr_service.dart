import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

/// Service untuk membaca teks dari gambar menggunakan Google ML Kit OCR.
class OcrService {
  final _textRecognizer = TextRecognizer();

  /// Mengekstrak teks dari file gambar
  Future<String> extractText(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final RecognizedText recognizedText =
        await _textRecognizer.processImage(inputImage);

    return recognizedText.text;
  }

  /// Membersihkan resource
  void dispose() {
    _textRecognizer.close();
  }
}
