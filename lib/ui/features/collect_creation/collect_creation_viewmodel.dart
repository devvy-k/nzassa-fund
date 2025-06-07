import 'dart:io';

import 'package:get/get.dart';

class CollectCreationViewmodel extends GetxController {
  // Change File to String after testing
  final RxList<File> mediaFiles = <File>[].obs;
  final RxList<File> receipts = <File>[].obs;
}
