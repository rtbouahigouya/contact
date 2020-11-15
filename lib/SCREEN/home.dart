import 'package:contact/CONSTANT/couleur.dart';
import 'package:contact/CUSTOMWIDGET/backgroundwidget.dart';
import 'package:contact/CUSTOMWIDGET/bouncetransition.dart';
import 'package:contact/SCREEN/listcontact.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  double H, W;
  String _email = '', _password = '';

  @override
  Widget build(BuildContext context) {
    H = MediaQuery.of(context).size.height;
    W = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: H,
        width: W,
        child: CustomPaint(
          painter: BackgroundPaint(),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                child: Column(
                  children: [
                    SizedBox(
                      height: H * .2,
                    ),
                    TextFormField(
                      validator: (value) =>
                          !value.contains('@') ? 'email invalide' : null,
                      onSaved: (newValue) => _email = newValue,
                      decoration: InputDecoration(
                          labelText: 'email',
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    SizedBox(
                      height: H * .05,
                    ),
                    TextFormField(
                      validator: (value) =>
                          value.length < 6 ? 'mot de passe court' : null,
                      onSaved: (newValue) => _password = newValue,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'mot de passe',
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    SizedBox(
                      height: H * .05,
                    ),
                    Container(
                      height: H * .09,
                      width: W * .5,
                      child: RaisedButton(
                        color: btncolor,
                        textColor: Colors.white,
                        elevation: 3,
                        onPressed: submit,
                        child: Text(
                          'Valider',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  submit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      _auth.signInWithEmailAndPassword(email: _email, password: _password).then(
          (value) =>
              Navigator.push(context, BounceTransition(widget: ListContact())));
    } else {
      _email = _password = '';
    }
  }
}
