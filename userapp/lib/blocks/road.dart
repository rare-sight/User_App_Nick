import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RoadPage extends StatefulWidget {
  const RoadPage({super.key});

  @override
  State<RoadPage> createState() => _RoadPageState();
}

class _RoadPageState extends State<RoadPage> {
  final picker = ImagePicker();
  final List<File> _images = [];
  final TextEditingController _descriptionController = TextEditingController();

  // Dropdown categories
  final List<String> _categories = ["Potholes", "Wrong Parking", "Clogged Road"];
  String? _selectedCategory;

  // pick image from camera 
  Future<void> _pickImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  
  void _upload() {
    if (_images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please add at least one image")),
      );
      return;
    }
    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a category")),
      );
      return;
    }

    String description = _descriptionController.text;

    print("Uploading...");
    print("Category: $_selectedCategory");
    print("Description: $description");
    print("Images: ${_images.map((e) => e.path).toList()}");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Upload successful!")),
    );

    // Clear after upload
    setState(() {
      _images.clear();
      _descriptionController.clear();
      _selectedCategory = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Road & Transport")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Show row of images
            SizedBox(
              height: 120,
              child: _images.isNotEmpty
                  ? ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _images.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                _images[index],
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _images.removeAt(index);
                                  });
                                },
                                child: const CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.red,
                                  child: Icon(Icons.close, size: 16, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  : Container(
                      height: 120,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: const Center(child: Text("No images selected")),
                    ),
            ),
            const SizedBox(height: 20),

            // Camera button
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 20, 164, 61),
                  ),
                  onPressed: _pickImageFromCamera,
                  icon: const Icon(Icons.camera_alt, color: Colors.white),
                  label: const Text("Add Image", style: TextStyle(color: Color.fromARGB(255, 249, 248, 248), fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            const SizedBox(height: 25),

            // Dropdown menu
            DropdownButtonFormField<String>(
              initialValue: _selectedCategory,
              items: _categories
                  .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
              decoration: const InputDecoration(
                labelText: "Select Category",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            // Description
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Description (optional)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            // Upload button
            Center(
              child: ElevatedButton(
                onPressed: _upload,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 20, 164, 61),
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                ),
                child: const Text("Upload", style: TextStyle(fontSize: 22, color: Color.fromARGB(255, 252, 250, 250), fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
