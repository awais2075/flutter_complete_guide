import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  bool _isValid = true;

  TextFormField _showEmailTextField() {
    return TextFormField(
        focusNode: _emailFocusNode,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        cursorWidth: 1,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
          border: OutlineInputBorder(),
        ),
        onFieldSubmitted: (_) {
          _changeFocusField(context, _emailFocusNode, _passwordFocusNode);
        },
        textInputAction: TextInputAction.next,
        validator: (email) {
          setState(() {
            _isValid = _isValid && EmailValidator.validate(email);
          });
          return null;
        });
  }

  TextFormField _showPasswordTextField() {
    return TextFormField(
        obscureText: true,
        focusNode: _passwordFocusNode,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        cursorWidth: 1,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
          border: OutlineInputBorder(),
        ),
        onFieldSubmitted: (_) {
          _passwordFocusNode.unfocus();
        },
        textInputAction: TextInputAction.done,
        validator: (password) {
          setState(() {
            _isValid = _isValid && !password.isEmpty;
          });
          return null;
        });
  }

  void _changeFocusField(BuildContext context, FocusNode currentFocusNode,
      FocusNode nextFocusNode) {
    currentFocusNode.unfocus();
    FocusScope.of(context).requestFocus(nextFocusNode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20),
              Image.asset('assets/github_logo.png', width: 75, height: 75),
              SizedBox(height: 40),
              Center(
                child: Text(
                  'Sign in to GitHub',
                  style: TextStyle(fontSize: 36, color: Colors.black38),
                ),
              ),
              Visibility(
                visible: !_isValid,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(45, 20, 45, 0),
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  decoration: BoxDecoration(
                      color: const Color(0xffFFDCE0),
                      border: Border.all(
                        color: Colors.black12,
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Incorred username or password',
                        style: TextStyle(
                            color: const Color(0xff86181d),
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _isValid = true;
                          });
                        },
                        icon: Icon(
                          Icons.clear,
                          color: const Color(0xff86181d),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(45, 20, 45, 20),
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(5)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Username or email address',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10),
                      _showEmailTextField(),
                      SizedBox(height: 20),
                      Row(
                        children: <Widget>[
                          Text(
                            'Password',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () => null,
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      _showPasswordTextField(),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        child: RaisedButton(
                          onPressed: () {
                            _isValid = true;
                            _formKey.currentState.validate();
                          },
                          child: Text('Sign in',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                          color: Colors.green,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(45, 0, 45, 0),
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'New to Github?',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () => null,
                      child: Text(
                        'Create an account.',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
