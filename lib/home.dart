import 'package:flutter/material.dart';
import 'package:track_note/SideMenuBar.dart';
import 'package:track_note/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();   // Drawer key
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawerEnableOpenDragGesture: true,   // drawer open with a gesture
      key: drawerKey, // Defining Drawer Key

      drawer: SideMenu(),  // Which Drawer You Want We Have Designed in SideMenu

      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Container
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: MediaQuery.of(context).size.width,
                height: 55,
                decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          color: black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 3)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Row With Menu Icon And Search Your Text

                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              drawerKey.currentState!.openDrawer();
                            },
                            icon: Icon(
                              Icons.menu,
                              color: white,
                            )),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          height: 55,
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Search Your Notes",
                                style: TextStyle(
                                    color: white.withOpacity(0.5),
                                    fontSize: 17),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                    // Row With View Button And Signed User Avatar
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          TextButton(
                              style: ButtonStyle(
                                  overlayColor: MaterialStateColor.resolveWith(
                                      (states) => white.withOpacity(0.1)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ))),
                              onPressed: () {},
                              child: Icon(
                                Icons.grid_view,
                                color: white,
                              )),
                          SizedBox(
                            width: 9,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 16,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                child: Column(
                  children: [
                    Text("ALL",style: TextStyle(
                        color: white.withOpacity(0.5),
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                    ),),


                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
