import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:google_auth_app/provider/google_auth.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  HomeScreen({Key key, this.title}) : super(key: key);

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget loadingIndicator() {
    return Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.red,
      ),
      body: ChangeNotifierProvider(
          create: (context) => GoogleSignAuthProvider(),
          child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              final provider = Provider.of<GoogleSignAuthProvider>(context);

              if (provider.isProcessing) {
                return loadingIndicator();
              } else if (snapshot.hasData) {
                return LoggedWidget();
              }

              return LoginWidget();
            },
          )),
    );
  }
}

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
            'Logged Successfully',
            style: TextStyle(fontSize: 17),
          ),
          Text(
            'Hello ${currentUser.displayName}',
            style: TextStyle(fontSize: 17, color: Colors.grey),
          ),
          Padding(
              padding: EdgeInsets.all(20),
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
