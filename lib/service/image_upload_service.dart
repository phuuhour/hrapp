import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ImageUploadService {
  //GitHub repository details
  static const String repoOwner = 'phuuhour';
  static const String repoName = 'flutter_images';
  static const String token = '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';

  static Future<String?> uploadImage(File imageFile) async {
    try {
      // Check if the file is a valid image
      final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.png';
      final bytes = await imageFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      // First verify repository exists
      final repoUrl = Uri.parse(
        'https://api.github.com/repos/$repoOwner/$repoName',
      );
      // Make a GET request to check if the repository is accessible
      final repoResponse = await http.get(
        repoUrl,
        headers: {
          'Authorization': 'token $token',
          'Accept': 'application/vnd.github.v3+json',
        },
      );

      if (repoResponse.statusCode != 200) {
        throw Exception('Repository not found or inaccessible');
      }

      // Upload image to github
      final uploadUrl = Uri.parse(
        'https://api.github.com/repos/$repoOwner/$repoName/contents/$fileName',
      );

      // Prepare the request body
      final response = await http.put(
        uploadUrl,
        headers: {
          'Authorization': 'token $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'message': 'Upload profile image',
          'content': base64Image,
        }),
      );

      if (response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse['content']['download_url']
            ?.replaceFirst('github.com', 'raw.githubusercontent.com')
            ?.replaceFirst('/blob/', '/');
      } else {
        throw Exception(
          'Upload failed: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
