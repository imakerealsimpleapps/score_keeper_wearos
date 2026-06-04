/* package com.imakerealsimpleapps.score_keeper

import android.content.Context
import androidx.wear.protolayout.ActionBuilders
import androidx.wear.protolayout.ColorBuilders
import androidx.wear.protolayout.DimensionBuilders
import androidx.wear.protolayout.LayoutElementBuilders
import androidx.wear.protolayout.ModifiersBuilders
import androidx.wear.protolayout.TimelineBuilders
import androidx.wear.tiles.RequestBuilders
import androidx.wear.tiles.ResourceBuilders
import androidx.wear.tiles.TileBuilders
import androidx.wear.tiles.TileService
import com.google.common.util.concurrent.Futures
import com.google.common.util.concurrent.ListenableFuture

import android.graphics.Color

class ScoreTileService :  SuspendingTileService()  {

    private val RESOURCES_VERSION = "1"

    companion object {
        private const val lightScoreName = "flutter.lightScore"
        private const val darkScoreName = "flutter.darkScore"
    }

    override fun onTileRequest(
        requestParams: RequestBuilders.TileRequest
    ): ListenableFuture<TileBuilders.Tile> {
        val sharedPref = getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
        // Flutter SharedPreferences usually prefixes keys with "flutter."
        // Assuming we store "left_circle_value" and "right_circle_value"
        // If stored as int in Flutter, it might be "flutter.left_circle_value"
        
        // For now, let's assume we just want to display some default or stored values.
        // The user requirement says "show a number from shared preferences".
        // I will assume keys "left_count" and "right_count".
        val leftValue = sharedPref.getLong(lightScoreName, 0)
        val rightValue = sharedPref.getLong(darkScoreName, 0)

        return Futures.immediateFuture(
            TileBuilders.Tile.Builder()
                .setResourcesVersion(RESOURCES_VERSION)
                .setTileTimeline(
                    TimelineBuilders.Timeline.Builder()
                        .addTimelineEntry(
                            TimelineBuilders.TimelineEntry.Builder()
                                .setLayout(
                                    LayoutElementBuilders.Layout.Builder()
                                        .setRoot(layout(leftValue.toString(), rightValue.toString()))
                                        .build()
                                )
                                .build()
                        )
                        .build()
                )
                .build()
        )
    }

    override fun onResourcesRequest(
        requestParams: RequestBuilders.ResourcesRequest
    ): ListenableFuture<ResourceBuilders.Resources> {
        return Futures.immediateFuture(
            ResourceBuilders.Resources.Builder()
                .setVersion(RESOURCES_VERSION)
                .build()
        )
    }

    private fun layout(leftText: String, rightText: String): LayoutElementBuilders.LayoutElement {
        return LayoutElementBuilders.Row.Builder()
            .addContent(circle(leftText, true))
            .addContent(LayoutElementBuilders.Spacer.Builder().setWidth(DimensionBuilders.dp(10f)).build())
            .addContent(circle(rightText, false))
            .setModifiers(
                ModifiersBuilders.Modifiers.Builder()
                    .setClickable(
                        ModifiersBuilders.Clickable.Builder()
                            .setId("open_app")
                            .setOnClick(
                                ActionBuilders.LaunchAction.Builder()
                                    .setAndroidActivity(
                                        ActionBuilders.AndroidActivity.Builder()
                                            .setClassName(MainActivity::class.java.name)
                                            .setPackageName(this.packageName)
                                            .build()
                                    ).build()
                            ).build()
                    ).build()
            )
            .build()
    }

    private fun circle(text: String, isLeft: Boolean): LayoutElementBuilders.LayoutElement {
        val bgColor = if (isLeft) Color.WHITE else Color.DKGRAY
        val textColor = if (isLeft) Color.BLACK else Color.WHITE

        return LayoutElementBuilders.Box.Builder()
            .setWidth(DimensionBuilders.dp(60f))
            .setHeight(DimensionBuilders.dp(60f))
            .setModifiers(
                ModifiersBuilders.Modifiers.Builder()
                    .setBackground(
                        ModifiersBuilders.Background.Builder()
                            .setColor(ColorBuilders.argb(bgColor))
                            .setCorner(ModifiersBuilders.Corner.Builder().setRadius(DimensionBuilders.dp(30f)).build())
                            .build()
                    ).build()
            )
            .addContent(
                LayoutElementBuilders.Text.Builder()
                    .setText(text)
                    .setFontStyle(
                        LayoutElementBuilders.FontStyle.Builder()
                            .setColor(ColorBuilders.argb(textColor))
                            .build()
                    ).build()
            ).build()
    }
}
*/