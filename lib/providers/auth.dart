import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthPro with ChangeNotifier {
  String? token;
  DateTime? expiryDate;
  String? userId;

  static const apiKey = "AIzaSyD2AEsDmyMUrilnpPPPxc2Eb5TCgZteoPA";

  Future<void> signUp(String email, String password) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyD2AEsDmyMUrilnpPPPxc2Eb5TCgZteoPA');
    final response = await http.post(
      url,
      body: jsonEncode(
        {
          "email": email,
          "password": password,
          "returnSecureToken": true,
        },
      ),
    );
    print(jsonDecode(response.body));
  }

  Future<void> signIn(String email, String password) async {
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyD2AEsDmyMUrilnpPPPxc2Eb5TCgZteoPA");
    final response = await http.post(
      url,
      body: jsonEncode(
        {
          "email": email,
          "password": password,
          "returnSecureToken": true,
        },
      ),
    );
    print(jsonDecode(response.body));
  }
}
