import 'package:app/components/Colorpallet.dart';
import 'package:app/components/Gtext.dart';
import 'package:app/components/textfiels.dart';
import 'package:app/controllers/BlogControllers.dart';
import 'package:app/models/BlogModel.dart';
import 'package:app/services/Blog_db_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class blogAlertbox extends StatefulWidget {
  const blogAlertbox({super.key});

  @override
  State<blogAlertbox> createState() => _blogAlertboxState();
}

class _blogAlertboxState extends State<blogAlertbox> {
  final BlogDatabaseServices _blogdatabaseServices = BlogDatabaseServices();
  final bcontoller = Get.put(BlogControllers());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void dispose() {
      // Dispose of text controllers when the state is disposed
      bcontoller.titleController.dispose();
      bcontoller.subtitleController.dispose();
      bcontoller.DescriptionController.dispose();
      super.dispose();
    }

    return AlertDialog(
      title: Text('Add New Content'),
      content: Container(
        width: 400,
        height: 400,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Textfields(
                  keyboardType: TextInputType.name,
                  label: 'Title',
                  tcontroller: bcontoller.titleController),
              Textfields(
                  keyboardType: TextInputType.name,
                  label: 'Sub Title',
                  tcontroller: bcontoller.subtitleController),
              TextFormField(
                  keyboardType: TextInputType.text,
                  maxLines: 10,
                  controller: bcontoller.DescriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    hintText: 'Description', // Use labelText instead of label
                  )),
            ],
          ),
        ),
      ),
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
            bcontoller.titleController.text = '';
            bcontoller.subtitleController.text = '';
            bcontoller.DescriptionController.text = '';
          },
          child: Gtext(
              text: 'Cancel',
              size: 16,
              color: ColorPalette.red,
              fweight: FontWeight.w500),
        ),
        MaterialButton(
          onPressed: () {
            // Get the current text from the controllers
            String title = bcontoller.titleController.text;
            String subtitle = bcontoller.subtitleController.text;
            String description = bcontoller.DescriptionController.text;

            String formattedDescription = '''
              <b>This is a bold text.</b>
              <ul>
                <li>Bullet Point 1</li>
                <li>Bullet Point 2</li>
                <li>Bullet Point 3</li>
              </ul>
              <a href="https://www.example.com">Link to Example</a>
            ''';

            // Create a new Blog object with the retrieved text
            Blog blog = Blog(
              Title: title,
              Description: description,
              Subtitle: subtitle,
              createdOn: Timestamp.now(),
              UpdatedOn: Timestamp.now(),
            );
            bcontoller.titleController.text = '';
            bcontoller.subtitleController.text = '';
            bcontoller.DescriptionController.text = '';
            _blogdatabaseServices.addBlog(blog);
            Navigator.of(context).pop();
          },
          child: Gtext(
              text: 'Save',
              size: 16,
              color: Colors.blue,
              fweight: FontWeight.w500),
        ),
      ],
    );
  }
}
