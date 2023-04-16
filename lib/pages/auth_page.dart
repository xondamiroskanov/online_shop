import 'package:flutter/material.dart';
import 'package:online_shop/providers/auth.dart';
import 'package:provider/provider.dart';

enum Auth { Register, Login }

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _passController = TextEditingController();
  Map<String, String> _authData = {
    "email": "",
    "password": "",
  };

  var _isLoding = false;

  Future<void> submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoding = true;
      });
      if (_auth == Auth.Login) {
        await Provider.of<AuthPro>(context, listen: false)
            .signIn(_authData["email"]!, _authData["password"]!);
      } else {
        await Provider.of<AuthPro>(context, listen: false)
            .signUp(_authData["email"]!, _authData["password"]!);
      }
      setState(() {
        _isLoding = false;
      });
    }
  }

  Auth _auth = Auth.Login;

  void enterAuth() {
    if (_auth == Auth.Login) {
      setState(() {
        _auth = Auth.Register;
      });
    } else {
      setState(() {
        _auth = Auth.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Image.asset(
                    "assets/logo/logo_auth.png",
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Email manzil"),
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return "email kiritilmagan";
                    }
                    if (!email.contains("@")) {
                      return "kuchukcha belgisini kiritish majburiy";
                    }
                    return null;
                  },
                  onSaved: (email) {
                    _authData["email"] = email!;
                  },
                ),
                TextFormField(
                  controller: _passController,
                  decoration: const InputDecoration(labelText: "Parol"),
                  validator: (register) {
                    print(register);
                    if (register == null || register.isEmpty) {
                      return "Parol kiritilmagan";
                    } else if (register.length < 6) {
                      return "parol 6 ta belgidan kam bo'lmasligi kerak";
                    }
                    return null;
                  },
                  onSaved: (password) {
                    // setState(() {
                    _authData["password"] = password!;
                    // });
                  },
                ),
                if (_auth == Auth.Register)
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: "Parolni tasdiqlang"),
                    validator: (confirmedpassword) {
                      if (confirmedpassword == null ||
                          confirmedpassword.isEmpty) {
                        return "tasdiqlash paroli kiritilmadi";
                      }
                      if (_passController.text != confirmedpassword) {
                        return "parollar mos kelmadi";
                      }
                      return null;
                    },
                  ),
                _isLoding
                    ? const CircularProgressIndicator()
                    : Container(
                        margin: const EdgeInsets.all(24),
                        // padding: EdgeInsets.all(20),
                        height: 40,
                        width: 500,
                        child: ElevatedButton(
                          onPressed: () {
                            submit();
                          },
                          child: Text(
                            _auth == Auth.Register
                                ? "Ro'yxatdan o'tish"
                                : "Kirish",
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                TextButton(
                  onPressed: () {
                    enterAuth();
                  },
                  child: Text(
                    _auth == Auth.Register ? "Kirish" : "Ro'yxatdan o'tish",
                    style: const TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
