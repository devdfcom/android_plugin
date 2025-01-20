package devdf.plugins.android.utils

import android.os.Build
import androidx.annotation.ChecksSdkIntAtLeast

/**  Utility class to check for build version and features */
class VersionBuild {
    companion object {
        /** Check if have to use new `PackageManager.PackageInfoFlags` or not, for `getPackageInfo` */
        @ChecksSdkIntAtLeast(api = Build.VERSION_CODES.TIRAMISU)
        fun getPackageInfo(): Boolean = Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU
    }
}