import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_recording_app/Screens/providerList.dart';
import 'package:video_recording_app/Screens/videoPlayer.dart';


class uploadPage extends StatefulWidget {
  const uploadPage({super.key});

  @override
  State<uploadPage> createState() => _uploadPageState();
}

//  List<String> videoPaths = [];

class _uploadPageState extends State<uploadPage> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    final classInstance = Provider.of<listProvider>(context);
    classInstance.searchForVideos();

    return Consumer<listProvider>(builder: (context, listProviderModel, child) => SafeArea(child: Scaffold(
     body: listProviderModel.videoPaths.length == 0 ? Center(child: Text("Loading")): GridView.builder(
      cacheExtent: 200,
      padding: EdgeInsets.all(5),
      addAutomaticKeepAlives: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5),
       itemCount: listProviderModel.videoPaths.length,
       itemBuilder: (context, index){
         return Container(
          constraints: BoxConstraints.tightForFinite(
              width: double.infinity,
              height: double.infinity,
            ),
          child: videoPlayer(videoFileSource: XFile(listProviderModel.videoPaths[index])));
       })
    )));
  }
}
