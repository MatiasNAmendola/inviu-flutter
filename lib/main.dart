import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:inviu_flutter/injection.dart';
import 'package:inviu_flutter/presentation/app_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection(Environment.prod);
  runApp(AppWidget());
}
