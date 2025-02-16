import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

/// The main registry for dependencies.
///
/// Other packages' service locators should injected them here for
/// application wide contexts.
GetIt get di => debugDi ?? GetIt.instance;

/// Override the [di].
///
/// Setting this to null returns the default [di] to its original
/// value.
///
/// Generally speaking this override is only useful for tests.
/// In general, therefore, this property should not be used in release builds.
@visibleForTesting
GetIt? debugDi;
