// Mocks generated by Mockito 5.4.5 from annotations
// in spacex/test/helpers/mock_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;
import 'dart:convert' as _i21;
import 'dart:typed_data' as _i23;

import 'package:dartz/dartz.dart' as _i2;
import 'package:http/http.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i22;
import 'package:spacex/core/error/failures.dart' as _i9;
import 'package:spacex/core/network/network_info.dart' as _i20;
import 'package:spacex/features/crews/data/datasources/crew_remote_data_source.dart'
    as _i18;
import 'package:spacex/features/crews/data/models/crew_model.dart' as _i19;
import 'package:spacex/features/crews/domain/entities/crew.dart' as _i17;
import 'package:spacex/features/crews/domain/respositories/crew_repository.dart'
    as _i16;
import 'package:spacex/features/launches/data/datasources/spacex_remote_data_source.dart'
    as _i14;
import 'package:spacex/features/launches/data/models/detail_launch_model.dart'
    as _i5;
import 'package:spacex/features/launches/data/models/detail_rocket_model.dart'
    as _i6;
import 'package:spacex/features/launches/data/models/latest_launch_model.dart'
    as _i4;
import 'package:spacex/features/launches/data/models/launch_model.dart' as _i15;
import 'package:spacex/features/launches/domain/entities/latest_launch.dart'
    as _i11;
import 'package:spacex/features/launches/domain/entities/launch.dart' as _i10;
import 'package:spacex/features/launches/domain/entities/launch_detail.dart'
    as _i12;
import 'package:spacex/features/launches/domain/entities/rocket_detail.dart'
    as _i13;
import 'package:spacex/features/launches/domain/repositories/launch_repository.dart'
    as _i7;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeClient_1 extends _i1.SmartFake implements _i3.Client {
  _FakeClient_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeLatestLaunchModel_2 extends _i1.SmartFake
    implements _i4.LatestLaunchModel {
  _FakeLatestLaunchModel_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDetailLaunchModel_3 extends _i1.SmartFake
    implements _i5.DetailLaunchModel {
  _FakeDetailLaunchModel_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDetailRocketModel_4 extends _i1.SmartFake
    implements _i6.DetailRocketModel {
  _FakeDetailRocketModel_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_5 extends _i1.SmartFake implements _i3.Response {
  _FakeResponse_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeStreamedResponse_6 extends _i1.SmartFake
    implements _i3.StreamedResponse {
  _FakeStreamedResponse_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [LaunchRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockLaunchRepository extends _i1.Mock implements _i7.LaunchRepository {
  MockLaunchRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i10.Launch>>> getLaunches({
    Map<String, dynamic>? query,
    Map<String, dynamic>? options,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getLaunches,
          [],
          {
            #query: query,
            #options: options,
          },
        ),
        returnValue:
            _i8.Future<_i2.Either<_i9.Failure, List<_i10.Launch>>>.value(
                _FakeEither_0<_i9.Failure, List<_i10.Launch>>(
          this,
          Invocation.method(
            #getLaunches,
            [],
            {
              #query: query,
              #options: options,
            },
          ),
        )),
      ) as _i8.Future<_i2.Either<_i9.Failure, List<_i10.Launch>>>);

  @override
  _i8.Future<_i2.Either<_i9.Failure, _i11.LatestLaunch>> getLatestLaunch() =>
      (super.noSuchMethod(
        Invocation.method(
          #getLatestLaunch,
          [],
        ),
        returnValue:
            _i8.Future<_i2.Either<_i9.Failure, _i11.LatestLaunch>>.value(
                _FakeEither_0<_i9.Failure, _i11.LatestLaunch>(
          this,
          Invocation.method(
            #getLatestLaunch,
            [],
          ),
        )),
      ) as _i8.Future<_i2.Either<_i9.Failure, _i11.LatestLaunch>>);

  @override
  _i8.Future<_i2.Either<_i9.Failure, _i12.LaunchDetail>> getDetailLaunch(
          String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getDetailLaunch,
          [id],
        ),
        returnValue:
            _i8.Future<_i2.Either<_i9.Failure, _i12.LaunchDetail>>.value(
                _FakeEither_0<_i9.Failure, _i12.LaunchDetail>(
          this,
          Invocation.method(
            #getDetailLaunch,
            [id],
          ),
        )),
      ) as _i8.Future<_i2.Either<_i9.Failure, _i12.LaunchDetail>>);

  @override
  _i8.Future<_i2.Either<_i9.Failure, _i13.RocketDetail>> getDetailRocket(
          String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getDetailRocket,
          [id],
        ),
        returnValue:
            _i8.Future<_i2.Either<_i9.Failure, _i13.RocketDetail>>.value(
                _FakeEither_0<_i9.Failure, _i13.RocketDetail>(
          this,
          Invocation.method(
            #getDetailRocket,
            [id],
          ),
        )),
      ) as _i8.Future<_i2.Either<_i9.Failure, _i13.RocketDetail>>);
}

/// A class which mocks [LaunchRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockLaunchRemoteDataSource extends _i1.Mock
    implements _i14.LaunchRemoteDataSource {
  MockLaunchRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Client get client => (super.noSuchMethod(
        Invocation.getter(#client),
        returnValue: _FakeClient_1(
          this,
          Invocation.getter(#client),
        ),
      ) as _i3.Client);

  @override
  _i8.Future<List<_i15.LaunchModel>> fetchLaunches({
    Map<String, dynamic>? query,
    Map<String, dynamic>? options,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchLaunches,
          [],
          {
            #query: query,
            #options: options,
          },
        ),
        returnValue:
            _i8.Future<List<_i15.LaunchModel>>.value(<_i15.LaunchModel>[]),
      ) as _i8.Future<List<_i15.LaunchModel>>);

  @override
  _i8.Future<_i4.LatestLaunchModel> fetchLatestLaunch() => (super.noSuchMethod(
        Invocation.method(
          #fetchLatestLaunch,
          [],
        ),
        returnValue:
            _i8.Future<_i4.LatestLaunchModel>.value(_FakeLatestLaunchModel_2(
          this,
          Invocation.method(
            #fetchLatestLaunch,
            [],
          ),
        )),
      ) as _i8.Future<_i4.LatestLaunchModel>);

  @override
  _i8.Future<_i5.DetailLaunchModel> fetchOneLaunch(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchOneLaunch,
          [id],
        ),
        returnValue:
            _i8.Future<_i5.DetailLaunchModel>.value(_FakeDetailLaunchModel_3(
          this,
          Invocation.method(
            #fetchOneLaunch,
            [id],
          ),
        )),
      ) as _i8.Future<_i5.DetailLaunchModel>);

  @override
  _i8.Future<_i6.DetailRocketModel> fetchOneRocket(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchOneRocket,
          [id],
        ),
        returnValue:
            _i8.Future<_i6.DetailRocketModel>.value(_FakeDetailRocketModel_4(
          this,
          Invocation.method(
            #fetchOneRocket,
            [id],
          ),
        )),
      ) as _i8.Future<_i6.DetailRocketModel>);
}

