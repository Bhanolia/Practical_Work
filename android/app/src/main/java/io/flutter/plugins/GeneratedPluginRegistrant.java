package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import vn.hunghd.flutterdownloader.FlutterDownloaderPlugin;
import io.github.ponnamkarthik.toast.fluttertoast.FlutterToastPlugin;
import com.crazecoder.openfile.OpenFilePlugin;
import io.flutter.plugins.pathprovider.PathProviderPlugin;
import io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin;
import io.flutter.plugins.urllauncher.UrlLauncherPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    FlutterDownloaderPlugin.registerWith(registry.registrarFor("vn.hunghd.flutterdownloader.FlutterDownloaderPlugin"));
    FlutterToastPlugin.registerWith(registry.registrarFor("io.github.ponnamkarthik.toast.fluttertoast.FlutterToastPlugin"));
    OpenFilePlugin.registerWith(registry.registrarFor("com.crazecoder.openfile.OpenFilePlugin"));
    PathProviderPlugin.registerWith(registry.registrarFor("io.flutter.plugins.pathprovider.PathProviderPlugin"));
    SharedPreferencesPlugin.registerWith(registry.registrarFor("io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin"));
    UrlLauncherPlugin.registerWith(registry.registrarFor("io.flutter.plugins.urllauncher.UrlLauncherPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
