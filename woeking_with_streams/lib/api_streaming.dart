import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiPolling {
  final StreamController<Map<String, dynamic>> _controller =
      StreamController<Map<String, dynamic>>();

  ApiPolling() {
    // Periodically fetch data from the API every 5 seconds
    Stream.periodic(Duration(seconds: 5))
    Stream.periodic(Duration(seconds: 1))
        .asyncMap((_) => fetchDataFromApi())
        .listen((data) {
      _controller.add(data);
    });
  }

  // Method to fetch data from the API
  Future<Map<String, dynamic>> fetchDataFromApi() async {
    final response = await http.get(Uri.parse('https://randomuser.me/api/'));

    if (response.statusCode == 200) {
      // Decode the JSON data
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Expose the stream
  Stream<Map<String, dynamic>> get dataStream => _controller.stream;

  // Dispose method to close the stream controller
  void dispose() {
    _controller.close();
  }
}
