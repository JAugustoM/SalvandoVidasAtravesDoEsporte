// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of 'kimono_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(alunoService)
final alunoServiceProvider = AlunoServiceProvider._();

final class AlunoServiceProvider
    extends $FunctionalProvider<KimonoService, KimonoService, KimonoService>
    with $Provider<KimonoService> {
  AlunoServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'alunoServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$alunoServiceHash();

  @$internal
  @override
  $ProviderElement<KimonoService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  KimonoService create(Ref ref) {
    return alunoService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KimonoService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KimonoService>(value),
    );
  }
}

String _$alunoServiceHash() => r'e2eb4c78606b875f0e1bf1be25ce9806827e4534';
