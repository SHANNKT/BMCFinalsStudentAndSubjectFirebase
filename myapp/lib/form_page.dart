import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController sectionController = TextEditingController();
  final TextEditingController yearLevelController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    sectionController.dispose();
    yearLevelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: sectionController,
              decoration: const InputDecoration(
                labelText: 'Section',
                border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: yearLevelController,
              decoration: const InputDecoration(
                labelText: 'Yr. level',
                border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SchedulePage(
                      name: nameController.text.trim(),
                      section: sectionController.text.trim(),
                      yearLevel: yearLevelController.text.trim(),
                    ),
                  ),
                );
              },
              child: const Text('Next')
            )
          ],
        ),
      )
    );
  }
}

class SchedulePage extends StatefulWidget {
  final String name;
  final String section;
  final String yearLevel;

  const SchedulePage({
    super.key,
    required this.name,
    required this.section,
    required this.yearLevel,
  });

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {

  final TextEditingController subject1Controller = TextEditingController();
  final TextEditingController schedule1Controller = TextEditingController();
  final TextEditingController subject2Controller = TextEditingController();
  final TextEditingController schedule2Controller = TextEditingController();
  final TextEditingController subject3Controller = TextEditingController();
  final TextEditingController schedule3Controller = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveData() async {
    if (subject1Controller.text.trim().isEmpty ||
        schedule1Controller.text.trim().isEmpty ||
        subject2Controller.text.trim().isEmpty ||
        schedule2Controller.text.trim().isEmpty ||
        subject3Controller.text.trim().isEmpty ||
        schedule3Controller.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please Fill in all fields')),
      );
      return;
    }

    await firestore.collection('student registration').add({
      'name': widget.name,
      'section': widget.section,
      'yearLevel': widget.yearLevel,
      'subject1': subject1Controller.text.trim(),
      'schedule1': schedule1Controller.text.trim(),
      'subject2': subject2Controller.text.trim(),
      'schedule2': schedule2Controller.text.trim(),
      'subject3': subject3Controller.text.trim(),
      'schedule3': schedule3Controller.text.trim(),
      'createdAt': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      const SnackBar(content: Text('Data Saved successfully')),
    );

    subject1Controller.clear();
    schedule1Controller.clear();
    subject2Controller.clear();
    schedule2Controller.clear();
    subject3Controller.clear();
    schedule3Controller.clear();
  }

  @override
  void dispose() {
    subject1Controller.dispose();
    schedule1Controller.dispose();
    subject2Controller.dispose();
    schedule2Controller.dispose();
    subject3Controller.dispose();
    schedule3Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subject Schedule'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: subject1Controller,
                decoration: const InputDecoration(
                  labelText: 'Subject',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: schedule1Controller,
                decoration: const InputDecoration(
                  labelText: 'Schedule',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: subject2Controller,
                decoration: const InputDecoration(
                  labelText: 'Subject',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: schedule2Controller,
                decoration: const InputDecoration(
                  labelText: 'Schedule',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: subject3Controller,
                decoration: const InputDecoration(
                  labelText: 'Subject',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: schedule3Controller,
                decoration: const InputDecoration(
                  labelText: 'Schedule',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: saveData,
                child: const Text('Submit')
              )
            ],
          ),
        ),
      )
    );
  }
}