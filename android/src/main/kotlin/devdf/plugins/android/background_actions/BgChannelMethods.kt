package devdf.plugins.android.background_actions

import devdf.plugins.android.background_actions.methods.PackageInfo
import devdf.plugins.android.background_actions.methods.RegionalInfo
import devdf.plugins.android.interfaces.ChannelMethods
import devdf.plugins.android.interfaces.MethodInterface


/** Collection of all the methods that use the background channel. */
class BgChannelMethods : ChannelMethods {
    override val container = mutableMapOf<String, MethodInterface>(
        // Add the package info method
        PackageInfo.NAME to PackageInfo(),
        RegionalInfo.NAME to RegionalInfo()
    )

    override fun getByName(name: String): MethodInterface? = container[name]
}