import 'package:adminapp/Blog/BlogAlertbox.dart';
import 'package:adminapp/controllers/BlogControllers.dart';
import 'package:adminapp/models/BlogModel.dart';
import 'package:adminapp/services/Blog_db_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class blogview extends StatefulWidget {
  const blogview({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<blogview> {
  final _bcontoller = Get.put(BlogControllers());
  final BlogDatabaseServices _blogdatabaseServices = BlogDatabaseServices();

  // Function to show the blog alert dialog
  void _showAddBlogDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return blogAlertbox(); // Display the blogAlertbox widget in the AlertDialog
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: width * 0.5,
          child: StreamBuilder<QuerySnapshot<Blog>>(
            stream: _blogdatabaseServices.getBlogs(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              List<QueryDocumentSnapshot<Blog>> blogs = snapshot.data!.docs;
              if (blogs.isEmpty) {
                return Center(child: Text('No New Blog'));
              }

              return ListView.builder(
                itemCount: blogs.length,
                itemBuilder: (context, index) {
                  Blog blog = blogs[index].data();
                  String blogID = blogs[index].id;
                  return Card(
                    child: ExpansionTile(
                      title: Text(
                        blog.Title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(blog.Subtitle),
                          Text(DateFormat("dd-MM-yyyy h:mm a")
                              .format(blog.createdOn.toDate())),
                        ],
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                blog.Title,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                blog.Description,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
