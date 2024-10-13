import 'dart:math';

String formatFileSize(int sizeInBytes) {
  const units = ['B', 'KB', 'MB', 'GB'];
  if (sizeInBytes == 0) return '0 B';

  final i = (log(sizeInBytes) / log(1024)).floor();
  return '${(sizeInBytes / pow(1024, i)).toStringAsFixed(0)} ${units[i]}';
}