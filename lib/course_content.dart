import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:nerdism/course_content_adapter.dart';
import 'package:nerdism/nerdism.dart';
import 'package:path/path.dart';

var formattedDate = DateFormat.yMMMMd('en_US');

class CourseContent extends StatefulWidget {
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
            shortNote: "",
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
            shortNote: "",
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
                            'Previous Years Questions',
                            style: TextStyle(
                              color: textColor,
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
                                  "No course material is here.",
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
                                          // Open the file using open_file package
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
                                              content?.type ?? "Unknown",
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
