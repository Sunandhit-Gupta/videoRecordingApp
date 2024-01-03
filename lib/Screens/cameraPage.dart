import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_recording_app/Screens/videoPlayer.dart';

class cameraPage extends StatefulWidget {
  const cameraPage({super.key});

  @override
  State<cameraPage> createState() => _cameraPageState();
}

XFile? videoFile;
bool firstTime = true;

class _cameraPageState extends State<cameraPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: firstTime
                ? Center(
                    child: ElevatedButton(
                        onPressed: () {
                          getVideo(source: ImageSource.camera);
                        },
                        child: const Text("Capture Video")))
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        height: 400,
                        width: 400,
                        child: videoPlayer(
                          videoFileSource: videoFile,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(onPressed: () {if(videoFile != null)
                          {
                            saveVideo(videoFile!.path);
                          }}, child: Text("Save")),
                         const SizedBox(
                            width: 20,
                            height: 0,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                getVideo(source: ImageSource.camera);
                              },
                              child: const Text("Capture")),
                         const SizedBox(
                            width: 4,
                            height: 0,
                          ),

                        ],
                      ),
                    ],
                  )));
  }

  void getVideo({required ImageSource source}) async {
    final file = await ImagePicker().pickVideo(source: source);
    if (file?.path != null) {
      setState(() {
        videoFile = file;
        firstTime = false;
      });
    }
  }


  Future<void> saveVideo(String videoPath) async {
  // final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
  try {
    final Directory? downloadDir = await getDownloadsDirectory();

    if(downloadDir!.path != null){
      int time = DateTime.now().microsecond;
      int seconds = DateTime.now().second;
      String destinationPatho = downloadDir.path;
      String destinationPath = '$destinationPatho/$time$seconds.mp4';

      File dfile = File(destinationPath);
      List<int> videoBytes = await videoFile!.readAsBytes();
      dfile.writeAsBytesSync(videoBytes);
    print('Video saved successfully at $destinationPath');
    Fluttertoast.showToast(
        msg: 'video saved at ${destinationPath}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.cyan,
        textColor: Colors.white,
        fontSize: 16.0
    );


    }
  } catch (e) {
    print('Error saving video: $e');
  }
}
}
