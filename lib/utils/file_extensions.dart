import 'dart:io';

class FileUtils {

  // required Image extensions
  static bool isrequiredImageExtension(File image) =>
      image.path.endsWith('.jpg') ||
      image.path.endsWith('.png') ||
      image.path.endsWith('.jpeg');
  // required video extension
  static bool isrequiredVideoExtension(File video) =>
      video.path.endsWith('.mp4');
}