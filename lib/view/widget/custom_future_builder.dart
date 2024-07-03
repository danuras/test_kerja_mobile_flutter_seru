import 'package:flutter/material.dart';
import 'package:test_kerja_screen_wizard/view/widget/loading_screen.dart';
import 'package:test_kerja_screen_wizard/view/widget/refresh_widget.dart';

/// widget yang dapat digunakan untuk meload data dari internet atau api
class CustomFutureBuilder extends StatefulWidget {
  const CustomFutureBuilder({
    super.key,
    required this.future,
    required this.widgetResult,
    required this.refreshWidget,
  });
  final Future<List<dynamic>?> future;
  final Widget Function(List<dynamic>? result) widgetResult;
  final Function() refreshWidget;

  @override
  State<CustomFutureBuilder> createState() => _CustomFutureBuilderState();
}

class _CustomFutureBuilderState extends State<CustomFutureBuilder> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != null) {
            return widget.widgetResult(snapshot.data);
          } else {
            return RefreshWidget(action: widget.refreshWidget);
          }
        } else {
          return const LoadingScreen();
        }
      },
    );
  }
}
