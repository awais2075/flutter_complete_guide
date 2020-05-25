import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isObscure = true;
  bool _isProcessing = false;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _updateIcon() {
    setState(() {
      _isObscure = !_isObscure;
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
        key: _scaffoldKey,
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: IgnorePointer(
              ignoring: _isProcessing,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Visibility(child: LinearProgressIndicator(),visible: _isProcessing,),
                      SizedBox(height: 50),
                      Image.asset(
                        'assets/google_logo.png',
                        scale: 3,
                      ),
                      SizedBox(height: 20),
                      Text('Sign in',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w400)),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'with your Google Account. ',
                            style: TextStyle(fontSize: 16),
                          ),
                          InkWell(
                            child: Text('Learn more',
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                            onTap: () => null,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: _showEmailTextField(),
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: _showPasswordTextField(),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: InkWell(
                      child: Text('Forgot email?',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                      onTap: () => null,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                    child: Row(
                      children: <Widget>[
                        RawMaterialButton(
                            onPressed: () => null,
                            child: Text(
                              'Create Account',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w500),
                            )),
                        Spacer(),
                        RaisedButton(
                            color: Colors.blueAccent,
                            onPressed: () {
                              _passwordFocusNode.unfocus();
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  _isProcessing =true;

                                  Future.delayed(Duration(seconds: 5),(){
                                    setState(() {
                                      _isProcessing =false;
                                    });
                                  });
                                });
                              }
                            },
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _showEmailTextField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      focusNode: _emailFocusNode,
      autofocus: false,
      cursorWidth: 1,
      cursorColor: Colors.black12,
      decoration: InputDecoration(
        labelText: 'Email or Phone',
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent)),
        border: OutlineInputBorder(),
      ),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) {
        _changeFocusField(context, _emailFocusNode, _passwordFocusNode);
      },
      validator: (value) {
        return (!EmailValidator.validate(value)) ? 'Please enter email' : null;
      },
    );
  }

  TextFormField _showPasswordTextField() {
    return TextFormField(
        focusNode: _passwordFocusNode,
        obscureText: _isObscure,
        autofocus: false,
        cursorWidth: 1,
        cursorColor: Colors.black12,
        decoration: InputDecoration(
          labelText: 'Password',
          suffixIcon: IconButton(
              icon: (_isObscure)
                  ? (Icon(Icons.visibility_off, color: Colors.grey))
                  : Icon(Icons.visibility, color: Colors.grey),
              onPressed: _updateIcon),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent)),
          border: OutlineInputBorder(),
        ),
        textInputAction: TextInputAction.done,
        onFieldSubmitted: (_) {
          _passwordFocusNode.unfocus();
        },
        validator: (value) {
          return (value.isEmpty) ? 'Please enter password' : null;
        });
  }
}
