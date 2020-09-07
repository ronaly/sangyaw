import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sangyaw_app/model/person.dart';
import 'package:sangyaw_app/utils/spinner.dart';
import 'package:path_provider/path_provider.dart';

import 'package:path/path.dart' as p;


const GOOGLE_DRIVE_SHOW_IMAGE_PATH = 'https://drive.google.com/uc?export=view&id=';

class PersonPhotoView extends StatelessWidget {
  Person person;
  bool useSmall;
  PersonPhotoView(this.person, this.useSmall);
  @override
  Widget build(BuildContext context) {


    if (person.tempImageFile != null) {
      if(person.tempImageUploading) {
        return getAppSpinner();
      }
      return PhotoView(
        imageProvider: new FileImage(person.tempImageFile),
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.contained * 5.8,
        basePosition: Alignment.center,
      );
    }

    if(person.profileImage != null && person.profileImage.length > 0) {
      String url = '${GOOGLE_DRIVE_SHOW_IMAGE_PATH}${person.profileImage}';
      return CachedPersonPhotoView(url, this.useSmall);
    }

    return PhotoView(
      imageProvider: AssetImage('assets/images/notyetuploaded.png'),
      minScale: PhotoViewComputedScale.contained * 0.8,
      maxScale: PhotoViewComputedScale.contained * 5.8,
      basePosition: Alignment.center,
    );


  }
}


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


class CachedPersonPhotoView extends StatefulWidget {
  String url;
  bool useSmall;
  CachedPersonPhotoView(this.url, this.useSmall);
  @override
  _CachedPersonPhotoViewState createState() => _CachedPersonPhotoViewState(this.url, this.useSmall);
}

class _CachedPersonPhotoViewState extends State<CachedPersonPhotoView> {
  Stream<FileResponse> fileStream;
  String url;
  bool useSmall;
  _CachedPersonPhotoViewState(this.url, this.useSmall);

  @override
  void initState() {
    setState(() {
      this.fileStream = null;
      _downloadFile();
    });
  }

  void _downloadFile() {
    setState(() {
      print('Loading URL: $url');
      fileStream = SangyawAppCacheManager().getFileStream(url, withProgress: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (fileStream == null) {
      return Fab(
        downloadFile: _downloadFile,
      );
    }
    return DownloadPage(
      fileStream: fileStream,
      downloadFile: _downloadFile,
      clearCache: _clearCache,
      useSmall: this.useSmall,
    );
  }

  void _clearCache() {
    SangyawAppCacheManager().emptyCache();
    setState(() {
      fileStream = null;
    });
  }
}

class DownloadPage extends StatelessWidget {
  final Stream<FileResponse> fileStream;
  final VoidCallback downloadFile;
  final VoidCallback clearCache;
  final bool useSmall;
  const DownloadPage(
      {Key key, this.fileStream, this.downloadFile, this.clearCache, this.useSmall})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FileResponse>(
      stream: fileStream,
      builder: (context, snapshot) {
        Widget body;

        var loading = !snapshot.hasData || snapshot.data is DownloadProgress;

        if (snapshot.hasError) {
          body = DownloadErrorPage(
            downloadFile: this.downloadFile,
            error: snapshot.error.toString(),
            useSmall: this.useSmall,
            fileInfo: snapshot.data as FileInfo,
            clearCache: clearCache,
          ); // Text(snapshot.error.toString());
        } else if (loading) {
          body = this.useSmall ? getAppSmallSpinner() : getAppSpinner();
        } else {
          body = FileInfoWidget(
            fileInfo: snapshot.data as FileInfo,
            clearCache: clearCache,
          );
        }

        return body;
      },
    );
  }
}

class Fab extends StatelessWidget {
  final VoidCallback downloadFile;
  const Fab({Key key, this.downloadFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return FloatingActionButton(
      heroTag: null,
      onPressed: downloadFile,
      tooltip: 'Download again!',
      child: Icon(Icons.refresh),
    );
  }
}


class DownloadErrorPage extends StatelessWidget {
  final VoidCallback downloadFile;
  final String error;
  final bool useSmall;
  final FileInfo fileInfo;
  final VoidCallback clearCache;
  const DownloadErrorPage({Key key, this.downloadFile, this.error, this.useSmall, this.clearCache, this.fileInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if(this.fileInfo != null) {
      Widget info = ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Original URL'),
            subtitle: Text(fileInfo.originalUrl),
          ),
          if (fileInfo.file != null)
            ListTile(
              title: const Text('Local file path'),
              subtitle: Text(fileInfo.file.path),
            ),
          ListTile(
            title: const Text('Loaded from'),
            subtitle: Text(fileInfo.source.toString()),
          ),
          ListTile(
            title: const Text('Valid Until'),
            subtitle: Text(fileInfo.validTill.toIso8601String()),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: RaisedButton(
              child: const Text('CLEAR CACHE'),
              onPressed: clearCache,
            ),
          ),
        ],
      );

    }


    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            heroTag: null,
            onPressed: downloadFile,
            tooltip: 'Download',
            child: Icon(Icons.cloud_download),
          ),
          if(!this.useSmall)
            Text('\nImage Download Error, \n try downloading again.'),
        ],
      ),
    );

//    return FloatingActionButton(
//      heroTag: null,
//      onPressed: downloadFile,
//      tooltip: 'Download',
//      child: Icon(Icons.cloud_download),
//    );
  }
}

class ProgressIndicator extends StatelessWidget {
  final DownloadProgress progress;
  const ProgressIndicator({Key key, this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 50.0,
            height: 50.0,
            child: CircularProgressIndicator(
              value: progress?.progress,
            ),
          ),
          const SizedBox(width: 20.0),
          const Text('Downloading'),
        ],
      ),
    );
  }
}

class FileInfoWidget extends StatelessWidget {
  final FileInfo fileInfo;
  final VoidCallback clearCache;

  const FileInfoWidget({Key key, this.fileInfo, this.clearCache})
      : super(key: key);
  @override
  Widget build(BuildContext context) {

    if (fileInfo.file != null) {

      return PhotoView(
        imageProvider: FileImage(new File(fileInfo.file.path)),
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.contained * 5.8,
        basePosition: Alignment.center,
      );

    }
//

  }
}