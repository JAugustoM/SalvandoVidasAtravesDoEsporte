// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of 'registro_kimonos_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RegistroKimonosStore)
final registroKimonosStoreProvider = RegistroKimonosStoreProvider._();

final class RegistroKimonosStoreProvider
    extends $NotifierProvider<RegistroKimonosStore, RegistroKimonosState> {
  RegistroKimonosStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registroKimonosStoreProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registroKimonosStoreHash();

  @$internal
  @override
  RegistroKimonosStore create() => RegistroKimonosStore();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RegistroKimonosState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RegistroKimonosState>(value),
    );
  }
}

String _$registroKimonosStoreHash() =>
    r'a9726e5148f78150ed81f9c98e3e2abf85a77330';

abstract class _$RegistroKimonosStore extends $Notifier<RegistroKimonosState> {
  RegistroKimonosState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<RegistroKimonosState, RegistroKimonosState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RegistroKimonosState, RegistroKimonosState>,
              RegistroKimonosState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
