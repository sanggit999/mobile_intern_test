import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_intern_test/di.dart';
import 'package:mobile_intern_test/presentation/cubit/search_places_cubit.dart';
import 'package:mobile_intern_test/presentation/home_page.dart';

Future<void> main() async {
  await initDependencies();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LocationIQ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(create: (context)=> SearchPlacesCubit(),child: HomePage()),
    );
  }
}
