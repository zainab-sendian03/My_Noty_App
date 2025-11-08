import 'package:firebase_test/features/note/domain/usecases/add_note.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:image_picker/image_picker.dart';

class AddNoteController extends GetxController {
  RxBool isLoading = false.obs;
  late final AddNote _addNote;
  final ImagePicker _picker = ImagePicker();
  final RxString imageUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _addNote = Get.find<AddNote>();
  }

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 50);
      if (image != null) {
        imageUrl.value = image.path;
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to pick image: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> addNote(String title, String content, String imageUrl) async {
    if (title.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Title cannot be empty",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (content.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Content cannot be empty",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    try {
      isLoading.value = true;
      await _addNote(title, content, imageUrl);
      Get.back();
      Get.snackbar(
        "Success",
        "Note added successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void clearImage() {
    imageUrl.value = '';
  }
}
