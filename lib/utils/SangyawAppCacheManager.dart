
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'flutter_cache_manager/src/cache_manager.dart';

class SangyawAppCacheManager extends BaseCacheManager {
  static const key = "SangyawAppCacheFiles";

  static SangyawAppCacheManager _instance;

  factory SangyawAppCacheManager() {
    if (_instance == null) {
      _instance = new SangyawAppCacheManager._();
    }
    return _instance;
  }

  SangyawAppCacheManager._() : super(key,
      
      maxAgeCacheObject: Duration(days: 30),
      maxNrOfCacheObjects: 20);

  Future<String> getFilePath() async {
    var directory = await getTemporaryDirectory();
    return p.join(directory.path, key);
  }
}
