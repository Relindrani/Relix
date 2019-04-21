import 'package:flutter/material.dart';

import '../services/authentication.dart';

class LoginPage extends StatefulWidget{
  LoginPage({this.auth, this.onSignedIn});

  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

enum FormMode { LOGIN, SIGNUP }

/**
 * *Login page to create and authenticate accounts
 * *Has enum for if the form is to signup or login
 * *form state key to validate and save information
 */
class _LoginPageState extends State<LoginPage>{
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;

  FormMode _formMode;
  bool _isLoading;

  @override
  void initState(){
    super.initState();
    _errorMessage = "";
    _formMode = FormMode.LOGIN; 
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      backgroundColor: Color.fromARGB(150, 56, 4, 84),
      body: Material(
        color: Colors.transparent,
        child: new Stack(
          children: <Widget>[
            _showBody(),
            _showCircularProgress()
          ],
        )
      )
    );
  }

  Widget _showBody(){
    return new Container(
      padding: EdgeInsets.all(16.0),
      child: new Form(
        key: _formKey,
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            _showLogo(),
            _showEmailInput(),
            _showPasswordInput(),
            _showPrimaryButton(),
            _showSecondaryButton(),
            _showErrorMessage()
          ],
        ),
      ),
    );
  }

  //*Shows loading indicator if waiting
  Widget _showCircularProgress(){
    return _isLoading ? Center(child: CircularProgressIndicator()) : Container(height: 0.0, width: 0.0);
  }

  //*Shows logo
  Widget _showLogo(){
    return new Hero(
      tag: "hero",
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
        child: Container(
          height: 200.0,
          child: Image.asset('lib/assets/relix_logo_banner.png')
        ),
      )
    );
  }

  //*Show text field for email input, validates that it isn't empty
  Widget _showEmailInput(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new TextFormField(
        style: TextStyle(
          color: Colors.white,
        ),
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Email',
          hintStyle: TextStyle(
            color: Colors.white
          ),
          icon: new Icon(
            Icons.mail,
            color: Colors.grey
          )
        ),
        validator: (value) => value.isEmpty ? 'Email cannot be empty' : null,
        onSaved: (value) => _email = value,
      ),
    );
  }

  //*Show text field for password input, hides text, validates that it isn't empty
  Widget _showPasswordInput(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        style: TextStyle(
          color: Colors.white
        ),
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Password',
          hintStyle: TextStyle(
            color: Colors.white
          ),
          icon: new Icon(
            Icons.lock,
            color: Colors.grey
          )
        ),
        validator: (value) => value.isEmpty ? 'Password cannot be empty' : null,
        onSaved: (value) => _password = value,
      ),
    );
  }

  //*Primary button submits information in form
  Widget _showPrimaryButton(){
    return new Padding(
      padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
      child: new MaterialButton(
        elevation: 5.0,
        minWidth: 200.0,
        height: 42.0,
        color: Color.fromARGB(255, 6, 98, 157),
        child: _formMode == FormMode.LOGIN ? new Text(
          "Login",
          style: new TextStyle(
            fontSize: 20.0,
            color: Colors.white
          ),
        ) : new Text(
          "Create Account",
          style: new TextStyle(
            fontSize: 20.0,
            color: Colors.white
          ),
        ),
        onPressed: _validateAndSubmit,
      )
    );
  }

  //*Secondary button switches form between login and signup
  Widget _showSecondaryButton(){
    return new FlatButton(
      child: _formMode == FormMode.LOGIN ? new Text(
        "Create an account",
        style: new TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.w300
        ),
      ) : new Text(
        "Have an account? Sign in.",
        style: new TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.w300
        ),
      ),
      onPressed: _formMode == FormMode.LOGIN ? _changeFormToSignup : _changeFormToLogin,
    );
  }

  //*Displays any error message
  Widget _showErrorMessage(){
    if(_errorMessage.length > 0 && _errorMessage != null){
      return new Text(
        _errorMessage,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize:18.0,
          color: Colors.red,
          height: 1.0,
          fontWeight: FontWeight.w300,
        ),
      );
    } else{
      return new Container(height: 0.0);
    }
  }
  //*Changes form to signup form
  void _changeFormToSignup(){
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.SIGNUP; 
    });
  }
  //*Changes form to login form
  void _changeFormToLogin(){
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.LOGIN; 
    });
  }

  /**
   * *checks for form is validates then either signs in or signs user up with information
   * *If signing in, checks that it was successful then continues to landing page (called from root page)
   * *If signing up, sends email verification and goes to login form
   */
  void _validateAndSubmit() async{
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if(_validateAndSave()){
      String userId = "";
      try{
        if(_formMode == FormMode.LOGIN){
          userId = await widget.auth.signIn(_email, _password);
          print("Signed in: $userId");
        } else{
          userId = await widget.auth.signUp(_email, _password);
          widget.auth.sendEmailVerification();
          _showVerifyEmailSentDialog();
          print("Signed up user: $userId");
        }
        setState(() {
          _isLoading = false;
        });
        if(userId.length > 0 && userId != null && _formMode == FormMode.LOGIN) widget.onSignedIn();
      } catch(e){
        print("Error: $e");
        setState(() {
          _isLoading = false;
          _errorMessage = e.message; 
        });
      }
    }
  }
  //*Validates and saves form information
  bool _validateAndSave(){
    final form = _formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  //*Shows dialog box that email verification was sent
  void _showVerifyEmailSentDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: new Text("Verify your account"),
          content: new Text("A link to verify your account has been sent to your email."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: (){
                _changeFormToLogin();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }
}