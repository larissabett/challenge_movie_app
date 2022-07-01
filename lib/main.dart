import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/presentation/pages/movie_details_screen.dart';
import 'features/presentation/provider/movie_detail_notifier.dart';
import 'injection.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
      ],
      // ignore: prefer_const_constructors
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MovieDetailsScreen(),
      ),
    );
  }
}
