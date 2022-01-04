library simple_dialogs_flutter;

/// A Calculator.
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SimpleDialogs{
  static Future showSuccessDialog({
    required BuildContext context,
    required String title,

  }){
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[



                Container(
                  height:60,

                  width: 50,
                  decoration: const
                  BoxDecoration(
                      image: DecorationImage (
                          image: AssetImage("packages/simple_dialogs_flutter/assets/check.png"),fit: BoxFit.cover
                      )
                  ),

                ),
                SizedBox(height: 5,),
                Text(title.toString() == ""?"Insert your text here...!":title, textScaleFactor: 1.4,  style: GoogleFonts.inter(), textAlign: TextAlign.center,),
                SizedBox(height: 20,),
                MaterialButton(
                  color: Colors.green,
                  height: 50,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  textColor: Colors.white,
                  child:  Text('close', textScaleFactor: 1.1, style: GoogleFonts.inter(),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
            elevation: 10,
          );
        });

  }
  static Future showerrorDialog({
    required BuildContext context,
    required String title,
  }){
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[



                Container(
                  height:60,

                  width: 60,
                  decoration: const
                  BoxDecoration(
                      image: DecorationImage (
                          image: AssetImage("packages/simple_dialogs_flutter/assets/error.png"),fit: BoxFit.fill
                      )
                  ),

                ),
                SizedBox(height: 5,),
                Text(title.toString() == ""?"Insert your text here...!":title, textScaleFactor: 1.4,  style: GoogleFonts.inter(), textAlign: TextAlign.center,),
                SizedBox(height: 20,),
                MaterialButton(
                  color: Colors.red,
                  height: 50,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  textColor: Colors.white,
                  child:  Text('close', textScaleFactor: 1.1, style: GoogleFonts.inter(),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
            elevation: 10,
          );
        });

  }
  static Future showinfoDialog({
    required BuildContext context,
    required String title,
  }){
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[



                Container(
                  height:60,

                  width: 60,
                  decoration: const
                  BoxDecoration(
                      image: DecorationImage (
                          image: AssetImage("packages/simple_dialogs_flutter/assets/info.png"),fit: BoxFit.fill
                      )
                  ),

                ),
                SizedBox(height: 5,),
                Text(title.toString() == ""?"Insert your text here...!":title, textScaleFactor: 1.4,  style: GoogleFonts.inter(), textAlign: TextAlign.center,),
                SizedBox(height: 20,),
                MaterialButton(
                  color: Colors.blue,
                  height: 50,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  textColor: Colors.white,
                  child:  Text('close', textScaleFactor: 1.1, style: GoogleFonts.inter(),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
            elevation: 10,
          );
        });

  }
}