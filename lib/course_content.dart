import 'package:flutter/material.dart';
import 'package:nerdism/nerdism.dart';

class CourseContent extends StatefulWidget {
  CourseContent({super.key, required this.courseTitle});
  String courseTitle;

  @override
  State<CourseContent> createState() => _CourseContentState();
}

class _CourseContentState extends State<CourseContent> {
  void addImages() {
    //add to hive here
  }
  void addPdfs() {
    //add to hive here
  }
  //also dont forget to fetch data from the hive while loading the page everrytime
  Widget expandedAddContentButton = Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      SizedBox(
        width: 35,
        child: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.picture_as_pdf,
            size: 20,
          ),
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.add_a_photo_sharp,
          size: 20,
        ),
      )
    ],
  );
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: expandedAddContentButton,
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(widget.courseTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.center,
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
            Text(
              "Your Course Material goes here...",
              style: TextStyle(
                fontSize: 24,
                color: textColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black,
                          ),
                          child: ListTile(
                            title: Text(
                              'PDF 1',
                              style: TextStyle(fontSize: 14, color: textColor),
                            ),
                            subtitle: Text(
                              "12-3-2025",
                              style: TextStyle(fontSize: 10, color: textColor),
                              textAlign: TextAlign.start,
                            ),
                            trailing: Icon(Icons.image),
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
                      const SizedBox(
                        height: 10,
                      ),
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
