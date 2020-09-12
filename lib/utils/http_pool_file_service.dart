import 'flutter_cache_manager/src/web/file_service.dart';

import 'package:pool/pool.dart';

import 'package:http/http.dart' as http;

class HttpPoolFileService extends FileService {
  final pool = new Pool(3, timeout: new Duration(minutes: 30));
  HttpPoolFileService({http.Client httpClient}) {}

  @override
  Future<FileServiceResponse> get(String url,
      {Map<String, String> headers = const {}}) {
    return pool.withResource(() => http.Client()).then((client) {
      final req = http.Request('GET', Uri.parse(url));
      req.headers.addAll(headers);
      return client.send(req).then((httpResponse) {
        print('HttpPoolFileService >>> get URL: $url');
        return HttpGetResponse(httpResponse);
      });
    });
  }
  // Future<FileServiceResponse> get(String url,
  //     {Map<String, String> headers = const {}}) async {
  //   final req = http.Request('GET', Uri.parse(url));
  //   req.headers.addAll(headers);
  //   final httpResponse = await _httpClient.send(req);

  //   return HttpGetResponse(httpResponse);
  // }
}
