import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_auth_app/provider/google_auth.dart';

class LoggedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            '🎉 Logged Successfully 🎉',
            style: TextStyle(fontSize: 22),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Hello ${currentUser.displayName}',
              style: TextStyle(fontSize: 17, color: Colors.grey),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(10),
              child: FlatButton(
                onPressed: () {
                  final provider = Provider.of<GoogleSignAuthProvider>(context,
                      listen: false);
                  provider.logout();
                },
                color: Colors.redAccent,
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
              )),
        ],
      ),
    );
  }
}
