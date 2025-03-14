import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final VoidCallback onLogout;
  final VoidCallback onResetBackendUrl;

  const Menu({
    Key? key,
    required this.onLogout,
    required this.onResetBackendUrl,
  }) : super(key: key);

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
          onResetBackendUrl();
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
