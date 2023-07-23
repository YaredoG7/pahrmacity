import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class AccountScreen extends StatefulWidget {
  static const String id = "account-screen";
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isDarkModeEnabled = false;
  bool isRemote = false;
  bool isNotificationEnabled = true;
  String selectedLanguage = 'English';
  final store = GetStorage();

  @override
  void initState() {
    super.initState();
    bool rm = store.read('remote');
    if (rm) {
      isRemote = rm;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
            child: Text(
              'Access Mode',
              style: TextStyle(color: Colors.grey, letterSpacing: 2),
            ),
          ),
          Divider(
            height: 20,
            color: Colors.grey[800],
          ),
          SwitchListTile(
            title: const Text('Remote Access'),
            value: isRemote,
            onChanged: (value) {
              setState(() {
                isRemote = value;
              });
              // set the access mode
              store.write('remote', value);
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
            child: Text(
              'App Setting',
              style: TextStyle(color: Colors.grey, letterSpacing: 2),
            ),
          ),
          Divider(
            height: 20,
            color: Colors.grey[800],
          ),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: isDarkModeEnabled,
            onChanged: (value) {
              setState(() {
                isDarkModeEnabled = value;
              });
            },
          ),
          CheckboxListTile(
            title: const Text('Enable Notifications'),
            value: isNotificationEnabled,
            onChanged: (value) {
              setState(() {
                isNotificationEnabled = value!;
              });
            },
          ),
          ListTile(
            title: const Text('Language'),
            trailing: DropdownButton<String>(
              value: selectedLanguage,
              onChanged: (newValue) {
                setState(() {
                  selectedLanguage = newValue!;
                });
              },
              items: ['English', 'Spanish', 'French'].map((language) {
                return DropdownMenuItem<String>(
                  value: language,
                  child: Text(language),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
