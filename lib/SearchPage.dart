import 'package:flutter/material.dart';
import 'package:track_note/colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(

        child: Container(
          decoration: BoxDecoration(
            color: white.withOpacity(0.1)
          ),
          child: Row(
            children: [
              IconButton(onPressed: (){
                Navigator.pop(context);
              } , icon: Icon(Icons.arrow_back_outlined,color: white,)),
              Expanded(
                child: TextField(
                  style: TextStyle(
                    color: Colors.white
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Search Your Notes",
                    hintStyle: TextStyle(
                        color: white.withOpacity(0.5),
                        fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
