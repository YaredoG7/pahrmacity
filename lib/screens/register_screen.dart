import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:splash/services/firebase_service.dart';

import 'account_screen.dart';

class CustomRegisterScreen extends StatefulWidget {
  static const String id = "register-screen";
  const CustomRegisterScreen({super.key});

  @override
  State<CustomRegisterScreen> createState() => _CustomRegisterScreenState();
}

class _CustomRegisterScreenState extends State<CustomRegisterScreen> {
  final FirebaseService _service = FirebaseService();
  final _formKey = GlobalKey<FormState>();
  final _businessName = TextEditingController();
  final _contactNumber = TextEditingController();
  final _email = TextEditingController();
  final _productName = TextEditingController();
  String? _bName;
  String? _product;
  String? _shopImageUrl;
  String? _logoImageUrl;
  XFile? _shopImage;
  XFile? _logoImage;

  final ImagePicker _picker = ImagePicker();

  /* Modular Form Field */
  Widget _formField(
      {TextEditingController? controller,
      String? label,
      TextInputType? type,
      validator,
      Widget? prefixIcon,
      String? prefixlabel,
      void Function(String)? changed}) {
    return TextFormField(
      controller: controller,
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
    if (_shopImage == null) {
      _scaffold('Cover Image is not selected');
      return;
    }

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
                    _shopImage == null
                        ? Container(
                            color: Colors.blue,
                            height: 240,
                            child: Center(
                              child: TextButton(
                                onPressed: () {
                                  _pickImage().then((value) {
                                    setState(() {
                                      _shopImage = value;
                                    });
                                  });
                                },
                                child: Text(
                                  'Tap to add profile cover image',
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              _pickImage().then((value) {
                                setState(() {
                                  _shopImage = value;
                                });
                              });
                            },
                            child: Container(
                              height: 240,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                image: DecorationImage(
                                    opacity: 100,
                                    image: FileImage(File(_shopImage!.path)),
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
                        actions: [
                          IconButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                            },
                            icon: const Icon(Icons.exit_to_app),
                          ),
                        ],
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
                        controller: _businessName,
                        label: "Business Name",
                        type: TextInputType.text,
                        prefixIcon: const Icon(Icons.badge_outlined),
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
                        controller: _contactNumber,
                        label: "Phone Number",
                        prefixlabel: '+43',
                        prefixIcon: const Icon(Icons.phone),
                        type: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Phone is required';
                          }
                          return null;
                        }),
                    _formField(
                        controller: _email,
                        label: "Email ",
                        prefixIcon: const Icon(Icons.email_outlined),
                        type: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          return null;
                        }),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text("Do you have product"),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: DropdownButtonFormField(
                            value: _product,
                            hint: const Text("Select one"),
                            items: <String>['Yes', 'No']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
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
                    ),
                    if (_product == "Yes")
                      _formField(
                        controller: _productName,
                        label: "Product Name ",
                        prefixIcon: const Icon(Icons.precision_manufacturing),
                        type: TextInputType.text,
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
