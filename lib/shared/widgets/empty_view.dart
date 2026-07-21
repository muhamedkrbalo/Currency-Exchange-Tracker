import 'package:flutter/material.dart';

import 'state_message_view.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({
    super.key,
    required this.message,
    this.icon = Icons.inbox_outlined,
  });

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return StateMessageView(icon: icon, message: message);
  }
}
