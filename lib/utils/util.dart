class Utils {
  static DateTime getStartOfWeek({DateTime? dateTime}) {
    final now = dateTime ?? DateTime.now();
    return now.subtract(Duration(days: now.weekday - 1));
  }

  static DateTime getEndOfWeek({DateTime? dateTime}) {
    final now = dateTime ?? DateTime.now();
    return now.add(Duration(days: 7 - now.weekday));
  }

  // static Future<Uint8List?> getVideoThumbnailByFile(File file) async {
  //   return VideoCompress.getByteThumbnail(file.path, quality: 75);
  //   // return VideoThumbnail.thumbnailData(video: file.path, quality: 75);
  // }

  // static Future<Uint8List?> getVideoThumbnailByPath(String path) async {
  //   return VideoCompress.getByteThumbnail(path, quality: 75);
  //   // return VideoThumbnail.thumbnailData(video: path, quality: 75);
  // }

  // static Future<File?> compressVideo(String path) async {
  //   try {
  //     final result = await VideoCompress.compressVideo(path);
  //     return result?.file;
  //   } catch (e) {
  //     print(e);
  //     rethrow;
  //   }
  // }
}
