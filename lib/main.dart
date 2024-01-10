import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmortyapp/common/app_colors.dart';
import 'package:rickandmortyapp/feature/presentation/bloc/search_bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rickandmortyapp/feature/presentation/bloc/search_bloc/seach_bloc.dart';
import 'package:rickandmortyapp/feature/presentation/pages/person_screen.dart';
import 'package:rickandmortyapp/locator_service.dart' as di;
import 'package:rickandmortyapp/locator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PersonListCubit>(
            create: (context) => sl<PersonListCubit>()..loadPerson()),
        BlocProvider<PersonSearchBloc>(
            create: (context) => sl<PersonSearchBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: AppColors.mainBackground,
            // colorScheme: ColorScheme.dark(background: Colors.black),
            primaryColor: AppColors.mainBackground),
        home: const HomePage(),
      ),
    );
  }
}
