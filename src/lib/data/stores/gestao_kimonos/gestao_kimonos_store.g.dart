// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of 'gestao_kimonos_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GestaoKimonosStore)
final gestaoKimonosStoreProvider = GestaoKimonosStoreProvider._();

final class GestaoKimonosStoreProvider
    extends $AsyncNotifierProvider<GestaoKimonosStore, GestaoKimonosState> {
  GestaoKimonosStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gestaoKimonosStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gestaoKimonosStoreHash();

  @$internal
  @override
  GestaoKimonosStore create() => GestaoKimonosStore();
}

String _$gestaoKimonosStoreHash() =>
    r'6f5b99bb506eb81b6c0afadc1ff5eedca76ca5bf';

abstract class _$GestaoKimonosStore extends $AsyncNotifier<GestaoKimonosState> {
  FutureOr<GestaoKimonosState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<GestaoKimonosState>, GestaoKimonosState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<GestaoKimonosState>, GestaoKimonosState>,
              AsyncValue<GestaoKimonosState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
