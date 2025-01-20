package devdf.plugins.android.interfaces

import devdf.plugins.android.DevDFPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/** Base Interface for all Channels.
 *
 * @property methods `ChannelMethods` - The methods that can be used in the channel.
 * @property queue `HashSet<String>` - The queue of the methods that are currently running.
 */
interface ChannelInterface : EngineBase, MethodChannel.MethodCallHandler {
    val plugin: DevDFPlugin
    val methods: ChannelMethods
    val queue: HashSet<String>
}

/** Interface for collection of methods.
 *
 * @property container `Map<String, MethodInterface>` - The collection of all methods, which can be used in the channel.
 */
interface ChannelMethods {
    val container: Map<String, MethodInterface>
    /** Get the method by name.
     *
     * @param name `String` - The name of the method.
     * @return `MethodInterface?` - The method if found, otherwise null.
     */
    fun getByName(name: String): MethodInterface?
}

/** Base Interface for all methods. */
interface MethodInterface {
    /** Initialize the method.
     *
     * @param channel `ChannelInterface` - The channel instance.
     * @param call `MethodCall` - The method call.
     * @param result `MethodChannel.Result` - The result object.
     */
    fun init(channel: ChannelInterface,  call: MethodCall, result: MethodChannel.Result)
    /** Call on success.
     *
     * @param data `Any?` - The data to send back to the Flutter side.
     */
    fun onSuccess(data: Any?)
    /** Call on error.
     *
     * @param message `String?` - The error message.
     * @param details `Any?` - The error details.
     */
    fun onError(message: String?, details: Any? = null)
}