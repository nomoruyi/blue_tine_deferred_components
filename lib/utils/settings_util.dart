import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

//region THEME
final ThemeData lightTheme = FlexThemeData.light(
    scheme: FlexScheme.blumineBlue,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 9,
    appBarElevation: 4.0,
    subThemesData: const FlexSubThemesData(
      buttonMinSize: Size(80.0, 44.0),
      buttonPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
      textButtonRadius: 12.0,
      elevatedButtonRadius: 12.0,
      outlinedButtonRadius: 12.0,
      toggleButtonsRadius: 12.0,
      inputDecoratorRadius: 12.0,
      blendOnLevel: 10,
      blendOnColors: false,
      cardRadius: 24.0,
      cardElevation: 8.0,
    ),
    keyColors: const FlexKeyColors(
      useSecondary: true,
      useTertiary: true,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    );

final ThemeData darkTheme = FlexThemeData.dark(
    scheme: FlexScheme.blumineBlue,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 15,
    appBarElevation: 4.0,
    applyElevationOverlayColor: false,
    subThemesData: const FlexSubThemesData(
      buttonMinSize: Size(80.0, 40.0),
      buttonPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      textButtonRadius: 12.0,
      elevatedButtonRadius: 12.0,
      outlinedButtonRadius: 12.0,
      toggleButtonsRadius: 12.0,
      inputDecoratorRadius: 12.0,
      blendOnLevel: 20,
      cardRadius: 24.0,
      cardElevation: 8.0,

    ),
    keyColors: const FlexKeyColors(
      useSecondary: true,
      useTertiary: true,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    );
//endregion
