import 'package:flutter/material.dart';
import 'package:track_note/colors.dart';
import 'package:track_note/home.dart';
import 'package:track_note/model/MyNoteModel.dart';
import 'package:track_note/services/db.dart';

class CreateNoteView extends StatefulWidget {
  const CreateNoteView({Key? key}) : super(key: key);

  @override
  State<CreateNoteView> createState() => _CreateNoteViewState();
}

class _CreateNoteViewState extends State<CreateNoteView> {
  TextEditingController title = new TextEditingController();
  TextEditingController content = new TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    title.dispose();
    content.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: bgColor,
        elevation: 0.0,
        actions: [
          IconButton(
            splashRadius: 17,
            onPressed: () async{
              await NotesDatabase.instance.InsertEntry(Note(
                title : title.text,
                content : content.text,
                isArchieved: false,
                pin : false,
                createdTime: DateTime.now()
              ));
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
            },
            icon: Icon(Icons.save_outlined),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title Section (non-scrollable)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: TextField(
              cursorColor: white,
              controller: title,
              style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: "Title",
                hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.withOpacity(0.8)),
              ),
            ),
          ),
          // Note Section (scrollable)
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                cursorColor: white,
                controller: content,
                keyboardType: TextInputType.multiline,
                minLines: 5,
                maxLines: null,
                style: TextStyle(fontSize: 17, color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Note",
                  hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.withOpacity(0.8)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
