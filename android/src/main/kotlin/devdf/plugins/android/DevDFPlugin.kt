package devdf.plugins.android

import android.content.Context
import devdf.plugins.android.background_actions.BgChannel
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger

/** DevDFPlugin main plugin entry */
class DevDFPlugin : FlutterPlugin, ActivityAware {

    companion object {
        ///Base name for the channels
        const val BASE_CHANNEL = "devdf.plugins.android"
    }

    /// Channel for actions, which can perform actions in background
    private val bgActions = BgChannel(this)


    lateinit var context: Context
    var binding: ActivityPluginBinding? = null
    var messenger: BinaryMessenger? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        //1. Setting the context and messenger
        context = flutterPluginBinding.applicationContext
        messenger = flutterPluginBinding.binaryMessenger
        //2. Attaching the background actions
        bgActions.onAttach()

    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        bgActions.onDetach()
    }

    /** All channels, which required Activity, must be initialized here */
    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        this.binding = binding
        /// intent - activity channel goes here ex: intentActivity.startActivity();
    }

    override fun onDetachedFromActivityForConfigChanges() {

    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        this.binding = binding
    }

    override fun onDetachedFromActivity() {
        binding = null
    }
}
