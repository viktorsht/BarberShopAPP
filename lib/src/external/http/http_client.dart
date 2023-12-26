abstract class ClientHttp{
  Future<dynamic> get(String url, Map<String, String> headers);
  Future<dynamic> post(String url, Map<String, String> headers, Map<String, dynamic> body);
  Future<dynamic> update(String url, Map<String, String> headers, Map<String, dynamic> body);
}