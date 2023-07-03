import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class AddImage extends StatefulWidget {
  const AddImage({super.key});

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  final TextEditingController title = TextEditingController();
  final TextEditingController desc = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  File? imageFile;
  bool loading = false;
  final cookbox = Hive.box("CookBox");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D2228),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFB8122),
        title: const Text(
          "Upload Recipe",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Form(
        key: formGlobalKey,
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showChoiceDialog(context);
                          },
                          child: imageFile == null
                              ? Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                    child: Container(
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFFB8122),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(3.0),
                                          child: Icon(Icons.add,
                                              color: Colors.white),
                                        )),
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.file(imageFile!,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      fit: BoxFit.cover),
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 8),
                      // ignore: avoid_unnecessary_containers
                      child: Container(
                        child: TextFormField(
                          maxLines: 1,
                          validator: (value) {
                            if (value == "") {
                              return "Enter the Recipe Name";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          onChanged: (value) {},
                          controller: title,
                          autofocus: false,
                          style: const TextStyle(
                              fontSize: 15.0,
                              color: Color.fromRGBO(0, 0, 0, 1)),
                          decoration: InputDecoration(
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  // width: 3,
                                  color: Colors.red), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  // width: 3,
                                  color: Colors.red), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  // width: 3,
                                  color: Colors.grey), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                // width: 3,
                                color: Color(0xFFFB8122),
                              ), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Enter the Title',
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 20.0, top: 20.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 8),
                      // ignore: avoid_unnecessary_containers
                      child: Container(
                        child: TextFormField(
                          maxLines: 5,
                          validator: (value) {
                            if (value == "") {
                              return "Enter the Full Recipe";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          onChanged: (value) {},
                          controller: desc,
                          autofocus: false,
                          style: const TextStyle(
                              fontSize: 15.0,
                              color: Color.fromRGBO(0, 0, 0, 1)),
                          decoration: InputDecoration(
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  // width: 3,
                                  color: Colors.red), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  // width: 3,
                                  color: Colors.red), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  // width: 3,
                                  color: Colors.grey), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                // width: 3,
                                color: Color(0xFFFB8122),
                              ), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Enter the Description',
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 20.0, top: 20.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // const Spacer(),
                InkWell(
                  onTap: () {
                    if (formGlobalKey.currentState!.validate() &&
                        imageFile != null) {
                      setState(() {
                        loading = true;
                      });
                      cookbox.add({
                        "img": imageFile!.path,
                        "name": title.text,
                        "desc": desc.text
                      }).then((value) {
                        setState(() {
                          imageFile = null;
                          title.clear();
                          desc.clear();
                        });
                      });
                      setState(() {
                        loading = false;
                      });
                    }
                  },
                  child: Center(
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: BoxDecoration(
                          color: const Color(0xFFFB8122),
                          borderRadius: BorderRadius.circular(25.0)),
                      child: Center(
                        child: loading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text(
                                'Upload',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getFromGallery() async {
    // ignore: deprecated_member_use
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    // ignore: deprecated_member_use
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Choose Option',
              style: TextStyle(
                color: Color(0xFFFB8122),
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 0,
                    color: Colors.blue[50],
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _getFromGallery();
                    },
                    title: const Text('Gallery'),
                    leading: const Icon(
                      Icons.image,
                      color: Color(0xFFFB8122),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.blue[50],
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _getFromCamera();
                    },
                    title: const Text('Camera'),
                    leading: const Icon(
                      Icons.camera_alt_rounded,
                      color: Color(0xFFFB8122),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
