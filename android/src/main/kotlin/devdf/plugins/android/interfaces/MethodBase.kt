package devdf.plugins.android.interfaces

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/** Base Interface for all methods. */
abstract class MethodBase : MethodInterface {
    protected lateinit var call: MethodCall
    protected lateinit var channel: ChannelInterface
    protected lateinit var result: MethodChannel.Result

    /** The log tag for the method, used in logging. */
    abstract val logTag: String

    override fun init(channel: ChannelInterface, call: MethodCall, result: MethodChannel.Result) {
        this.call = call
        this.channel = channel
        this.result = result
        onCall()
    }

    /** The method to call when the method is initialized. */
    abstract fun onCall()

    override fun onError(message: String?, details: Any?) {
        channel.queue.remove(call.method)
        result.error(logTag, message, details)
    }

    override fun onSuccess(data: Any?) {
        channel.queue.remove(call.method)
        result.success(data)
    }
}