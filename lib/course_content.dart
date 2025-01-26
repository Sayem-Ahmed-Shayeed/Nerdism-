import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:nerdism/course_content_adapter.dart';
import 'package:nerdism/theme&colors/colors.dart';
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
      //...
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void showRenameDialog(
      BuildContext context, int index, CourseContentDetails content) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController renameController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          // backgroundColor: Colors.black,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            "Rename File",
            style: TextStyle(
              fontSize: 14,
              color: textColor2,
              fontFamily: 'font6',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  style: const TextStyle(
                    fontFamily: 'font6',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    labelText: "New Name",
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontFamily: 'font6',
                      color: textColor2,
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: "Enter new name",
                    hintStyle: TextStyle(
                      color: textColor2,
                      fontSize: 12,
                      fontFamily: 'font6',
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  controller: renameController,
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
              child: Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 12,
                  color: textColor2,
                  fontFamily: 'font6',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  String newName = renameController.text.trim();
                  rename(index, content.path, content.type, newName);
                  Navigator.pop(context);
                }
              },
              child: Text(
                "Rename",
                style: TextStyle(
                  fontSize: 12,
                  color: textColor,
                  fontFamily: 'font6',
                  fontWeight: FontWeight.bold,
                ),
              ),
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
      //....
    }
  }

  @override
  void dispose() {
    // Check if the timer is not null and active before canceling
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
    elapsedTimeNotifier.dispose(); // Dispose the ValueNotifier
    super.dispose();
  }

// Timer-related variables
  ValueNotifier<int> elapsedTimeNotifier = ValueNotifier<int>(3);
  Timer? _timer; // Use nullable Timer
  int timerElapsed = 0;

  void _startTimer(BuildContext context) {
    // Cancel any existing timer before starting a new one
    _timer?.cancel();

    // Reset the elapsed time to 3
    elapsedTimeNotifier.value = 3;

    // Start the timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (elapsedTimeNotifier.value > 0) {
        elapsedTimeNotifier.value--;
      } else {
        _timer?.cancel();
        ScaffoldMessenger.of(context).clearSnackBars();
      }
    });
  }

  void deleteNoteAt(BuildContext context, int index) {
    // Store all current notes in a temporary list
    List<CourseContentDetails> tempList = [];
    for (int i = 0; i < courseMaterialBox.length; i++) {
      tempList.add(courseMaterialBox.getAt(i)!);
    }

    // Remove the note from the box
    setState(() {
      courseMaterialBox.deleteAt(index);
    });

    // Start the timer when the note is deleted
    ScaffoldMessenger.of(context).clearSnackBars();
    _startTimer(context);

    // Show a snackbar with undo functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xff423838),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        content: ValueListenableBuilder<int>(
          valueListenable: elapsedTimeNotifier,
          builder: (context, elapsedTime, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Item removed.",
                  style: TextStyle(
                    fontFamily: 'font6',
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(5),
                  child: Text(
                    "Undo(${elapsedTime}s)", // Update elapsed time
                    style: const TextStyle(
                      fontFamily: 'font6',
                      fontSize: 12,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    // Stop the timer and reset elapsed time
                    ScaffoldMessenger.of(context).clearSnackBars();
                    _timer?.cancel();
                    elapsedTimeNotifier.value = 3; // Reset elapsed time

                    // Restore the deleted note
                    for (int i = 0; i < tempList.length - 1; i++) {
                      courseMaterialBox.putAt(i, tempList[i]);
                    }
                    courseMaterialBox.add(tempList[tempList.length - 1]);

                    setState(() {}); // Refresh the UI
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
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
        courseMaterialBox.add(
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
        courseMaterialBox.add(
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
      backgroundColor: appBarColor,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 35,
            child: IconButton(
              onPressed: isAddingData ? null : addPdfs,
              icon: Icon(
                Icons.picture_as_pdf,
                size: 20,
                color: textColor,
              ),
            ),
          ),
          IconButton(
            onPressed: isAddingData ? null : addImages,
            icon: Icon(
              Icons.add_a_photo_sharp,
              size: 20,
              color: textColor,
            ),
          )
        ],
      ),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: appBarColor,
        title: Text(
          widget.courseTitle,
          style: TextStyle(
            color: textColor2,
            fontFamily: 'font6',
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: LottieBuilder.asset(
                'assets/Lottie/loader.json',
                fit: BoxFit.cover,
              ),
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
                          color: containerColor,
                        ),
                        child: Center(
                          child: Text(
                            'Nura Apur Note',
                            style: TextStyle(
                              color: textColor2,
                              fontFamily: 'font6',
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
                          borderRadius: BorderRadius.circular(15),
                          color: containerColor,
                        ),
                        child: Center(
                          child: Text(
                            'Question Bank',
                            style: TextStyle(
                              fontFamily: 'font6',
                              color: textColor2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: isAddingData
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : courseMaterialBox.isEmpty
                            ? const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "No course material is here.",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'font6',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Try adding some...",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'font6',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.all(20),
                                itemCount: courseMaterialBox.length,
                                itemBuilder: (context, index) {
                                  final content =
                                      courseMaterialBox.getAt(index);
                                  return Dismissible(
                                    onDismissed: (direction) {
                                      deleteNoteAt(context, index);
                                    },
                                    key: ValueKey(content.hashCode),
                                    background: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.asset(
                                          "assets/a.gif",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            widget.openFile(content.path);
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: containerColor,
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
                                                  color: textColor2,
                                                  fontFamily: 'font6',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              subtitle: Text(
                                                "${formattedDate.format(content.date)} , ${content.date.hour}:${content.date.minute}",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: textColor2,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'font6'),
                                              ),
                                              leading: Text(
                                                "${index + 1}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: textColor2,
                                                    fontFamily: 'font6'),
                                              ),
                                              trailing: IconButton(
                                                onPressed: () {
                                                  showRenameDialog(
                                                      context, index, content);
                                                },
                                                icon: const Icon(
                                                  Icons.create_outlined,
                                                  size: 15,
                                                  color: Colors.white,
                                                ),
                                                color: textColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
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
