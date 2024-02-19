import 'dart:io';

import 'package:flutter/material.dart';
import 'package:labour_lite/services/image_handling.dart';

class UploadScreen extends StatelessWidget {
  static const String id = 'upload_screen';
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Documents"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          myUploadButton(
              text: "Adhar Card",
              image: 'assets/aadhar.png',
              imageHandling: ImageHandling(),
              context: context),
          myUploadButton(
              text: "Adhar Card",
              image: 'assets/id_card.png',
              imageHandling: ImageHandling(),
              context: context),
          myUploadButton(
              text: "Adhar Card",
              image: 'assets/medical_fitness.png',
              imageHandling: ImageHandling(),
              context: context),
        ],
      ),
    );
  }
}

Widget myUploadButton(
    {required String text,
    required String image,
    required ImageHandling imageHandling,
    required BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: 140,
              child: Image.asset(image),
            ),
            ElevatedButton(
              onPressed: () async {
                await imageHandling.pickImageFromCamera();
              },
              style: ElevatedButton.styleFrom(shape: const CircleBorder()),
              child: const Icon(Icons.camera),
            ),
            ElevatedButton(
              onPressed: () async {
                await imageHandling.pickImageFromGallery();
              },
              style: ElevatedButton.styleFrom(shape: const CircleBorder()),
              child: const Icon(Icons.upload),
            ),
            ElevatedButton(
              onPressed: () {
                try {
                  File file = imageHandling.getImage();
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Center(
                          child: Image.file(
                            file,
                            fit: BoxFit.cover,
                          ),
                        );
                      });
                } catch (e) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          title: Text(
                            "No Image Found",
                            textAlign: TextAlign.center,
                          ),
                        );
                      });
                }
              },
              style: ElevatedButton.styleFrom(shape: const CircleBorder()),
              child: const Icon(Icons.remove_red_eye),
            ),
          ],
        ),
      ),
    ),
  );
}
