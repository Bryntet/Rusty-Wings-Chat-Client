import 'package:catppuccin_flutter/catppuccin_flutter.dart';
import 'package:flutter/material.dart';

ThemeData catppuccinTheme(Flavor flavor) {
  // Define the colors as per the style guide
  Color backgroundColor = flavor.base; // Background Pane
  Color secondaryPaneColor = flavor.mantle; // Secondary Panes
  Color surfaceElementColor = flavor.surface0; // Surface Elements
  Color overlayColor = flavor.overlay0; // Overlays
  Color bodyCopyColor = flavor.text; // Body Copy
  Color headlineColor = flavor.text; // Main Headline
  Color subHeadlineColor = flavor.subtext0; // Sub-Headlines, Labels
  Color linkColor = flavor.blue; // Links, URLs
  Color successColor = flavor.green; // Success
  Color warningColor = flavor.yellow; // Warnings
  Color errorColor = flavor.red; // Errors
  Color tagColor = flavor.blue; // Tags, Pills
  Color selectionBackgroundColor =
      flavor.surface2.withOpacity(0.4); // Selection Background
  Color cursorColor = flavor.rosewater; // Cursor

  return ThemeData(
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        elevation: 0,
        titleTextStyle: TextStyle(
          color: headlineColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: secondaryPaneColor,
        foregroundColor: flavor.lavender,
      ),
      colorScheme: ColorScheme(
        background: backgroundColor,
        brightness: Brightness.light,
        error: errorColor,
        onBackground: bodyCopyColor,
        onError: errorColor,
        onPrimary: flavor.crust,
        onSecondary: secondaryPaneColor,
        onSurface: surfaceElementColor,
        primary: flavor.crust,
        secondary: secondaryPaneColor,
        surface: surfaceElementColor,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: bodyCopyColor),
        bodyMedium: TextStyle(color: bodyCopyColor),
        displayLarge: TextStyle(color: headlineColor),
        displayMedium: TextStyle(color: subHeadlineColor),
        displaySmall: TextStyle(color: subHeadlineColor),
        headlineMedium: TextStyle(color: subHeadlineColor),
        headlineSmall: TextStyle(color: subHeadlineColor),
        titleLarge: TextStyle(color: subHeadlineColor),
        titleMedium: TextStyle(color: subHeadlineColor),
        titleSmall: TextStyle(color: subHeadlineColor),
      ),
      inputDecorationTheme: InputDecorationTheme(
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: surfaceElementColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: flavor.overlay2),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: flavor.lavender),
          ),
          focusColor: flavor.lavender,
          hintStyle: TextStyle(color: flavor.text),
          labelStyle: TextStyle(color: flavor.text),
          fillColor: flavor.surface0,
          filled: false),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 0,
        foregroundColor: tagColor,
        backgroundColor: secondaryPaneColor,
      ),
      listTileTheme: ListTileThemeData(
          tileColor: flavor.surface0,
          titleTextStyle: TextStyle(color: flavor.text)));
}

Map<String, Color> getColorMap() {
  Flavor flavor = catppuccin.macchiato;
  Map<String, Color> colorMap = {
    "rosewater": flavor.rosewater,
    "flamingo": flavor.flamingo,
    "pink": flavor.pink,
    "mauve": flavor.mauve,
    "red": flavor.red,
    "maroon": flavor.maroon,
    "peach": flavor.peach,
    "yellow": flavor.yellow,
    "green": flavor.green,
    "teal": flavor.teal,
    "sky": flavor.sky,
    "sapphire": flavor.sapphire,
    "blue": flavor.blue,
    "lavender": flavor.lavender,
    "text": flavor.text,
    "subtext1": flavor.subtext1,
    "subtext0": flavor.subtext0,
    "overlay2": flavor.overlay2,
    "overlay1": flavor.overlay1,
    "overlay0": flavor.overlay0,
    "surface2": flavor.surface2,
    "surface1": flavor.surface1,
    "surface0": flavor.surface0,
    "crust": flavor.crust,
    "mantle": flavor.mantle,
    "base": flavor.base,
  };
  return colorMap;
}
