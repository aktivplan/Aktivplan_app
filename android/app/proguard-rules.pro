-keep class io.flutter.plugin.editing.** { *; }

# Health Connect SDK — must not be stripped or the permission launcher silently fails
-keep class androidx.health.** { *; }
-keep class cachet.plugins.health.** { *; }