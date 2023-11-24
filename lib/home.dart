import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:track_note/CreateNoteView.dart';
import 'package:track_note/EditNoteView.dart';
import 'package:track_note/NoteView.dart';
import 'package:track_note/SearchPage.dart';
import 'package:track_note/SideMenuBar.dart';
import 'package:track_note/colors.dart';
import 'package:staggered_grid_view_flutter/staggered_grid_view_flutter.dart';
import 'package:track_note/services/db.dart';

import 'model/MyNoteModel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  late List<Note> notesList;
  GlobalKey<ScaffoldState> drawerKey = GlobalKey(); // Drawer key
  String note =
      "This Is Note This Is Note This Is Note This Is Note This Is Note This Is Note v This Is Note This Is Note This Is Note This Is Note This Is Note This Is Note This Is Note This Is Note This Is Note This Is Note v This Is Note This Is Note This Is Note This Is Note";
  String note1 = "This Is Note This Is Note";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createEntry(Note(pin: false, title: "Notes of salman", content: "This Is Salman Notes for future use This Is Salman Notes for future use This Is Salman Notes for future use This Is Salman Notes for future use This Is Salman Notes for future use This Is Salman Notes for future use ", createdTime: DateTime.now()));
    getAllNotes();
  }

  Future createEntry(Note note) async{
    await NotesDatabase.instance.InsertEntry(note);
  }

  Future getAllNotes() async{
    this.notesList= await NotesDatabase.instance.readAllNotes();

    setState(() {
      isLoading = false;
    });
  }

  Future getOneNotes(int id) async{
    await NotesDatabase.instance.readOneNote(id);
  }

  Future updateOneNOte(Note note) async{
    await NotesDatabase.instance.updateNote(note);
  }

  Future deleteNote(Note note) async{
    await NotesDatabase.instance.deleteNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Scaffold( backgroundColor: bgColor,  body: Center(child: CircularProgressIndicator(color: Colors.white,),),) : Scaffold(
      endDrawerEnableOpenDragGesture: true, // drawer open with a gesture
      key: drawerKey, // Defining Drawer Key
      drawer: SideMenu(), // Which Drawer You Want We Have Designed in SideMenu
      backgroundColor: bgColor,

      floatingActionButton: FloatingActionButton(
        splashColor: bgColor,
        elevation: 1.0,
        foregroundColor: Colors.white,
        child: Icon(Icons.add,size: 40.0,),
        backgroundColor: cardColor,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNoteView()));
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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


                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
                            },
                            child: Container(
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
                                    overlayColor:
                                        MaterialStateColor.resolveWith(
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

                NoteSectionAll(),
                NotesListSection()

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget NoteSectionAll(){

    return Container(
      child: Column(
        children: [
          Container(
            margin:
            EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Row(
              mainAxisAlignment : MainAxisAlignment.start,
              children: [
                Text(
                  "ALL",
                  style: TextStyle(
                      color: white.withOpacity(0.5),
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            padding:
            EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            child: StaggeredGridView.countBuilder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: notesList.length,
              shrinkWrap: true,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              crossAxisCount: 4,
              staggeredTileBuilder: (index) => StaggeredTile.fit(2),
              itemBuilder: (context, index) =>

                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NoteView(note: notesList[index])));
                    },
                    child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                      border: Border.all(color: white.withOpacity(0.4)),
                      borderRadius: BorderRadius.circular(7)),
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notesList[index].title,
                        style: TextStyle(
                            color: white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        notesList[index].content.length > 250
                            ? "${notesList[index].content.substring(0, 250)}..."
                            : notesList[index].content,
                        style: TextStyle(color: white),
                      )
                    ],
                                    ),
                                  ),
                  ),
            ),
          ),
        ],
      ),
    );
  }



  Widget NotesListSection(){

    return Container(
      child: Column(
        children: [
          Container(
            margin:
            EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Row(
              mainAxisAlignment : MainAxisAlignment.start,
              children: [
                Text(
                  "LIST VIEW",
                  style: TextStyle(
                      color: white.withOpacity(0.5),
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            padding:
            EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: white.withOpacity(0.4)),
                    borderRadius: BorderRadius.circular(7)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Heading",
                      style: TextStyle(
                          color: white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      index.isEven
                          ? note.length > 250
                          ? "${note.substring(0, 250)}..."
                          : note
                          : note1,
                      style: TextStyle(color: white),
                    )
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }


}
