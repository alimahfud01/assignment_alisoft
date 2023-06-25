import 'package:assignment_alisoft/bloc/bloc/auth_bloc.dart';
import 'package:assignment_alisoft/bloc/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:assignment_alisoft/theme/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool _obsText = true;
  bool _errorEmail = false;
  bool _errorPassword = false;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    Navigator.pop(context);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "My APPS",
                  style: TextStyle(
                      color: primary,
                      fontSize: 40,
                      fontWeight: FontWeight.w900),
                ),
              ),
              const SizedBox(height: 20),
              SvgPicture.asset(
                'assets/images/login_vector.svg',
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              const SizedBox(height: 60),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _email,
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'Username',
                  errorText: _errorEmail ? 'Masukkan username' : '',
                  fillColor: primaryLight.withOpacity(0.3),
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: TextField(
                  controller: _password,
                  obscureText: _obsText,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: primaryLight.withOpacity(0.3),
                    hintText: "Password",
                    errorText: _errorPassword ? 'Masukkan password' : '',
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obsText = !_obsText;
                          });
                        },
                        icon: Icon(
                          _obsText ? Icons.visibility : Icons.visibility_off,
                          color: primary,
                        )),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  elevation: 2.0,
                  color: Theme.of(context).primaryColor,
                  clipBehavior: Clip.antiAlias,
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    height: 54,
                    color: primary,
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      _errorEmail = false;
                      _errorPassword = false;
                      setState(() {});
                      final email = _email.text;
                      final password = _password.text;
                      if (password.length < 5 && password.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Password harus lebih dari 5 huruf')));
                      } else if (password.isEmpty && email.isEmpty) {
                        _errorPassword = true;
                        _errorEmail = true;
                        setState(() {});
                      } else if (password.isEmpty) {
                        _errorPassword = true;
                        setState(() {});
                      } else if (email.isEmpty) {
                        _errorEmail = true;
                        setState(() {});
                      } else {
                        context
                            .read<AuthBloc>()
                            .add(AuthEventLogin(email, password));
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
