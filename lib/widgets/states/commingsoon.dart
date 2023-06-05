import 'package:flutter/material.dart';

class ComingSoon extends StatefulWidget {
  const ComingSoon({Key key}) : super(key: key);

  @override
  State<ComingSoon> createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Coming Soon', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            const Text('Stay tuned for updates'),
            Image.asset("assets/images/maintenance_screen.jpeg"),
          ],
        ),
      ),
    );
  }
}