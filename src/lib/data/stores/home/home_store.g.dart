// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of 'home_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomeStore)
final homeStoreProvider = HomeStoreProvider._();

final class HomeStoreProvider
    extends $AsyncNotifierProvider<HomeStore, HomeState> {
  HomeStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeStoreHash();

  @$internal
  @override
  HomeStore create() => HomeStore();
}

String _$homeStoreHash() => r'd9379f906bd16d1f7b25bac83d1c6f1ca869820b';

abstract class _$HomeStore extends $AsyncNotifier<HomeState> {
  FutureOr<HomeState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<HomeState>, HomeState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<HomeState>, HomeState>,
              AsyncValue<HomeState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
