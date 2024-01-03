
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_recording_app/Screens/videoPlayer.dart';

class Gallary extends StatefulWidget {
const Gallary({super.key});

  @override
  State<Gallary> createState() => _GallaryState();

}

final ImagePicker picker = ImagePicker();
// image vairable is created:

XFile? videoFile;

class _GallaryState extends State<Gallary> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: Column(
      children: [
        videoFile == null ? const Center(child: SizedBox(height:200,
        width: 300,)): Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(5, 20, 5, 5),
            height: 400,
            width: 400,
            child: videoPlayer(videoFileSource: videoFile)),
        ),
        Center(child: ElevatedButton(onPressed: () => getImage(source: ImageSource.gallery), child: Text("Browse")))
      ],
    ),));
  }

  void getImage({required ImageSource source}) async{
    final file = await ImagePicker().pickVideo(source: source);
    if(file?.path != null)
    {
      setState(() {
        videoFile = file;
      });
    }
  }
}