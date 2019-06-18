package fr.jonmlk.imageshare;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import java.io.File;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import androidx.core.content.FileProvider;

/** ImageSharePlugin */
public class ImageSharePlugin implements MethodCallHandler {
  private Activity currentActivity;
  private String fileProviderName;

  private ImageSharePlugin(Activity activity) {
    this.currentActivity = activity;
    this.fileProviderName = activity.getPackageName() + ".imageshare.fileprovider";
  }

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "image_share");
    channel.setMethodCallHandler(new ImageSharePlugin(registrar.activity()));
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if (call.method.equals("shareFile")) {
      shareFile((String) call.arguments);
      result.success(null);
    } else {
        result.notImplemented();
    }
  }

  private void shareFile(String path) {
    File imageFile = new File(this.currentActivity.getApplicationContext().getCacheDir(), path);
    Uri contentUri = FileProvider.getUriForFile(this.currentActivity.getApplicationContext(), fileProviderName, imageFile);
    Intent shareIntent = new Intent(Intent.ACTION_SEND);
    shareIntent.setType("image/*");
    shareIntent.putExtra(Intent.EXTRA_STREAM, contentUri);
    this.currentActivity.startActivity(Intent.createChooser(shareIntent, ""));
  }
}
