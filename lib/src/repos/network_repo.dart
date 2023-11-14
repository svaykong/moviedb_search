import 'package:http/http.dart' as http;

import '../utils/logger.dart';
import '../utils/constants.dart';

class NetworkRepo {
  // default constructor
  // NetworkRepo();

  // private or anonymous constructor
  NetworkRepo._() {
    _client = http.Client();
  }

  final _name = 'Network Repo';

  static final NetworkRepo instance = NetworkRepo._();

  late final http.Client _client;

  Future<http.Response> get({required String url, String params = ''}) async {
    try {
      var uri = '$BASE_URL$url';
      if (params.isNotEmpty) {
        uri += '?$params';
      }
      'uri: ${uri.toString()}'.log();

      var response = await _client.get(Uri.parse(uri));
      return response;
    } on Exception catch (e) {
      '$_name get request exception: $e'.log();
      return Future.error('Failed');
    } finally {
      '$_name get request finally'.log();
    }
  }
}
