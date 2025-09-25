import 'dart:io';
import 'package:flutter/material.dart';
import '../db_helper.dart';
import '../models/issue.dart';

class IssuesPage extends StatefulWidget {
  const IssuesPage({super.key});

  @override
  State<IssuesPage> createState() => _IssuesPageState();
}

class _IssuesPageState extends State<IssuesPage> {
  List<Issue> _issues = [];

  @override
  void initState() {
    super.initState();
    _loadIssues();
  }

  Future<void> _loadIssues() async {
    final issues = await DBHelper.instance.getAllIssues();
    setState(() => _issues = issues);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reported Issues")),
      body: _issues.isEmpty
          ? const Center(child: Text("No issues reported yet"))
          : ListView.builder(
              itemCount: _issues.length,
              itemBuilder: (_, index) {
                final issue = _issues[index];
                final statusColor = issue.status == "Pending"
                    ? Colors.orange
                    : issue.status == "In Progress"
                        ? Colors.blue
                        : Colors.green;

                final imagePaths = issue.images.split(',');
                final firstImage = imagePaths.isNotEmpty ? File(imagePaths[0]) : null;

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: firstImage != null
                        ? Image.file(firstImage, width: 60, fit: BoxFit.cover)
                        : null,
                    title: Text("${issue.service} - ${issue.category}"),
                    subtitle: issue.description.isNotEmpty ? Text(issue.description) : null,
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        issue.status,
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
