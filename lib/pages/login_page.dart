import 'package:flutter/material.dart';
import 'package:flutter_movies_up_25/domain/login_service.dart';
import 'package:flutter_movies_up_25/pages/home_page.dart';
import 'package:flutter_movies_up_25/utils/alerts.dart';
import 'package:flutter_movies_up_25/utils/nav.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _tLogin = TextEditingController(text: "ricardo");

  final _tSenha = TextEditingController(text: "abc123");

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _msg = "Não fiz login ainda...";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Filmes"),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return "Informe o login";
    }
    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return "Informe a senha";
    }
    return null;
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            Image.asset(
              "assets/images/rpi.jpg",
              width: 150,
              height: 150,
            ),
            TextFormField(
              controller: _tLogin,
              validator: _validateLogin,
              style: TextStyle(color: Colors.green, fontSize: 34),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.blue, fontSize: 34),
                  labelText: "Login"),
            ),
            TextFormField(
              controller: _tSenha,
              validator: _validateSenha,
              style: TextStyle(color: Colors.black, fontSize: 34),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.blue, fontSize: 34),
                  labelText: "Senha"),
              obscureText: true,
            ),
            _button(),
            SizedBox(
              height: 20,
            ),
            Text(
              _msg,
              style: TextStyle(
                fontSize: 36,
              ),
            )
          ],
        ),
      ),
    );
  }

  _button() {
    return RaisedButton(
      color: Colors.blue,
      child: Text(
        "Login",
        style: TextStyle(
          fontSize: 40,
          color: Colors.white,
        ),
      ),
      onPressed: () {
        _onClickLogin();
      },
    );
  }

  _onClickLogin() async {
//    if (!_formKey.currentState.validate()) {
//      return;
//    }
    final login = _tLogin.text;
    final senha = _tSenha.text;
    print("Login: $login, Senha: $senha");

    setState(() {
      _msg = "Login efetuado com sucesso $login";
    });

    final response = await LoginService.login(login, senha);

    if (response.isOk()) {
      push(context, HomePage());
    } else {
      alert(context, "UP", response.msg);
    }
  }
}
