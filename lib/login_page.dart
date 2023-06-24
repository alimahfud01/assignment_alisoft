import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const routeName = "/login-page";
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool _obsText = true;

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "My APPS",
                  style: TextStyle(
                      color: Color.fromARGB(255, 2, 114, 95),
                      fontSize: 40,
                      fontWeight: FontWeight.w900),
                ),
              ),
              SvgPicture.asset(
                'assets/images/login_vector.svg',
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              const SizedBox(height: 60),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _email,
                decoration: InputDecoration(
                  label: Text("email"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6)),
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
                    label: Text("Password"),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obsText = !_obsText;
                          });
                        },
                        icon: Icon(_obsText
                            ? Icons.visibility
                            : Icons.visibility_off)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6)),
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
                    color: Theme.of(context).primaryColor,
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/home-page', (route) => false);
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
