import 'package:flutter/material.dart';
import 'package:simple_dialogs_flutter/simple_dialogs_flutter.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Smart Dialog'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [

            MaterialButton(
              color: Colors.green,
              height: 50,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              textColor: Colors.white,
              child:  Text('Show Scuess Dialog',),
              onPressed: () {
                SimpleDialogs.showSuccessDialog(context: context, title: "");
              },
            ),
            SizedBox(height: 20,),
            MaterialButton(
              color: Colors.red,
              height: 50,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              textColor: Colors.white,
              child:  Text('Show Error Dialog',),
              onPressed: () {
                SimpleDialogs.showerrorDialog(context: context, title: "");
              },
            ),
            SizedBox(height: 20,),
            MaterialButton(
              color: Colors.blue,
              height: 50,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              textColor: Colors.white,
              child:  Text('Show Info Dialog',),
              onPressed: () {
                SimpleDialogs.showinfoDialog(context: context, title: "");
              },
            )
          ],
        ),



        ),
      );

  }
}
