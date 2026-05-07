import 'package:flutter/material.dart';
import 'package:ludoboardgames/ui/components/app_logo.dart';

class LudoTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  //Lista de ações que ficam na AppBar, precisa passar actions como parâmetro
  final List<Widget>? actions;

  const LudoTopAppBar({super.key, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 0,
      title: const AppLogo(),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
