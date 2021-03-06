import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sangyaw_app/model/person.dart';
import 'package:sangyaw_app/utils/SangyawAppCacheManager.dart';
import 'package:sangyaw_app/utils/flutter_cache_manager/flutter_cache_manager.dart';
import 'package:sangyaw_app/utils/spinner.dart';
import 'package:url_launcher/url_launcher.dart';

const GOOGLE_DRIVE_SHOW_IMAGE_PATH =
    'https://drive.google.com/uc?export=view&id=';

// ignore: must_be_immutable
class PersonPhotoView extends StatelessWidget {
  Person person;
  bool useSmall;
  PersonPhotoView(this.person, this.useSmall);
  @override
  Widget build(BuildContext context) {
    if (person.tempImageFile != null) {
      if (person.tempImageUploading) {
        return getAppSpinner();
      }
      return PhotoView(
        imageProvider: new FileImage(person.tempImageFile),
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.contained * 5.8,
        basePosition: Alignment.center,
      );
    }

    if (person.profileImage != null && person.profileImage.length > 0) {
      String url = '$GOOGLE_DRIVE_SHOW_IMAGE_PATH${person.profileImage}';
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

// ignore: must_be_immutable
class CachedPersonPhotoView extends StatefulWidget {
  String url;
  bool useSmall;
  CachedPersonPhotoView(this.url, this.useSmall);
  @override
  _CachedPersonPhotoViewState createState() =>
      _CachedPersonPhotoViewState(this.url, this.useSmall);
}

class _CachedPersonPhotoViewState extends State<CachedPersonPhotoView> {
  Stream<FileResponse> fileStream;
  String url;
  bool useSmall;
  _CachedPersonPhotoViewState(this.url, this.useSmall);

  @override
  void initState() {
    super.initState();
    setState(() {
      this.fileStream = null;
      _downloadFile();
    });
  }

  void _downloadFile() {
    setState(() {
      print('Loading URL: $url');
      fileStream =
          SangyawAppCacheManager().getFileStream(url, withProgress: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (fileStream == null) {
      return PhotoCacheDownload(
        downloadFile: _downloadFile,
      );
    }
    return DownloadPage(
      url: url,
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
  final String url;
  const DownloadPage(
      {Key key,
      this.fileStream,
      this.downloadFile,
      this.clearCache,
      this.url,
      this.useSmall})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FileResponse>(
      stream: fileStream,
      builder: (context, snapshot) {
        Widget body;

        var loading = !snapshot.hasData || snapshot.data is DownloadProgress;

        if (snapshot.hasError) {
          body = PhotoCacheDownloadError(
            url: url,
            downloadFile: this.downloadFile,
            error: snapshot.error.toString(),
            useSmall: this.useSmall,
            fileInfo: snapshot.data as FileInfo,
            clearCache: clearCache,
          ); // Text(snapshot.error.toString());
        } else if (loading) {
//          body = this.useSmall ? getAppSmallSpinner() : getAppSpinner();
          body = CachedPhotoDownloadProgressIndicator(
            progress: snapshot.data as DownloadProgress,
            useSmall: this.useSmall,
          );
        } else {
          body = CachedPhotoView(
            fileInfo: snapshot.data as FileInfo,
            clearCache: clearCache,
          );
        }

        return body;
      },
    );
  }
}

class PhotoCacheDownload extends StatelessWidget {
  final VoidCallback downloadFile;
  const PhotoCacheDownload({Key key, this.downloadFile}) : super(key: key);

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

class PhotoCacheDownloadError extends StatelessWidget {
  final String url;
  final VoidCallback downloadFile;
  final String error;
  final bool useSmall;
  final FileInfo fileInfo;
  final VoidCallback clearCache;
  const PhotoCacheDownloadError(
      {Key key,
      this.url,
      this.downloadFile,
      this.error,
      this.useSmall,
      this.clearCache,
      this.fileInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
//    if(this.fileInfo != null) {
//      Widget info = ListView(
//        children: <Widget>[
//          ListTile(
//            title: const Text('Original URL'),
//            subtitle: Text(fileInfo.originalUrl),
//          ),
//          if (fileInfo.file != null)
//            ListTile(
//              title: const Text('Local file path'),
//              subtitle: Text(fileInfo.file.path),
//            ),
//          ListTile(
//            title: const Text('Loaded from'),
//            subtitle: Text(fileInfo.source.toString()),
//          ),
//          ListTile(
//            title: const Text('Valid Until'),
//            subtitle: Text(fileInfo.validTill.toIso8601String()),
//          ),
//          Padding(
//            padding: const EdgeInsets.all(10.0),
//            child: RaisedButton(
//              child: const Text('CLEAR CACHE'),
//              onPressed: clearCache,
//            ),
//          ),
//        ],
//      );
//
//    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (!this.useSmall)
            FloatingActionButton(
              heroTag: null,
              onPressed: downloadFile,
              tooltip: 'Download',
              child: Icon(Icons.cloud_download),
            ),
          if (!this.useSmall)
            Text('\nImage Download Error, \n try downloading again.\n'),
          PhotoView(imageProvider: NetworkImage(this.url)),
          Center(
            child: RaisedButton(
              onPressed: launchURL,
              child: Text('Open in Browser'),
            ),
          ),
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

  launchURL() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class CachedPhotoDownloadProgressIndicator extends StatelessWidget {
  final DownloadProgress progress;
  final bool useSmall;
  const CachedPhotoDownloadProgressIndicator(
      {Key key, this.progress, this.useSmall})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: this.useSmall ? 10.0 : 50.0,
            height: this.useSmall ? 10.0 : 50.0,
            child: CircularProgressIndicator(
              value: progress?.progress,
            ),
          ),
          if (!this.useSmall) const SizedBox(width: 20.0),
          if (!this.useSmall) const Text('Downloading'),
        ],
      ),
    );
  }
}

class CachedPhotoView extends StatelessWidget {
  final FileInfo fileInfo;
  final VoidCallback clearCache;

  const CachedPhotoView({Key key, this.fileInfo, this.clearCache})
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
    } else {
      return Container();
    }
//
  }
}
