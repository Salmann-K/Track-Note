import 'package:flutter/material.dart';
import 'package:track_note/colors.dart';

class EditNoteView extends StatefulWidget {
  const EditNoteView({super.key});

  @override
  State<EditNoteView> createState() => _EditNoteViewState();
}

class _EditNoteViewState extends State<EditNoteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: bgColor,
        elevation: 0.0,
        actions: [
          IconButton(
            splashRadius: 17,
              onPressed: () {} ,
              icon: Icon(Icons.save_outlined))
        ],
      ),

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        child: Column(
          children: [
            TextField(
              cursorColor: white,
              style: TextStyle(fontSize: 25,color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: "Title",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.withOpacity(0.8)
                )
              ),
            ),
            
            Container(
              height: 300,
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 50,
                  maxLines: null,
                  cursorColor: Colors.white,
                  style: TextStyle(fontSize: 17,color: Colors.white),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Note",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.withOpacity(0.8)
                        )
                    ),
                )
            )
          ],
        ),
      ),
    );
  }
}
