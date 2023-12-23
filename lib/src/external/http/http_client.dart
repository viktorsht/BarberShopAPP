import 'package:http/http.dart' as http;

abstract class ClientHttp{
  Future<dynamic> get(String url, Map<String, String> headers);
}

class HttpService implements ClientHttp{

  final http.Client client;

  HttpService(this.client);

  @override
  Future<dynamic> get(String url, Map<String, String> headers) async {
    final response = await client.get(Uri.parse(url), headers: headers);
    return response;
  }
}