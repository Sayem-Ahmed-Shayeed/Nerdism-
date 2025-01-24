import 'package:flutter/material.dart';
import 'package:nerdism/nerdism.dart';

class AddSubjectPage extends StatefulWidget {
  const AddSubjectPage({super.key});

  @override
  State<AddSubjectPage> createState() => _AddSubjectPageState();
}

class _AddSubjectPageState extends State<AddSubjectPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String subjectName = "";

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pop(context, subjectName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text('Add Course'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.length <= 2) {
                    return "Enter a valid course name";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Course name",
                  hintText: "Enter the course name...",
                  hintStyle: TextStyle(fontSize: 12),
                  labelStyle: TextStyle(fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                onSaved: (newValue) {
                  if (newValue != null) {
                    subjectName = newValue;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.length <= 7) {
                    return "Enter a valid course name";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Course name",
                  hintText: "Enter the course name...",
                  hintStyle: TextStyle(fontSize: 12),
                  labelStyle: TextStyle(fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                onSaved: (newValue) {
                  if (newValue != null) {
                    subjectName = newValue;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _formKey.currentState!.reset(); // Resets the form fields
                      setState(
                        () {
                          subjectName = ""; // Clear the subject name
                        },
                      );
                    },
                    child: const Text(
                      "Reset",
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text("Add"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
