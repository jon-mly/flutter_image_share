package fr.jonmlk.imageshare;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;

import androidx.annotation.NonNull;
import androidx.core.content.FileProvider;

import java.io.File;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * ImageSharePlugin
 */
public class ImageSharePlugin implements MethodCallHandler {
    private Context applicationContext;
    private String fileProviderName;

    private ImageSharePlugin(Context context) {
        applicationContext = context;
        fileProviderName = context.getPackageName() + ".imageshare.fileprovider";
    }

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "image_share");
        channel.setMethodCallHandler(new ImageSharePlugin(registrar.context()));
    }

    @Override
    public void onMethodCall(MethodCall call, @NonNull Result result) {
        if (call.method.equals("shareFile")) {
            shareFile((String) call.arguments);
            result.success(null);
        } else {
            result.notImplemented();
        }
    }

    private void shareFile(String path) {
        File imageFile = new File(applicationContext.getCacheDir(), path);
        Uri contentUri = FileProvider.getUriForFile(applicationContext, fileProviderName, imageFile);
        Intent shareIntent = new Intent(Intent.ACTION_SEND);
        shareIntent.setType("image/*");
        shareIntent.putExtra(Intent.EXTRA_STREAM, contentUri);

        final Intent chooserIntent = Intent.createChooser(shareIntent, "");
        chooserIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        applicationContext.startActivity(chooserIntent);
    }
}
