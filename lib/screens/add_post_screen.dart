import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/utils.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialogOption(
            padding: EdgeInsets.all(20),
            child: const Text('Take a photo'),
            onPressed: () async {
              Navigator.of(context).pop();
              Uint8List file = await pickImage(ImageSource.camera);
              setState(() {
                _file = file;
              });
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // return  Center(
    //   child: IconButton(
    //     icon: const Icon(Icons.upload),
    //     onPressed: () {},
    //   ),
    // );
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          leading:
              IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
          title: const Text('Post to'),
          centerTitle: false,
          actions: [
            TextButton(
                onPressed: () {},
                child: const Text(
                  'Post',
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ))
          ],
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://wallpapers.com/images/featured/best-ever-desktop-bgt6dccypy1dfk0c.jpg'),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: const TextField(
                    decoration: InputDecoration(
                        hintText: 'Write a caption...',
                        border: InputBorder.none),
                    maxLength: 8,
                  ),
                ),
                SizedBox(
                  height: 45,
                  width: 45,
                  child: AspectRatio(
                    aspectRatio: 487 / 451,
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                'https://wallpapers.com/images/featured/best-ever-desktop-bgt6dccypy1dfk0c.jpg',
                              ),
                              fit: BoxFit.fill,
                              alignment: FractionalOffset.topCenter)),
                    ),
                  ),
                ),
                const Divider()
              ],
            )
          ],
        ));
  }
}
