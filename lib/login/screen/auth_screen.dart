import 'package:codexia_learning/login/screen/login_screen.dart';
import 'package:codexia_learning/login/screen/phone_screen.dart';
import 'package:codexia_learning/shared/colour_const.dart';
import 'package:codexia_learning/shared/string_const.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(StringConst.authentication),
          backgroundColor: ColourConst.blue,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const LoginScreen();
                    }));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(StringConst.googleText),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const PhoneScreen();
                      }));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(StringConst.phoneText),
                      ],
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
