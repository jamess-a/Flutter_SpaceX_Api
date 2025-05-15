import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:spacex/core/network/network_info.dart';
import 'package:spacex/features/crews/data/datasources/crew_remote_data_source.dart';
import 'package:spacex/features/crews/domain/respositories/crew_repository.dart';
import 'package:spacex/features/launches/data/datasources/spacex_remote_data_source.dart';
import 'package:spacex/features/launches/domain/repositories/launch_repository.dart';

@GenerateMocks([
  LaunchRepository,
  LaunchRemoteDataSource,
  CrewRepository,
  CrewsRemoteDataSource,
  NetworkInfo,
  http.Client,
])
void main() {}
