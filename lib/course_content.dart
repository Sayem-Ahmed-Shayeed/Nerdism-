import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:nerdism/course_content_adapter.dart';
import 'package:nerdism/nerdism.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';

var formattedDate = DateFormat.yMMMMd('en_US');

class CourseContent extends StatefulWidget {
  void openFile(file) async {
    await OpenFile.open(file);
  }

  CourseContent({
    super.key,
    required this.courseTitle,
    required this.courseCode,
  });

  final String courseTitle;
  final String courseCode;

  @override
  State<CourseContent> createState() => _CourseContentState();
}

class _CourseContentState extends State<CourseContent> {
  late Box<CourseContentDetails> courseMaterialBox;
  bool isLoading = true;
  bool isAddingData = false;
  String renamedName = '';

  @override
  void initState() {
    super.initState();
    openBox();
  }

  Future<void> openBox() async {
    try {
      courseMaterialBox =
          await Hive.openBox<CourseContentDetails>(widget.courseCode);
    } catch (e) {
      print("Error opening Hive box: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void showRenameDialog(
      BuildContext context, int index, CourseContentDetails content) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _renameController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          // backgroundColor: Colors.black,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Text("Rename File"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _renameController,
                  decoration: InputDecoration(
                    labelText: "New Name",
                    hintText: "Enter new name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Name cannot be empty";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  String newName = _renameController.text.trim();
                  rename(index, content.path, content.type, newName);
                  Navigator.pop(context);
                }
              },
              child: const Text("Rename"),
            ),
          ],
        );
      },
    );
  }

  void rename(
    int index,
    String path,
    String type,
    String renamedName,
  ) {
    final key = courseMaterialBox.keyAt(index); // Retrieve the correct key
    if (key != null) {
      setState(() {
        courseMaterialBox.put(
          key,
          CourseContentDetails(
            path: path,
            type: type,
            renamedName: renamedName,
          ),
        );
      });
    } else {
      print("Error: Key not found for index $index");
    }
  }

  Future<void> addImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: [
        "jpeg",
        "jpg",
        "png",
        "gif",
        "webp",
        "svg",
        "raw",
        "dng",
        "heif",
        "heic",
      ],
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      setState(() {
        isAddingData = true;
      });

      for (int i = 0; i < files.length; i++) {
        courseMaterialBox.put(
          '${courseMaterialBox.length + i}',
          CourseContentDetails(
            path: files[i].path,
            type: extension(files[i].path),
            renamedName: "",
          ),
        );
      }

      setState(() {
        isAddingData = false;
      });
    }
  }

  Future<void> addPdfs() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: [
        'docx',
        'txt',
        'pdf',
        'ppt',
        'pptx',
        'xls',
        'xlsx',
      ],
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      setState(() {
        isAddingData = true;
      });

      for (int i = 0; i < files.length; i++) {
        courseMaterialBox.put(
          '${courseMaterialBox.length + i}',
          CourseContentDetails(
            path: files[i].path,
            type: extension(files[i].path),
            renamedName: "",
          ),
        );
      }

      setState(() {
        isAddingData = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 35,
            child: IconButton(
              onPressed: isAddingData ? null : addPdfs,
              icon: const Icon(
                Icons.picture_as_pdf,
                size: 20,
              ),
            ),
          ),
          IconButton(
            onPressed: isAddingData ? null : addImages,
            icon: const Icon(
              Icons.add_a_photo_sharp,
              size: 20,
            ),
          )
        ],
      ),
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(widget.courseCode),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 80,
                        width: (MediaQuery.of(context).size.width - 50) / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                        ),
                        child: Center(
                          child: Text(
                            'Nura Apur Note',
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        height: 80,
                        width: (MediaQuery.of(context).size.width - 50) / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                        ),
                        child: Center(
                          child: Text(
                            'Question Bank',
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Divider(
                    thickness: 2,
                    color: textColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: isAddingData
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : courseMaterialBox.isEmpty
                            ? Center(
                                child: Text(
                                  "No course material is here...",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.all(20),
                                itemCount: courseMaterialBox.length,
                                itemBuilder: (context, index) {
                                  final content =
                                      courseMaterialBox.getAt(index);
                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          widget.openFile(content!.path);
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.black,
                                          ),
                                          child: ListTile(
                                            title: Text(
                                              content != null &&
                                                      content.renamedName
                                                          .isNotEmpty
                                                  ? "${content.renamedName} ${content.type}"
                                                  : basename(content!.path),
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: textColor,
                                              ),
                                            ),
                                            subtitle: Text(
                                              content != null
                                                  ? formattedDate
                                                      .format(content.date)
                                                  : "No Date",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: textColor,
                                              ),
                                            ),
                                            leading: Text(
                                              "${index + 1}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: textColor,
                                              ),
                                            ),
                                            trailing: IconButton(
                                              onPressed: () {
                                                showRenameDialog(
                                                    context, index, content!);
                                              },
                                              icon: const Icon(
                                                Icons.create_outlined,
                                              ),
                                              color: textColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  );
                                },
                              ),
                  ),
                ],
              ),
            ),
    );
  }
}
