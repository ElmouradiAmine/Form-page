import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter form demo',
      debugShowCheckedModeBanner: false,
      home: FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  bool loggedIn = false;
  final _formKey = GlobalKey<FormState>();
  final _mainKey = GlobalKey<ScaffoldState>();
  String _email, _username, _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _mainKey,
      appBar: AppBar(
        title: Text('Flutter Form Demo'),
      ),
      body: !loggedIn
          ? Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      autocorrect: false,
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: 'Email:',
                      ),
                      validator: (value) =>
                          !value.contains('@') ? 'Not a valid Email' : null,
                      onSaved: (value) => _email = value,
                    ),
                    TextFormField(
                      autocorrect: false,
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: 'Username:',
                      ),
                      validator: (value) =>
                          value.length <= 5 ? 'Not a valid Username' : null,
                      onSaved: (value) => _username = value,
                    ),
                    TextFormField(
                      obscureText: true,
                      autocorrect: false,
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: 'Password:',
                      ),
                      validator: (value) =>
                          value.length <= 5 ? 'Not a valid Password' : null,
                      onSaved: (value) => _password = value,
                    ),
                    RaisedButton(
                      onPressed: _submit,
                      child: Text('Submit'),
                    )
                  ],
                ),
              ),
            )
          : Center(
              child: Column(
                children: <Widget>[
                  Text('Welcome $_username'),
                  RaisedButton(
                    onPressed: _logOut,
                    child: Text('Log Out'),
                  )
                ],
              ),
            ),
    );
  }

  void _submit() {
    var form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        loggedIn = true;
      });

      final SnackBar snackbar = SnackBar(
        duration: Duration(milliseconds: 5000),
        content:
            Text('Username: $_username Email: $_email Password: $_password'),
      );

      _mainKey.currentState.showSnackBar(snackbar);
    }
  }

  void _logOut() {
    setState(() {
      loggedIn = false;
    });

    final SnackBar snackbar = SnackBar(
        duration: Duration(milliseconds: 5000),
        content: Text('No comeback :('));
    _mainKey.currentState.showSnackBar(snackbar);
  }
}
