// Override the back button behavior
import 'package:flutter/material.dart';

class BackButtonInterceptor extends StatelessWidget {
  final Widget child;
  final PopInvokedCallback? onPopInvoked;

  const BackButtonInterceptor({super.key, 
    required this.child,
    this.onPopInvoked,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
       onPopInvoked: onPopInvoked,
      child: child,
    );
  }
}