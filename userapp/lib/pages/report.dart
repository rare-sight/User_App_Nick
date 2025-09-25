import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/issue.dart';
import '../db_helper.dart';

class ReportPage extends StatefulWidget {
  final String serviceTitle;
  final List<String> categories;

  const ReportPage({super.key, required this.serviceTitle, required this.categories});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _descriptionController = TextEditingController();
  List<File> _images = [];
  String? _selectedCategory;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() => _images.add(File(pickedFile.path)));
    }
  }

  Future<void> _saveIssue() async {
    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a category")),
      );
      return;
    }
    if (_images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please add at least one image")),
      );
      return;
    }

    final issue = Issue(
      service: widget.serviceTitle,
      category: _selectedCategory!,
      description: _descriptionController.text,
      images: _images.map((e) => e.path).join(','), // comma-separated
      status: "Pending",
    );

    await DBHelper.instance.insertIssue(issue);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Issue reported successfully!")),
    );

    setState(() {
      _images.clear();
      _descriptionController.clear();
      _selectedCategory = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.serviceTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 120,
              child: _images.isEmpty
                  ? Center(child: Text("No images selected"))
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _images.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (_, index) => Stack(
                        children: [
                          Image.file(_images[index], height: 120, width: 120, fit: BoxFit.cover),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: GestureDetector(
                              onTap: () => setState(() => _images.removeAt(index)),
                              child: const CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.red,
                                child: Icon(Icons.close, size: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              hint: const Text("Select category"),
              items: widget.categories
                  .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                  .toList(),
              onChanged: (val) => setState(() => _selectedCategory = val),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Description",
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text("Add Image"),
                ),
                ElevatedButton.icon(
                  onPressed: _saveIssue,
                  icon: const Icon(Icons.save),
                  label: const Text("Report Issue"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
