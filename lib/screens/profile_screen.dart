import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../services/firebase_service.dart';

class UserProfileWidget extends StatefulWidget {
  static const String id = "profile-screen";
  @override
  _UserProfileWidgetState createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
  final FirebaseService _service = FirebaseService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _displayName = TextEditingController();
  DateTime? created;
  DateTime? signedIn;
  bool? verifiedAccount = false;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    // Fetch user data from API
    setupUserProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void setupUserProfile() {
    _emailController.text = _service.user!.email!;
    _displayName.text = _service.user!.displayName!;
    created = _service.user!.metadata.creationTime;
    signedIn = _service.user!.metadata.lastSignInTime;
    verifiedAccount = _service.user!.emailVerified;
  }

  void _toggleEditingMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(_service.user!.metadata.creationTime);
    return Scaffold(
        //backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
          backgroundColor: Colors.blue.shade600,
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/user.png'),
                  radius: 40,
                ),
              ),
              Divider(
                height: 60,
                color: Colors.grey[800],
              ),
              _isEditing
                  ? TextFormField(
                      controller: _displayName,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                    )
                  : Row(
                      children: <Widget>[
                        Icon(
                          Icons.person_outline_rounded,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          _displayName.text.isNotEmpty
                              ? _displayName.text
                              : "No Name",
                          style: TextStyle(
                              color: Colors.blueGrey[400],
                              letterSpacing: 2,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
              const SizedBox(height: 20),
              _isEditing
                  ? TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone',
                      ),
                    )
                  : Row(
                      children: <Widget>[
                        Icon(
                          Icons.phone,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          _phoneController.text,
                          style: TextStyle(
                              color: Colors.amberAccent[200],
                              letterSpacing: 2,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
              const SizedBox(height: 20),
              _isEditing
                  ? TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                    )
                  : Row(
                      children: <Widget>[
                        Icon(
                          Icons.email,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          _emailController.text,
                          style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 18,
                              letterSpacing: 1),
                        ),
                      ],
                    ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Icon(
                    verifiedAccount! ? Icons.check_box : Icons.dangerous,
                    color: verifiedAccount!
                        ? Colors.green.shade700
                        : Colors.red.shade800,
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    "Verified account  ",
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 18,
                        letterSpacing: 1),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Last Log-in:',
                style: TextStyle(
                    color: Colors.grey, letterSpacing: 2, fontSize: 18),
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.input_rounded,
                    color: Colors.green.shade800,
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    signedIn!.toLocal().toString(),
                    style: TextStyle(
                        color: Colors.blueGrey[400],
                        fontSize: 14,
                        letterSpacing: 1),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Member since:',
                style: TextStyle(
                    color: Colors.grey, letterSpacing: 2, fontSize: 18),
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  const Icon(
                    Icons.cases_outlined,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    created!.toLocal().toString(),
                    style: TextStyle(
                        color: Colors.blueGrey[400],
                        fontSize: 14,
                        letterSpacing: 1),
                  ),
                ],
              ),
              const SizedBox(height: 100),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    if (_isEditing) {
                      // Save profile changes
                      _saveDB();
                    } else {
                      // Switch to editing mode
                      _toggleEditingMode();
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      _isEditing
                          ? Colors.green
                          : Colors.blue, // Set the desired background color
                    ),
                  ),
                  child: Text(
                    _isEditing ? 'Save' : 'Update',
                    style: const TextStyle(
                        color: Colors.white, fontSize: 18, letterSpacing: 1),
                  ),
                ),
              ),
            ],
          ),
        )));
  }

  _saveDB() {
    EasyLoading.show(status: 'updating...');
    _service.user?.updateDisplayName(_displayName.text).then((value) async {
      /*
       PhoneAuthCredential credential =
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+44 7123 123 456',
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {},
          codeSent: (String verificationId, int? resendToken) {},
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
        */
      await _service.user!.updateEmail(_emailController.text);
      // await _service.user!.updatePhoneNumber({phoneNumber: _phoneController.text} as PhoneAuthCredential);
    }).whenComplete(() => {
          EasyLoading.dismiss(),
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Profile Updated'),
                content: const Text('Profile information has been updated.'),
                actions: [
                  ElevatedButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          )
        });
  }
}
