import 'package:flutter/material.dart';
import '../provider/auth.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  static const routedname = '/AuthPage';
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool _login = false, _visability = true, isSubmiting = false;
  var responseData;
  var userName, email, password;
  final formKey = GlobalKey<FormState>();
  Widget widgetTextFormField(
    String text,
    String hintText,
    Icon icon,
    bool secure,
    Function func,
    Function func2,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        onSaved: func2,
        validator: func,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: text,
          icon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  void _showSuccesedSnackBar() {
    var snackBar = SnackBar(
      content: Text(
        _login
            ? 'userName:$userName login succefully'
            : 'userName:$userName Registiration succefully',
        style: TextStyle(color: Colors.green),
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
    formKey.currentState.reset();
  }

  void _showUnSuccesedSnackBar(String errorMessage) {
    var snackBar = SnackBar(
      content: Text(
        _login
            ? 'errorMessage:$errorMessage login failed'
            : 'errorMessage:$errorMessage Registiration failed',
        style: TextStyle(color: Colors.red),
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
    throw Exception(_login
        ? 'Error login $errorMessage'
        : 'Error Registration $errorMessage');
  }

  Future<void> _auth() async {
    setState(() {
      isSubmiting = true;
    });
    try {
      _login
          ?  Provider.of<Auth>(context, listen: false).auth(
              email: email,
              login: true,
              password: password,
              responseData: responseData,
              userName: userName)
          : Provider.of<Auth>(context, listen: false).auth(
              email: email,
              login: false,
              password: password,
              responseData: responseData,
              userName: userName);
      setState(() {
        isSubmiting = false;
      });
      _showSuccesedSnackBar();
      Navigator.pushReplacementNamed(context, '/Products');
    } catch (_) {
      setState(() {
        isSubmiting = false;
      });
      final errorMessage = responseData['error'];
      _showUnSuccesedSnackBar(errorMessage);
    }
  }

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      _auth();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Center(
          child: Text('Register'),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(padding: const EdgeInsets.only(top: 20)),
                  Text(
                    _login ? 'Login' : 'Register',
                    style: Theme.of(context).textTheme.headline,
                  ),
                  _login
                      ? Container()
                      : widgetTextFormField(
                          'UserName',
                          'Enter user Name',
                          Icon(Icons.face),
                          false,
                          (val) => _login
                              ? null
                              : val.length <= 3
                                  ? 'طول الاسم حبه'
                                  : null,
                          (val) => userName = val),
                  widgetTextFormField(
                      'E-mail',
                      'Enter ur E-mail',
                      Icon(Icons.mail),
                      false,
                      (val) => !val.contains('@') ? "invalid E-mail" : null,
                      (val) => email = val),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      onSaved: (val) => password = val,
                      validator: (val) =>
                          val.length < 6 ? 'طول الباس حبه' : null,
                      obscureText: _visability,
                      decoration: InputDecoration(
                        hintText: 'Enter a password',
                        suffixIcon: GestureDetector(
                          child: _visability
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                          onTap: () {
                            setState(() {
                              _visability = !_visability;
                            });
                          },
                        ),
                        labelText: 'password',
                        icon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: isSubmiting == true
                        ? Center(
                            child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                                Theme.of(context).primaryColor),
                          ))
                        : RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            onPressed: _submit,
                            color: _login
                                ? Theme.of(context).accentColor
                                : Theme.of(context).primaryColor,
                            child: Text(
                              'Submit',
                              style: Theme.of(context)
                                  .textTheme
                                  .body1
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                  ),
                  FlatButton(
                      onPressed: () {
                        setState(() {
                          _login = !_login;
                        });
                      },
                      child: Text(
                        _login ? 'New user? Register' : 'Exiting user? Login',
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
