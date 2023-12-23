import 'package:http/http.dart' as http;

abstract class ClientHttp{
  Future<dynamic> get(String url, Map<String, String> headers);
  Future<dynamic> post(String url, Map<String, String> headers, dynamic body);
}

class HttpService implements ClientHttp{

  final http.Client client;

  HttpService(this.client);

  @override
  Future<dynamic> get(String url, Map<String, String> headers) async {
    final response = await client.get(Uri.parse(url), headers: headers);
    return response;
  }
  
  @override
  Future<dynamic> post(String url, Map<String, String> headers, dynamic body) async {
    final response = await client.post(Uri.parse(url), headers: headers, body: body);
    return response;
  }
}