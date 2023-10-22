import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Account'),
            subtitle: const Text('Personal settings'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            subtitle: const Text('Update notification preferences'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.record_voice_over),
            title: const Text('Voice Control'),
            subtitle: const Text('Manage voice control settings'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('App Language'),
            subtitle: const Text('Change the language of the app'),
            onTap: () {
              // Navigate to a new screen to select language
              // Or open a dialog to choose language
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            subtitle: const Text('App version, terms, and more'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
