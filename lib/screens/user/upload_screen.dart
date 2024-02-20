import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:labour_lite/services/image_handling.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UploadScreen extends StatefulWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = true;

  List<ImageHandling> imageHandling = [
    ImageHandling(),
    ImageHandling(),
    ImageHandling(),
  ];

  static const String id = 'upload_screen';

  UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  late BuildContext _context;
  @override
  void initState() {
    super.initState();
    _context = context;

    getUrl();
  }

  void getUrl() async {
    String? email = widget._auth.currentUser!.email;

    if (email != null) {
      String aadharLocation = "aadhar-card/$email.png";
      String idLocation = "id-card/$email.png";
      String fitnessCertificateLocation = "fitness-certificate/$email.png";
      final FirebaseStorage storage = FirebaseStorage.instance;
      try {
        String aadharUrl =
            await storage.ref().child(aadharLocation).getDownloadURL();
        widget.imageHandling[0].url = aadharUrl;
      } catch (e) {}
      try {
        String fitnessCertificateUrl = await storage
            .ref()
            .child(fitnessCertificateLocation)
            .getDownloadURL();
        widget.imageHandling[2].url = fitnessCertificateUrl;
      } catch (e) {}
      try {
        String idUrl = await storage.ref().child(idLocation).getDownloadURL();
        widget.imageHandling[1].url = idUrl;
      } catch (e) {}

      widget.isLoading = false;
      setState(() {});
    }
  }

  Future<int> uploadImage() async {
    String? email = widget._auth.currentUser!.email;
    if (email != null) {
      String aadhar = 'aadhar-card/$email.png';
      String id = 'id-card/$email.png';
      String fitnessCertificate = 'fitness-certificate/$email.png';

      final storageRef1 = FirebaseStorage.instance.ref().child(aadhar);
      final storageRef2 = FirebaseStorage.instance.ref().child(id);
      final storageRef3 =
          FirebaseStorage.instance.ref().child(fitnessCertificate);
      try {
        final UploadTask uploadTask1 =
            storageRef1.putFile(widget.imageHandling[0].getImage());

        await uploadTask1.whenComplete(() => {});
      } catch (e) {
        return 0;
      }
      try {
        final UploadTask uploadTask2 =
            storageRef2.putFile(widget.imageHandling[1].getImage());

        await uploadTask2.whenComplete(() => {});
      } catch (e) {
        return 0;
      }
      try {
        final UploadTask uploadTask3 =
            storageRef3.putFile(widget.imageHandling[0].getImage());

        await uploadTask3.whenComplete(() => {});
      } catch (e) {
        return 0;
      }
      return 1;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: widget.isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Upload Documents"),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Center(child: Text("Upload Files")),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: [
                          ElevatedButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                              setState(() {
                                widget.isLoading = true;
                              });
                              int response = await uploadImage();
                              if (response == 1) {
                                setState(() {
                                  widget.isLoading = false;
                                });
                                showDialog(
                                    context: _context,
                                    builder: (_context) {
                                      return AlertDialog(
                                        title: const Center(
                                            child: Text("Upload Successfull")),
                                        actions: [
                                          Center(
                                            child: FloatingActionButton(
                                              backgroundColor: Colors.green,
                                              onPressed: () {
                                                Navigator.of(_context).pop();
                                              },
                                              child: const Text("Close"),
                                            ),
                                          )
                                        ],
                                      );
                                    });
                              } else {
                                setState(() {
                                  widget.isLoading = false;
                                });
                                showDialog(
                                    context: _context,
                                    builder: (_context) {
                                      return AlertDialog(
                                        title: const Center(
                                            child: Text("Upload Failed")),
                                        actions: [
                                          Center(
                                            child: FloatingActionButton(
                                              backgroundColor: Colors.red,
                                              onPressed: () {
                                                Navigator.of(_context).pop();
                                              },
                                              child: const Text("Close"),
                                            ),
                                          )
                                        ],
                                      );
                                    });
                              }
                            },
                            style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll<Color>(Colors.green),
                            ),
                            child: const Text(
                              "Yes",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll<Color>(Colors.red),
                            ),
                            child: const Text(
                              "No",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      );
                    });
              },
              child: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: Column(
          children: [
            myUploadButton(
                text: "Adhar Card",
                image: 'assets/aadhar.png',
                imageHandling: widget.imageHandling[0],
                context: context),
            myUploadButton(
                text: "Adhar Card",
                image: 'assets/id_card.png',
                imageHandling: widget.imageHandling[1],
                context: context),
            myUploadButton(
                text: "Adhar Card",
                image: 'assets/medical_fitness.png',
                imageHandling: widget.imageHandling[2],
                context: context),
          ],
        ),
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
                  try {
                    String url = imageHandling.getUrl();
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Center(
                            child: Image.network(
                              url,
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
