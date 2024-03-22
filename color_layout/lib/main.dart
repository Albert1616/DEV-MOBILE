import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(ColorLayout());
}

class ColorLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Layout(),
      theme: ThemeData().copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Colors.red.shade600,
              secondary: Colors.yellow.shade600,
              tertiary: Colors.green.shade600,
            ),
      ),
    );
  }
}

class Layout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.purple.shade200,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.blue.shade600,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.blue.shade600,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.blue.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
