import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:splash/screens/home_screen.dart';
import 'package:splash/services/firebase_service.dart';

class RegisterHomeCam extends StatefulWidget {
  static const String id = "register-cam-screen";
  const RegisterHomeCam({super.key});

  @override
  State<RegisterHomeCam> createState() => _RegisterHomeCamState();
}

class _RegisterHomeCamState extends State<RegisterHomeCam> {
  final FirebaseService _service = FirebaseService();
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _localUrl = TextEditingController();
  final _remoteUrl = TextEditingController();
  final _description = TextEditingController();
  final _group = TextEditingController();
  String? _bName;
  // String? _product;
  bool? isMain = false;
  String? _logoImageUrl;
  XFile? _logoImage;
  final ImagePicker _picker = ImagePicker();

  Widget _formField(
      {TextEditingController? controller,
      String? label,
      TextInputType? type,
      validator,
      Widget? prefixIcon,
      int? mnline,
      int? mxline,
      String? prefixlabel,
      void Function(String)? changed}) {
    return TextFormField(
      controller: controller,
      minLines: mnline,
      maxLines: mxline,
      keyboardType: type,
      decoration: InputDecoration(
          labelText: label, prefixText: prefixlabel, prefixIcon: prefixIcon),
      validator: validator,
      onChanged: changed,
    );
  }

  Future<XFile?> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  _scaffold(message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
      ),
      action: SnackBarAction(
        label: "OK",
        onPressed: () {
          ScaffoldMessenger.of(context).clearSnackBars();
        },
      ),
    ));
  }

  _saveToDb() {
    if (_logoImage == null) {
      _scaffold('Logo not selected');
      return;
    }
    if (_formKey.currentState!.validate()) {
      // show spinner
      EasyLoading.show(status: 'please wait...');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 240,
                child: Stack(
                  children: [
                    InkWell(
                      child: Container(
                        height: 240,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          image: DecorationImage(
                              opacity: 200,
                              image: AssetImage('assets/images/cctv.jpg'),
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.low),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      child: AppBar(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        actions: [],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                _pickImage().then((value) {
                                  setState(() {
                                    _logoImage = value;
                                  });
                                });
                              },
                              child: Card(
                                elevation: 4,
                                child: _logoImage == null
                                    ? const SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: Center(child: Text("+")),
                                      )
                                    : SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: Image.file(
                                          File(_logoImage!.path),
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              _bName == null ? '' : _bName!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: Column(
                  children: [
                    _formField(
                        controller: _name,
                        label: "Camera Name",
                        type: TextInputType.text,
                        prefixIcon: const Icon(Icons.camera_alt_outlined),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                        changed: (value) {
                          setState(() {
                            _bName = value;
                          });
                        }),
                    _formField(
                        controller: _localUrl,
                        label: "Local Address",
                        prefixlabel: '192.168.',
                        prefixIcon: const Icon(Icons.ads_click_rounded),
                        type: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'local address is required';
                          }
                          return null;
                        }),
                    _formField(
                      controller: _remoteUrl,
                      label: "Remote Address (optional)",
                      prefixIcon: const Icon(Icons.settings_remote_outlined),
                      type: TextInputType.text,
                    ),
                    _formField(
                      controller: _group,
                      label: "Camera Group",
                      type: TextInputType.text,
                      prefixIcon: const Icon(Icons.speaker_group),
                    ),
                    const SizedBox(height: 10),
                    /*  CheckboxListTile(
                      title: const Text('Main Camera'),
                      value: isMain,
                      onChanged: (bool? value) {
                        setState(() {
                          isMain = value ?? false;
                        });
                      },
                    ),
                    */ // replace dropdown with checkbox
                    /* Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: DropdownButtonFormField(
                            value: _product,
                            hint: const Text(
                              "Select Status",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            items: <String>['Active', 'Offline']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _product = value;
                              });
                            },
                          ),
                        )
                      ],
                    ), */
                    _formField(
                      controller: _description,
                      label: "Description",
                      type: TextInputType.multiline,
                      mnline: 2,
                      mxline: null,
                      prefixIcon: const Icon(Icons.edit_note_sharp),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        persistentFooterButtons: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    // style: ButtonStyle(backgroundColor: Colors.blue),
                    onPressed: _saveToDb,
                    child: const Text("Register"),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
