import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:get_it/get_it.dart';

import '../blocs/jobs/jobs.dart';
import '../data/repositoires/job_repository.dart';
import '../shared/constants/api.dart';

final sl = GetIt.instance;

void setupLocator() {
  sl.registerLazySingleton<JobsRepository>(
    () {
      final dio = Dio();
      dio.interceptors.add(DioCacheManager(
        CacheConfig(baseUrl: Api.baseUrl),
      ).interceptor);

      return JobsRepository(
        client: dio,
      );
    },
  );

  sl.registerLazySingleton<JobsEvent>(() => LoadJobs());
}
