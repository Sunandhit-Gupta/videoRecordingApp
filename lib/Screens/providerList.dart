
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

bool changed = false;

class listProvider extends ChangeNotifier {
  List<String> videoPaths = [];

    Future<List<String>> searchForVideos() async {
    try {
      final Directory? appDocDir = await getDownloadsDirectory();
      await _searchDirectoryForVideos(appDocDir!, videoPaths);
    } catch (e) {
      print('Error searching for videos: $e');
    }
    
    notifyListeners();
    return videoPaths;
  }

   Future<void> _searchDirectoryForVideos(Directory directory, List<String> videoPaths) async {
    try {
      final List<FileSystemEntity> entities = directory.listSync();

      for (FileSystemEntity entity in entities) {
        if (entity is File && _isVideoFile(entity.path) && !videoPaths.contains(entity.path)) {
          videoPaths.add(entity.path);
          notifyListeners();
        } else if (entity is Directory) {
          await _searchDirectoryForVideos(entity, videoPaths);
        }
      }
    } catch (e) {
      print('Error searching directory: $e');
    }
  }

   bool _isVideoFile(String filePath) {
    final String extension = filePath.split('.').last.toLowerCase();
    return extension == 'mp4' || extension == 'mov' || extension == 'avi' || extension == 'mkv' || extension == 'wmv';
  }

}