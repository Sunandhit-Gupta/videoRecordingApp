import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:video_recording_app/Screens/cameraPage.dart';
import 'package:video_recording_app/Screens/gallary.dart';
import 'package:video_recording_app/Screens/uploadPage.dart';

import 'Screens/providerList.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
    theme: ThemeData.dark(),
  ));
}

int myIndex = 1;
List<Widget> widgetList = [
  Gallary(),
  cameraPage(),
  uploadPage()
];



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => listProvider())],
      child: SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Video Recording App"),
        centerTitle: true,
      ),
      body:  Column(
        children: [Expanded(
              child: Container(
                color: Colors.transparent,
                //------------------------------ Giving Screens as input to change with NAVBAR----------------
                child: IndexedStack(
                  index: myIndex,
                  children: widgetList,
                ),
              ),
            ),],
      ),
      bottomNavigationBar: CurvedNavigationBar(
          color: Colors.blue,
          backgroundColor: Colors.transparent,
          height: 70,
          index: 1,
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          },
          items: const [

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  color: Colors.black,
                  Icons.photo,
                  size: 30,
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  color: Colors.black,
                  Icons.camera_alt_rounded,
                  size: 30,
                )
              ],
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  color: Colors.black,
                  Icons.person,
                  size: 30,
                )
              ],
            ),
          ]),
    )));
  }
}
