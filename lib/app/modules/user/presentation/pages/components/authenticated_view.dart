part of '../user_page.dart';

class _AuthenticatedView extends StatelessWidget {
  const _AuthenticatedView({
    required this.username,
    required this.email,
    required this.onLogoutButtonClicked,
  });

  final String username;
  final String email;
  final Function() onLogoutButtonClicked;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          username,
          style: const TextStyle(fontSize: 24),
        ),
        Text(
          email,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 100),
        OutlinedButton.icon(
          icon: const Icon(Icons.logout),
          onPressed: onLogoutButtonClicked,
          label: const Text('Sair'),
        ),
      ],
    );
  }
}
