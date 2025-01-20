package devdf.plugins.android.background_actions.methods

import android.content.pm.PackageManager
import androidx.core.content.pm.PackageInfoCompat.getLongVersionCode
import devdf.plugins.android.interfaces.MethodBase
import devdf.plugins.android.utils.VersionBuild

/** This class method is used to get the package info of the app
 * Which is used to get the app name, package name, version name and version code.
 */
class PackageInfo() : MethodBase() {

    companion object {
        const val NAME = "package_info"
    }

    override val logTag = "BGActionPackageInfo"

    override fun onCall() = onSuccess(getAppInfo())

    /** Get app info */
    /// Inspired by
    /// https://github.com/fluttercommunity/plus_plugins/blob/main/packages/package_info_plus/package_info_plus/android/src/main/kotlin/dev/fluttercommunity/plus/packageinfo/PackageInfoPlugin.kt
    /// Just to remove all dependencies, simplify the code.
    private fun getAppInfo(): HashMap<String, String> {
        val context = channel.plugin.context
        val pm = context.packageManager

        val info = if (VersionBuild.getPackageInfo()) {
            pm.getPackageInfo(context.packageName, PackageManager.PackageInfoFlags.of(0))
        } else {
            pm.getPackageInfo(context.packageName, 0)
        }

        return HashMap<String, String>().apply {
            put("app", info.applicationInfo?.loadLabel(pm)?.toString() ?: context.packageName)
            put("package", context.packageName)
            put("version", info.versionName ?: "")
            put("build", getLongVersionCode(info).toString())
        }
    }

}