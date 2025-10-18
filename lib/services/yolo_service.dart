import 'dart:convert';
import 'package:http/http.dart' as http;

/// Service untuk melakukan deteksi objek menggunakan model YOLOv8
/// melalui Hugging Face Inference API.
class YoloService {
  // URL API model di Hugging Face (bisa ganti ke YOLOv9, YOLOv7, dll)
  final String _apiUrl =
      "https://api-inference.huggingface.co/models/ultralytics/yolov8n";

  // Ganti token ini dengan milikmu dari https://huggingface.co/settings/tokens
  final String _apiKey = "hf_your_api_token_here";

  /// Mendeteksi objek dari gambar (dalam format base64)
  Future<List<Map<String, dynamic>>> detectObjects(String base64Image) async {
    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "inputs": base64Image,
      }),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      if (decoded is List && decoded.isNotEmpty && decoded[0]['boxes'] != null) {
        return List<Map<String, dynamic>>.from(decoded[0]['boxes']);
      } else {
        print("⚠️ Tidak ada objek terdeteksi.");
        return [];
      }
    } else {
      throw Exception(
          "YOLO detection failed: ${response.statusCode} - ${response.body}");
    }
  }
}
