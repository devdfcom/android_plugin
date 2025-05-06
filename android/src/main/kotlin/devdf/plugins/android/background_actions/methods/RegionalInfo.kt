package devdf.plugins.android.background_actions.methods

import android.text.format.DateFormat
import devdf.plugins.android.interfaces.MethodBase
import java.text.DecimalFormatSymbols
import java.text.NumberFormat
import java.util.Calendar
import java.util.Currency
import java.util.Locale

class RegionalInfo() : MethodBase() {
    companion object {
        const val NAME = "regional_info"
    }

    override val logTag = "BGActionRegionalInfo"

    override fun onCall() = onSuccess(getRegionalInfo())

    private fun getRegionalInfo(): HashMap<String, Any?> {

        //1. Check if channel call has parameter
        val localeString = call.argument<String>("locale")
        //2. If the parameter is null, use the default locale
        // Create locale with backward compatibility
        val locale = when {
            localeString.isNullOrBlank() -> Locale.getDefault()
            else -> Locale.forLanguageTag(localeString.replace("_", "-"))
        }

        return HashMap<String, Any?>().apply {
            setLocaleData(this, locale)
            setDateTimeData(this, locale)
            numberFormatData(this, locale)
            if (locale.country != null && locale.country.isNotEmpty()) {
                setCountryData(this, locale)
                setCurrencyData(this, locale)
                setMeasurementData(this, locale)
            }
        }
    }

    private fun setLocaleData(data: HashMap<String, Any?>, locale: Locale) {
        data.apply {
            put("locale", locale.toString())
            put("language", locale.language)
        }
    }

    private fun setCountryData(data: HashMap<String, Any?>, locale: Locale) {
        data.apply {
            put("country", locale.country)
        }
    }

    private fun setDateTimeData(data: HashMap<String, Any?>, locale: Locale) {
        data.apply {
            put("firstDayOfWeek", Calendar.getInstance(locale).firstDayOfWeek)
            put(
                "timeFormat",
                if (DateFormat.getBestDateTimePattern(locale, "HH:mm").contains("H")) 1 else 0
            )

            // Date format pattern short, medium, long
            put("dateShort", DateFormat.getBestDateTimePattern(locale, "yyyy-MM-dd"))
            put("dateShortAlt", DateFormat.getBestDateTimePattern(locale, "dd/MM/yy"))
            put("dateMedium", DateFormat.getBestDateTimePattern(locale, "d MMM yyyy"))
            put("dateMediumAlt", DateFormat.getBestDateTimePattern(locale, "d MMMM yyyy"))
            put("dateLong", DateFormat.getBestDateTimePattern(locale, "EEE, d MMM yyyy"))
            put("dateLongAlt", DateFormat.getBestDateTimePattern(locale, "EEEE, d MMMM yyyy"))
        }
    }

    private fun numberFormatData(data: HashMap<String, Any?>, locale: Locale) {
        data.apply {
            put("decimalSeparator", DecimalFormatSymbols(locale).decimalSeparator.toString())
            put("thousandSeparator", DecimalFormatSymbols(locale).groupingSeparator.toString())
        }
    }

    private fun setCurrencyData(data: HashMap<String, Any?>, locale: Locale) {

        val currency = runCatching { Currency.getInstance(locale) }.getOrNull()
        val symbols = DecimalFormatSymbols(locale)

        data.apply {
            if (currency != null) {

                put("currency", currency.currencyCode)
                put("currencySymbol", symbols.currencySymbol)
                put("currencyFractionDigits", currency.defaultFractionDigits)

                val formattedValue = NumberFormat.getCurrencyInstance(locale).format(123.45)
                val symbolIndex = formattedValue.indexOf(symbols.currencySymbol)
                val firstDigitIndex = formattedValue.indexOfFirst { it.isDigit() }
                // 0 = before number, 1 = after number (fallback also)
                put("currencySymbolPosition", if (symbolIndex < firstDigitIndex) 0 else 1)

            }
        }
    }

    private fun setMeasurementData(data: HashMap<String, Any?>, locale: Locale) {
        // More accurate detection of metric vs imperial system
        val isMetric = when (locale.country) {
            // Countries that primarily use an imperial system
            "US" -> false // United States
            "LR" -> false // Liberia
            "MM" -> false // Myanmar (Burma)

            // Countries with mixed systems but imperial is common in real estate
            "GB" -> false // The United Kingdom - uses both but imperial for property
            "CA" -> false // Canada - uses metric officially but imperial in real estate

            // Countries where property is sometimes measured in imperial
            "HK" -> false // Hong Kong - often uses square feet for apartments
            "IN" -> false // India - commonly uses square feet in real estate
            "PK" -> false // Pakistan - often uses square feet in urban properties

            // All other countries predominantly use metric
            else -> true
        }

        data.apply {
            put("metricMeasure", isMetric)
        }
    }
}