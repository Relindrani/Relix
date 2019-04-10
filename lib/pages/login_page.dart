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
      backgroundColor: Colors.blueGrey,
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

  Widget _showCircularProgress(){
    return _isLoading ? Center(child: CircularProgressIndicator()) : Container(height: 0.0, width: 0.0);
  }

  Widget _showLogo(){
    return new Hero(
      tag: "hero",
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
        child: Container(
          height: 150.0,
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            boxShadow: [new BoxShadow(color: Colors.white, spreadRadius: -40.0, blurRadius: 50.0)]
          ),
          child: Image.asset('lib/assets/relix_logo_banner2.png')
        ),
      )
    );
  }

  Widget _showEmailInput(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Email',
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

  Widget _showPasswordInput(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Password',
          icon: new Icon(
            Icons.lock,
            color: Colors.grey
          )
        ),
        validator: (value) => value.isEmpty ? 'Email cannot be empty' : null,
        onSaved: (value) => _password = value,
      ),
    );
  }

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

  Widget _showSecondaryButton(){
    return new FlatButton(
      child: _formMode == FormMode.LOGIN ? new Text(
        "Create an account",
        style: new TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w300
        ),
      ) : new Text(
        "Have an account? Sign in.",
        style: new TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w300
        ),
      ),
      onPressed: (){
        _formKey.currentState.reset();
        _errorMessage = "";
        setState(() {
          _formMode = (_formMode == FormMode.LOGIN) ? FormMode.SIGNUP : FormMode.LOGIN; 
        });
      },
    );
  }

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

  void _setForm(FormMode form){
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = form;
    });
  }

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
        if(userId.length > 0 && userId != null) widget.onSignedIn();
      } catch(e){
        print("Error: $e");
        setState(() {
          _isLoading = false;
          _errorMessage = e.message; 
        });
      }
    }
  }
  bool _validateAndSave(){
    final form = _formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }

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
                _setForm(FormMode.LOGIN);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }
}