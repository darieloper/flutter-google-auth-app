import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_auth_app/provider/google_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: FlatButton(
            padding: EdgeInsets.fromLTRB(10, 10, 15, 10),
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignAuthProvider>(context, listen: false);
              provider.login();
            },
            color: Colors.redAccent,
            child: Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5, right: 15),
                  child: FaIcon(
                    FontAwesomeIcons.google,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Sign In with Google",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ))));
  }
}
