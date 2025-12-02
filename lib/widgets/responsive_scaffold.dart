import 'package:flutter/material.dart';

class ResponsiveScaffold extends StatelessWidget {
  final Widget child;
  final String? title; 
  final bool showAppBar;
  final bool fullScreen;

  static const double mobileBreakpoint = 600.0;

  const ResponsiveScaffold({
    super.key,
    required this.child,
    this.title,
    this.showAppBar = true,
    this.fullScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar 
        ? AppBar(
            title: Text(title ?? ""),
            centerTitle: true,
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ) 
        : null,
      
      body: fullScreen 
        ? child 
        : Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 960),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final bool isMobile = constraints.maxWidth < mobileBreakpoint;
                  return Padding(
                    padding: EdgeInsets.all(isMobile ? 16.0 : 32.0),
                    child: SizedBox(
                      width: double.infinity, 
                      height: double.infinity,
                      child: child,
                    ),
                  );
                },
              ),
            ),
          ),
    );
  }
}