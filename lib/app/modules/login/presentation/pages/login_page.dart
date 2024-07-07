import 'package:flutter/material.dart';
import 'package:myselff_flutter/app/modules/login/presentation/controllers/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.controller});

  final LoginController controller;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  void initState() {
    widget.controller.checkLogin();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('myselff'),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 64),
            const Icon(Icons.join_full, size: 240),
            const Spacer(),
            const Text('Vamos começar ?'),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              icon: ValueListenableBuilder(
                valueListenable: widget.controller.loading,
                builder: (context, value, widget) {
                  if (value) {
                    return const CircularProgressIndicator.adaptive();
                  }
                  return const Icon(Icons.android);
                },
              ),
              onPressed: widget.controller.loginWithGoogle,
              label: const Text('Entrar com Google'),
            ),
            OutlinedButton.icon(
              icon: const Icon(Icons.login),
              onPressed: widget.controller.continueWithoutLogin,
              label: const Text('Continuar sem login'),
            ),
            const SizedBox(height: 100),
          ],
        ),
      )),
    );
  }
}
