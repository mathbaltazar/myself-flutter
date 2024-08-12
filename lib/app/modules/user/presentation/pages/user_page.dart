import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myselff_flutter/app/core/components/containers/conditional.dart';
import 'package:myselff_flutter/app/core/components/icons/circular_progress_icon.dart';
import 'package:myselff_flutter/app/core/components/icons/google_icon.dart';
import 'package:myselff_flutter/app/core/extensions/object_extensions.dart';
import 'package:myselff_flutter/app/modules/user/presentation/controllers/user_controller.dart';
import 'package:signals/signals_flutter.dart';

part 'components/user_image.dart';
part 'components/authenticated_view.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key, required this.controller});

  final UserController controller;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (mounted) {
      widget.controller.getUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuário'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Watch.builder(
                builder: (_) => _UserImage(
                      url: widget.controller.user.get().imageUrl ?? '',
                      size: 240,
                    )),
            Watch.builder(
                builder: (_) => Conditional(
                      widget.controller.user.get().authenticated,
                      onCondition: _AuthenticatedView(
                        username:
                            widget.controller.user.get().name ?? 'Nome desconhehcido',
                        email: widget.controller.user.get().email ??
                            'Email desconhehcido',
                        onLogoutButtonClicked: widget.controller.onLogoutButtonClicked,
                      ),
                      onElse: Column(
                        children: [
                          const Text('Vamos começar ?'),
                          const SizedBox(height: 20),
                          FilledButton.icon(
                            icon: Conditional(
                              widget.controller.loading.get(),
                              onCondition: const CircularProgressIcon(),
                              onElse: const GoogleIcon(),
                            ),
                            onPressed: widget.controller.onLoginWithGoogleClicked,
                            label: const Text('Entrar com Google'),
                          ),
                        ],
                      ),
                    )),
          ],
        ),
      ),
    );
  }
}
