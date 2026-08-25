import 'package:configapp/controller/image_controller.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  ImageController controller = ImageController();
  VideoPlayerController? videoController;

  void showVideo() async {
    await controller.getVideoGalary();

     if (controller.video == null) {
      return;
    }

    videoController = VideoPlayerController.file(controller.video!);


    await videoController!.initialize();

    await videoController!.play();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    videoController!.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image and Camera'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    title: Text('Choose option'),
                    children: [
                      SimpleDialogOption(
                        onPressed: () {
                          controller.getImageGallery();
                        },
                        child: Text('Galary'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          controller.getImageCamera();
                        },
                        child: Text('Camera'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          controller.openGalary();
                        },
                        child: Text('Open Galary'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          controller.getVideo();
                        },
                        child: Text('Video'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          showVideo();
                        },
                        child: Text('Select Video'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),

      body: controller.image != null
          ? Center(child: Image.file(controller.image!))
          : controller.video != null
          ? Center(
              child: AspectRatio(
                aspectRatio: videoController!.value.aspectRatio,
                child: VideoPlayer(videoController!),
              ),
            )
          : Text('No Data'),
    );
  }
}
