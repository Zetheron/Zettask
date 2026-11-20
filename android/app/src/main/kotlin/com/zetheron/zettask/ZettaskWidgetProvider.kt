package com.zetheron.zettask

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.net.Uri
import android.os.Build
import android.view.View
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider
import org.json.JSONArray

class ZettaskWidgetProvider : HomeWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences,
    ) {
        val activeCount = readSafeInt(widgetData, KEY_ACTIVE_COUNT, 0)
        val rawTasksJson = readSafeString(widgetData, KEY_TASKS_JSON, "[]")
        val widgetTitle = readSafeString(widgetData, KEY_WIDGET_TITLE, DEFAULT_TITLE)
            .takeIf { it.isNotBlank() } ?: DEFAULT_TITLE
        val widgetEmptyText = readSafeString(
            widgetData,
            KEY_WIDGET_EMPTY_TEXT,
            DEFAULT_EMPTY_TEXT,
        ).takeIf { it.isNotBlank() } ?: DEFAULT_EMPTY_TEXT
        val widgetStyle = resolveWidgetStyle(context, widgetData)

        val parsedTasks = mutableListOf<Pair<String, String>>()
        try {
            val array = JSONArray(rawTasksJson)
            val limit = minOf(array.length(), 5)
            for (i in 0 until limit) {
                val obj = array.optJSONObject(i) ?: continue
                val time = obj.optString("time", "").trim()
                val title = obj.optString("title", "").trim()
                if (title.isNotEmpty()) {
                    parsedTasks.add(time to title)
                }
            }
        } catch (_: Exception) {
            // Fall back to empty list if stored JSON is missing or malformed.
        }

        val rowIds = intArrayOf(
            R.id.widget_task_row_1,
            R.id.widget_task_row_2,
            R.id.widget_task_row_3,
            R.id.widget_task_row_4,
            R.id.widget_task_row_5,
        )
        val timeIds = intArrayOf(
            R.id.widget_task_time_1,
            R.id.widget_task_time_2,
            R.id.widget_task_time_3,
            R.id.widget_task_time_4,
            R.id.widget_task_time_5,
        )
        val titleIds = intArrayOf(
            R.id.widget_task_title_1,
            R.id.widget_task_title_2,
            R.id.widget_task_title_3,
            R.id.widget_task_title_4,
            R.id.widget_task_title_5,
        )

        val openAppIntent = createLaunchPendingIntent(
            context = context,
            requestCode = REQUEST_CODE_OPEN,
            uriString = "zettask://open",
        )
        val quickAddIntent = createLaunchPendingIntent(
            context = context,
            requestCode = REQUEST_CODE_QUICK_ADD,
            uriString = "zettask://quick-add",
        )

        for (widgetId in appWidgetIds) {
            try {
                val views = RemoteViews(context.packageName, R.layout.zettask_widget_layout)
                applyWidgetStyleSafely(
                    views = views,
                    widgetStyle = widgetStyle,
                    timeIds = timeIds,
                    titleIds = titleIds,
                )

                views.setTextViewText(R.id.widget_header_title, widgetTitle)
                views.setTextViewText(R.id.widget_empty_text, widgetEmptyText)
                views.setTextViewText(R.id.widget_remaining_badge, activeCount.toString())
                views.setOnClickPendingIntent(R.id.widget_root, openAppIntent)
                views.setOnClickPendingIntent(R.id.widget_add_button, quickAddIntent)

                if (parsedTasks.isEmpty()) {
                    views.setViewVisibility(R.id.widget_empty_text, View.VISIBLE)
                    for (i in rowIds.indices) {
                        views.setViewVisibility(rowIds[i], View.GONE)
                    }
                } else {
                    views.setViewVisibility(R.id.widget_empty_text, View.GONE)
                    for (i in rowIds.indices) {
                        if (i < parsedTasks.size) {
                            val (time, title) = parsedTasks[i]
                            views.setViewVisibility(rowIds[i], View.VISIBLE)
                            views.setTextViewText(titleIds[i], title)
                            if (time.isNotEmpty()) {
                                views.setViewVisibility(timeIds[i], View.VISIBLE)
                                views.setTextViewText(timeIds[i], time)
                            } else {
                                views.setViewVisibility(timeIds[i], View.GONE)
                            }
                        } else {
                            views.setViewVisibility(rowIds[i], View.GONE)
                        }
                    }
                }

                appWidgetManager.updateAppWidget(widgetId, views)
            } catch (_: Exception) {
                // Keep minimal safe fallback layout so launchers never display "Can't load widget".
                try {
                    val fallback = RemoteViews(context.packageName, R.layout.zettask_widget_layout)
                    fallback.setTextViewText(R.id.widget_header_title, DEFAULT_TITLE)
                    fallback.setTextViewText(R.id.widget_empty_text, DEFAULT_EMPTY_TEXT)
                    fallback.setTextViewText(R.id.widget_remaining_badge, "0")
                    fallback.setViewVisibility(R.id.widget_empty_text, View.VISIBLE)
                    appWidgetManager.updateAppWidget(widgetId, fallback)
                } catch (_: Exception) {
                }
            }
        }
    }

    private fun createLaunchPendingIntent(
        context: Context,
        requestCode: Int,
        uriString: String,
    ): PendingIntent {
        val intent = Intent(context, MainActivity::class.java).apply {
            action = HOME_WIDGET_LAUNCH_ACTION
            data = Uri.parse(uriString)
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
        }
        val flags = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        } else {
            PendingIntent.FLAG_UPDATE_CURRENT
        }
        return PendingIntent.getActivity(context, requestCode, intent, flags)
    }

    private fun readSafeInt(
        prefs: SharedPreferences,
        key: String,
        defaultValue: Int,
    ): Int {
        return try {
            when (val raw = prefs.all[key]) {
                is Int -> raw
                is Long -> raw.toInt()
                is Number -> raw.toInt()
                is String -> raw.toIntOrNull() ?: defaultValue
                else -> defaultValue
            }
        } catch (_: Exception) {
            defaultValue
        }
    }

    private fun readSafeString(
        prefs: SharedPreferences,
        key: String,
        defaultValue: String,
    ): String {
        return try {
            prefs.getString(key, defaultValue) ?: defaultValue
        } catch (_: Exception) {
            defaultValue
        }
    }

    private fun applyWidgetStyleSafely(
        views: RemoteViews,
        widgetStyle: String,
        timeIds: IntArray,
        titleIds: IntArray,
    ) {
        try {
            when (widgetStyle) {
                STYLE_AMOLED -> {
                    views.setInt(
                        R.id.widget_root,
                        "setBackgroundResource",
                        R.drawable.zettask_widget_background_amoled,
                    )
                    applyDarkWidgetTextColors(views, timeIds, titleIds)
                }

                STYLE_TRANSLUCENT -> {
                    views.setInt(
                        R.id.widget_root,
                        "setBackgroundResource",
                        R.drawable.zettask_widget_background_translucent,
                    )
                    applyDarkWidgetTextColors(views, timeIds, titleIds)
                }

                else -> {
                    views.setInt(
                        R.id.widget_root,
                        "setBackgroundResource",
                        R.drawable.zettask_widget_background,
                    )
                }
            }
        } catch (_: Exception) {
            // Fall back to standard drawable so launcher never fails to render the widget.
            try {
                views.setInt(
                    R.id.widget_root,
                    "setBackgroundResource",
                    R.drawable.zettask_widget_background,
                )
            } catch (_: Exception) {
            }
        }
    }

    private fun applyDarkWidgetTextColors(
        views: RemoteViews,
        timeIds: IntArray,
        titleIds: IntArray,
    ) {
        val primaryColor = 0xFFFAFAFA.toInt()
        val secondaryColor = 0xFFB3B3B3.toInt()
        views.setTextColor(R.id.widget_header_title, primaryColor)
        views.setTextColor(R.id.widget_empty_text, secondaryColor)
        for (id in titleIds) {
            views.setTextColor(id, primaryColor)
        }
        for (id in timeIds) {
            views.setTextColor(id, secondaryColor)
        }
    }

    private fun resolveWidgetStyle(
        context: Context,
        widgetData: SharedPreferences,
    ): String {
        val fromHomeWidget = readSafeString(widgetData, KEY_WIDGET_STYLE, "").trim()
        if (fromHomeWidget.isNotEmpty()) {
            return fromHomeWidget
        }
        return try {
            val flutterPrefs = context.getSharedPreferences(
                FLUTTER_PREFS_NAME,
                Context.MODE_PRIVATE,
            )
            flutterPrefs.getString(FLUTTER_KEY_WIDGET_STYLE, STYLE_STANDARD)
                ?.trim()
                ?.takeIf { it.isNotEmpty() }
                ?: STYLE_STANDARD
        } catch (_: Exception) {
            STYLE_STANDARD
        }
    }

    companion object {
        private const val HOME_WIDGET_LAUNCH_ACTION =
            "es.antonborri.home_widget.action.LAUNCH"
        private const val REQUEST_CODE_OPEN = 1001
        private const val REQUEST_CODE_QUICK_ADD = 1002
        private const val DEFAULT_TITLE = "Zettask · Hari Ini"
        private const val DEFAULT_EMPTY_TEXT = "Semua tugas hari ini selesai."
        private const val KEY_ACTIVE_COUNT = "today_active_count"
        private const val KEY_TASKS_JSON = "today_tasks_json"
        private const val KEY_WIDGET_TITLE = "widget_title"
        private const val KEY_WIDGET_EMPTY_TEXT = "widget_empty_text"
        private const val KEY_WIDGET_STYLE = "widget_style"
        private const val FLUTTER_PREFS_NAME = "FlutterSharedPreferences"
        private const val FLUTTER_KEY_WIDGET_STYLE = "flutter.zettask_widget_style"
        private const val STYLE_STANDARD = "standard"
        private const val STYLE_AMOLED = "amoled"
        private const val STYLE_TRANSLUCENT = "translucent"
    }
}
