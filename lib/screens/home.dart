import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_auth_app/widgets/logged.dart';
import 'package:google_auth_app/widgets/login.dart';
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
