import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myselff_flutter/app/modules/home/presentation/controllers/home_page_controller.dart';
import 'package:signals/signals_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.controller,
  });

  final HomePageController controller;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (mounted) {
      widget.controller.selectPage(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const RouterOutlet(),
        bottomNavigationBar: Watch.builder(
          builder: (_) {
            return NavigationBar(
              selectedIndex: widget.controller.selectedPage.get(),
              onDestinationSelected: widget.controller.selectPage,
              destinations: const [
                NavigationDestination(
                  selectedIcon: Icon(Icons.monetization_on),
                  icon: Icon(Icons.monetization_on_outlined),
                  label: 'Despesas',
                ),
                NavigationDestination(
                  selectedIcon: Icon(Icons.account_circle),
                  icon: Icon(Icons.account_circle_outlined),
                  label: 'Usuário',
                ),
              ],
            );
          },
        ));
  }
}
