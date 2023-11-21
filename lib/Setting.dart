import 'package:flutter/material.dart';
import 'package:track_note/colors.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool value=true;
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
        title: Text("Settings",style: TextStyle(color: Colors.white),),

      ),

      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Text("Sync",style: TextStyle(color: Colors.white,fontSize: 20),),
                Spacer(),
                Transform.scale(
                  scale: 1.1,
                  child: Switch.adaptive(value: value, onChanged: (switchValue){
                    setState(() {
                      this.value=switchValue;
                    });
                  }
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
