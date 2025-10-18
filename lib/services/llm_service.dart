import 'dart:convert';
import 'package:http/http.dart' as http;

/// Service untuk menghasilkan deskripsi kontekstual dari hasil deteksi objek + OCR.
class LlmService {
  // API key dari Hugging Face (https://huggingface.co/settings/tokens)
  final String _apiKey = "hf_your_api_token_here";

  // Model LLM yang digunakan (bisa ganti ke LLaMA 3, Falcon, dll)
  final String _modelUrl =
      "https://api-inference.huggingface.co/models/mistralai/Mistral-7B-Instruct";

  /// Menghasilkan deskripsi dari daftar objek & teks
  Future<String> generateDescription(List<String> objects, String text) async {
    final prompt =
        "Detected objects: ${objects.join(', ')}. Detected text: '$text'. "
        "Describe this scene in Bahasa Indonesia in a friendly and natural tone.";

    final response = await http.post(
      Uri.parse(_modelUrl),
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"inputs": prompt}),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      if (decoded is List && decoded.isNotEmpty) {
        return decoded[0]["generated_text"] ?? "Tidak ada deskripsi.";
      } else if (decoded["generated_text"] != null) {
        return decoded["generated_text"];
      } else {
        return "Deskripsi tidak ditemukan.";
      }
    } else {
      throw Exception(
          "LLM API failed: ${response.statusCode} - ${response.body}");
    }
  }
}
