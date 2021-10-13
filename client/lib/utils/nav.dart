// External
import 'package:flutter/material.dart';

/// Function to perform push naviagation to another route.
Future<dynamic> navPush(BuildContext context, Widget target) async {
  return await Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => target),
  );
}

/// Function to perform push naviagation to another route after build will be performed.
/// This function adds zero delay for it.
Future<dynamic> navPushAfterBuild(BuildContext context, Widget target) async {
  return await Future.delayed(
    Duration.zero,
    () => Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => target),
    ),
  );
}