/// A class which mocks [CrewRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockCrewRepository extends _i1.Mock implements _i16.CrewRepository {
  MockCrewRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i17.Crew>>> getCrews({
    Map<String, dynamic>? query,
    Map<String, dynamic>? options,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCrews,
          [],
          {
            #query: query,
            #options: options,
          },
        ),
        returnValue: _i8.Future<_i2.Either<_i9.Failure, List<_i17.Crew>>>.value(
            _FakeEither_0<_i9.Failure, List<_i17.Crew>>(
          this,
          Invocation.method(
            #getCrews,
            [],
            {
              #query: query,
              #options: options,
            },
          ),
        )),
      ) as _i8.Future<_i2.Either<_i9.Failure, List<_i17.Crew>>>);
}

/// A class which mocks [CrewsRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockCrewsRemoteDataSource extends _i1.Mock
    implements _i18.CrewsRemoteDataSource {
  MockCrewsRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Client get client => (super.noSuchMethod(
        Invocation.getter(#client),
        returnValue: _FakeClient_1(
          this,
          Invocation.getter(#client),
        ),
      ) as _i3.Client);

  @override
  _i8.Future<List<_i19.CrewModel>> fetchCrews({
    Map<String, dynamic>? query,
    Map<String, dynamic>? options,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchCrews,
          [],
          {
            #query: query,
            #options: options,
          },
        ),
        returnValue: _i8.Future<List<_i19.CrewModel>>.value(<_i19.CrewModel>[]),
      ) as _i8.Future<List<_i19.CrewModel>>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i20.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i8.Future<bool>.value(false),
      ) as _i8.Future<bool>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockClient extends _i1.Mock implements _i3.Client {
  MockClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<_i3.Response> head(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #head,
          [url],
          {#headers: headers},
        ),
        returnValue: _i8.Future<_i3.Response>.value(_FakeResponse_5(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i8.Future<_i3.Response>);

  @override
  _i8.Future<_i3.Response> get(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {#headers: headers},
        ),
        returnValue: _i8.Future<_i3.Response>.value(_FakeResponse_5(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i8.Future<_i3.Response>);

  @override
  _i8.Future<_i3.Response> post(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i21.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i8.Future<_i3.Response>.value(_FakeResponse_5(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i8.Future<_i3.Response>);

  @override
  _i8.Future<_i3.Response> put(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i21.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i8.Future<_i3.Response>.value(_FakeResponse_5(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i8.Future<_i3.Response>);

  @override
  _i8.Future<_i3.Response> patch(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i21.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i8.Future<_i3.Response>.value(_FakeResponse_5(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i8.Future<_i3.Response>);

  @override
  _i8.Future<_i3.Response> delete(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i21.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i8.Future<_i3.Response>.value(_FakeResponse_5(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i8.Future<_i3.Response>);

  @override
  _i8.Future<String> read(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [url],
          {#headers: headers},
        ),
        returnValue: _i8.Future<String>.value(_i22.dummyValue<String>(
          this,
          Invocation.method(
            #read,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i8.Future<String>);

  @override
  _i8.Future<_i23.Uint8List> readBytes(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readBytes,
          [url],
          {#headers: headers},
        ),
        returnValue: _i8.Future<_i23.Uint8List>.value(_i23.Uint8List(0)),
      ) as _i8.Future<_i23.Uint8List>);

  @override
  _i8.Future<_i3.StreamedResponse> send(_i3.BaseRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #send,
          [request],
        ),
        returnValue:
            _i8.Future<_i3.StreamedResponse>.value(_FakeStreamedResponse_6(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
      ) as _i8.Future<_i3.StreamedResponse>);

  @override
  void close() => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
