import 'package:firebase_test/core/constants/customTextForm.dart';
import 'package:firebase_test/features/note/presentation/controllers/add_note_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final addNoteController = Get.put(AddNoteController());
  String? imageUrl;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Note",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 235, 142, 2),
      ),
      body: Container(
        color: const Color.fromARGB(255, 253, 246, 236),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormField(
                hintText: "Title",
                controller: titleController,
                min: 1,
                max: 100,
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  controller: contentController,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    hintText: "Write your note here...",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    contentPadding: EdgeInsets.all(16),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  children: [
                    if (imageUrl != null)
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(imageUrl!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.close,
                                    color: Colors.white),
                                onPressed: () {
                                  setState(() {
                                    imageUrl = null;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    InkWell(
                      onTap: () async {
                        await addNoteController.pickImage();
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: imageUrl == null
                              ? Colors.grey.shade50
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.only(
                            bottomLeft: const Radius.circular(12),
                            bottomRight: const Radius.circular(12),
                            topLeft: imageUrl == null
                                ? const Radius.circular(12)
                                : Radius.zero,
                            topRight: imageUrl == null
                                ? const Radius.circular(12)
                                : Radius.zero,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              imageUrl == null
                                  ? Icons.add_photo_alternate
                                  : Icons.edit,
                              color: const Color.fromARGB(255, 235, 142, 2),
                              size: 32,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              imageUrl == null ? "Add Image" : "Change Image",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 235, 142, 2),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          await addNoteController.addNote(
                              titleController.text,
                              contentController.text,
                              addNoteController.imageUrl.value);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 235, 142, 2),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Color.fromARGB(255, 223, 6, 6))
                      : const Text(
                          "Save Note",
                          style: TextStyle(fontSize: 16),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
