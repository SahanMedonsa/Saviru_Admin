import 'package:app/Blog/Blogview.dart';
import 'package:app/components/DetailContainer.dart';
import 'package:app/components/Drawer.dart';
import 'package:app/controllers/BlogControllers.dart';
import 'package:app/models/BlogModel.dart';
import 'package:app/services/Blog_db_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app/Blog/BlogAlertbox.dart';
import 'package:app/components/Gtext.dart';
import 'package:app/components/colorPallet.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:table_calendar/table_calendar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorPalette.forest_Green.withOpacity(0.2),
            endDrawer: const Drawerr(),
            body: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.03, horizontal: width * 0.03),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Gtext(
                                  text: 'Home Page',
                                  size: 20,
                                  color: ColorPalette.appBar_color,
                                  fweight: FontWeight.bold)
                            ],
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          SizedBox(
                            width: 300,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Gtext(
                                    text: 'Add New Blog',
                                    size: 18,
                                    color: ColorPalette.appBar_color,
                                    fweight: FontWeight.w500),
                                Builder(builder: (context) {
                                  return MaterialButton(
                                    color: ColorPalette.button_color,
                                    onPressed: () {
                                      _showAddBlogDialog();
                                    },
                                    child: const Gtext(
                                        text: 'Add',
                                        size: 15,
                                        color: ColorPalette.appBar_color,
                                        fweight: FontWeight.w500),
                                  );
                                })
                              ],
                            ),
                          ),

                          //////////////stream builder////////////////////
                          /////////////////stream builder/////////////////
                          /////////////////stream builder/////////////////
                          SizedBox(
                            height: height * 0.05,
                          ),
                          SizedBox(
                            // color: Colors.red,
                            width: width * 1 / 2,

                            child: StreamBuilder(
                              stream: _blogdatabaseServices.getBlogs(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                List Blogs = snapshot.data?.docs ?? [];

                                if (Blogs.isEmpty) {
                                  return const Center(child: Text('Add Blogs'));
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),

                                    //////////////farmers detail///////////////
                                    SizedBox(
                                      //     color: Colors.green,

                                      height: height * 1,
                                      child: ListView.builder(
                                        itemCount: Blogs.length,
                                        itemBuilder: (context, index) {
                                          Blog blog = Blogs[index].data();
                                          String BlogID = Blogs[index].id;
                                          print(BlogID);

                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Card(
                                              child: ExpansionTile(
                                                title: Gtext(
                                                    text: blog.Title,
                                                    size: 15,
                                                    color: ColorPalette
                                                        .Jungle_Green,
                                                    fweight: FontWeight.w400),
                                                subtitle: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Gtext(
                                                        text: blog.Subtitle,
                                                        size: 10,
                                                        color: Colors.black,
                                                        fweight:
                                                            FontWeight.w400),
                                                    Row(
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {},
                                                            icon: Icon(
                                                                Icons.edit)),
                                                        IconButton(
                                                          onPressed: () {
                                                            _blogdatabaseServices
                                                                .deleteBlog(
                                                                    BlogID);
                                                          },
                                                          icon: Icon(
                                                            Icons.delete,
                                                            color: ColorPalette
                                                                .red,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Column(
                                                      children: [
                                                        Gtext(
                                                            text: blog.Title,
                                                            size: 15,
                                                            color: ColorPalette
                                                                .Jungle_Green,
                                                            fweight: FontWeight
                                                                .w400),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Gtext(
                                                            text: blog.Subtitle,
                                                            size: 15,
                                                            color: Colors.black,
                                                            fweight: FontWeight
                                                                .w400),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Gtext(
                                                            text: blog
                                                                .Description,
                                                            size: 15,
                                                            color: Colors.black,
                                                            fweight: FontWeight
                                                                .w400),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                        width: width * 1 / 2.9,
                        height: height,
                        //color: Colors.red,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Gtextn(text: "Calender "),
                            SizedBox(
                              height: 30,
                            ),
                            TableCalendar(
                              firstDay: DateTime.utc(2020, 01, 01),
                              lastDay: DateTime.utc(2030, 12, 31),
                              focusedDay: _focusedDay,
                              calendarFormat: _calendarFormat,
                              onFormatChanged: (format) {
                                setState(() {
                                  _calendarFormat = format;
                                });
                              },
                              onDaySelected: (selectedDay, focusedDay) {
                                setState(() {
                                  _selectedDay = selectedDay;
                                  _focusedDay = focusedDay;
                                });
                              },
                              selectedDayPredicate: (day) {
                                return isSameDay(_selectedDay, day);
                              },
                            ),
                          ],
                        )),
                  )
                ],
              ),
            )));
  }
}
