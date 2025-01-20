package devdf.plugins.android.background_actions

import devdf.plugins.android.DevDFPlugin
import devdf.plugins.android.extensions.alreadyRunning
import devdf.plugins.android.interfaces.ChannelInterface
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMethodCodec

/** This class is used to manage the actions that can be called in the background.
 * This class handle all the actions that are available to the plugin, which
 * are not require Activity lifecycle management.
 */
internal class BgChannel(override val plugin: DevDFPlugin) : ChannelInterface {

    private var channel: MethodChannel? = null
    private val channelName: String = "${DevDFPlugin.BASE_CHANNEL}/bg_channel"

    ///Collection of methods that can be called in that channel
    override val methods = BgChannelMethods()

    ///Hash set methods queue for the channel
    override val queue = HashSet<String>()

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        //1. Get the action, If the action is null, return not implemented
        val action = methods.getByName(call.method) ?: return result.notImplemented()
        //2. If the queue contains the method, return already running, otherwise add it to the queue
        if (!queue.add(call.method)) return result.alreadyRunning(call.method)
        //3. Initialize the action
        action.init(this, call, result)
    }


    override fun onAttach() {
        if (channel != null) onDetach()
        //1. Setting the channel
        channel = MethodChannel(
            plugin.messenger!!,
            channelName,
            StandardMethodCodec.INSTANCE,
            plugin.messenger!!.makeBackgroundTaskQueue()
        )
        channel!!.setMethodCallHandler(this)
    }

    override fun onDetach() {
        if (channel == null) return
        channel?.setMethodCallHandler(null)
        channel = null
        queue.clear()
    }
}