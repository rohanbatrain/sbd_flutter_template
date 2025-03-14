import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatelessWidget {
  final VoidCallback onLogout;
  final VoidCallback onResetBackendUrl;

  const Menu({
    super.key,
    required this.onLogout,
    required this.onResetBackendUrl,
  });

  Future<void> _resetBackendUrl() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('backend_url');
  }

  void _navigateToBackendUrlScreen(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/backend_url', (route) => false);
  }

  Future<void> _showResetBackendUrlConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reset Backend URL Confirmation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to reset the backend URL?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Reset URL'),
              onPressed: () async {
                Navigator.of(context).pop();
                await _resetBackendUrl();
                if (!context.mounted) return;
                _navigateToBackendUrlScreen(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: CircleAvatar(
        child: Icon(Icons.person),
      ),
      onSelected: (String result) {
        if (result == 'logout') {
          onLogout();
        } else if (result == 'reset_backend_url') {
          _showResetBackendUrlConfirmationDialog(context);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'logout',
          child: Text('Logout'),
        ),
        const PopupMenuItem<String>(
          value: 'reset_backend_url',
          child: Text('Reset Backend URL'),
        ),
      ],
    );
  }
}
