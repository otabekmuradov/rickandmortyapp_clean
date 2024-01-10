import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rickandmortyapp/core/platform/network_info.dart';
import 'package:rickandmortyapp/feature/data/datasources/person_local_data_source.dart';
import 'package:rickandmortyapp/feature/data/datasources/person_remote_data_source.dart';
import 'package:rickandmortyapp/feature/data/repositories/person_repository_impl.dart';
import 'package:rickandmortyapp/feature/domain/repositories/person_repository.dart';
import 'package:rickandmortyapp/feature/domain/usecases/get_all_persons.dart';
import 'package:rickandmortyapp/feature/domain/usecases/search_person.dart';
import 'package:rickandmortyapp/feature/presentation/bloc/search_bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rickandmortyapp/feature/presentation/bloc/search_bloc/seach_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Bloc / Cubit
  sl.registerFactory(
    () => PersonListCubit(getAllPerson: sl<GetAllPersons>()),
  );
  sl.registerFactory(
    () => PersonSearchBloc(searchPerson: sl()),
  );
  //UseCases
  sl.registerLazySingleton(
    () => GetAllPersons(sl()),
  );
  sl.registerLazySingleton(
    () => SearchPerson(sl()),
  );

  //Repository
  sl.registerLazySingleton<PersonRepository>(() => PersonRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<PersonRemoteDataSource>(
    () => PersonRemoteDataSourceImpl(
      client: http.Client(),
    ),
  );

  sl.registerLazySingleton<PersonLocalDataSource>(
    () => PersonLocalDataSourceImpl(sharedPreferences: sl()),
  );
  //Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
