package devdf.plugins.android.interfaces

/** Interface shared across Channels that require `Engine` lifecycle management. */
interface EngineBase {
    fun onAttach()
    fun onDetach()
}