/*
 * Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
 * contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
 * for Digital Health and Prevention -- A research institute of the
 * Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
 * Förderung der wissenschaftlichen Forschung).
 * Licensed under the Apache 2.0 license with Commons Clause
 * (see https://www.apache.org/licenses/LICENSE-2.0 and
 * https://commonsclause.com/).
 */

package at.lbidhp.aktivplan

import android.content.Context
import android.graphics.BitmapFactory
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.glance.GlanceId
import androidx.glance.GlanceModifier
import androidx.glance.Image
import androidx.glance.LocalContext
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.provideContent
import androidx.glance.background
import androidx.glance.currentState
import androidx.glance.layout.Alignment
import androidx.glance.layout.Box
import androidx.glance.layout.ContentScale
import androidx.glance.layout.fillMaxSize
import androidx.glance.layout.padding
import androidx.glance.text.Text
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import java.net.URL

class KlimafitPlantHomeWidget : GlanceAppWidget() {
  override suspend fun provideGlance(context: Context, id: GlanceId) {
    provideContent { WidgetContent() }
  }

  companion object {
    /** Same id as HomeWidget.saveImage / saveWidgetData in Flutter (`_imageKey` in main.dart). */
    private const val HOME_WIDGET_PREFERENCES = "HomeWidgetPreferences"
    private const val IMAGE_URL = "plantImageUrl"
    private const val IMAGE_PATH = "plantImagePath"
  }

  @Composable
  private fun WidgetContent() {
    val context = LocalContext.current
    val prefs = context.getSharedPreferences(HOME_WIDGET_PREFERENCES, Context.MODE_PRIVATE)
    val imageUrl = prefs.getString(IMAGE_URL, null)
    val imagePath = prefs.getString(IMAGE_PATH, null)
    var bitmap by remember { mutableStateOf<android.graphics.Bitmap?>(null) }
    var exceptionText by remember { mutableStateOf("") }

    LaunchedEffect(imageUrl, imagePath) {
      bitmap = null
      exceptionText = ""

      // Try loading from network URL first
      if (!imageUrl.isNullOrEmpty()) {
        try {
          bitmap = withContext(Dispatchers.IO) {
            URL(imageUrl).openStream().use { stream ->
              BitmapFactory.decodeStream(stream)
            }
          }
        } catch (e: Exception) {
          exceptionText = e.message ?: e.toString()
        }
      }

      // If network loading failed, try loading from saved file path
      if (bitmap == null && !imagePath.isNullOrEmpty()) {
        try {
          val path = if (imagePath.startsWith("file://")) imagePath.removePrefix("file://") else imagePath
          bitmap = withContext(Dispatchers.IO) {
            BitmapFactory.decodeFile(path)
          }
        } catch (e: Exception) {
          exceptionText = exceptionText + "; " + (e.message ?: e.toString())
        }
      }
    }

    Box(
        modifier = GlanceModifier.fillMaxSize().background(Color.White),
        contentAlignment = Alignment.Center,
    ) {
      Box(
          modifier = GlanceModifier.fillMaxSize().padding(16.dp),
          contentAlignment = Alignment.Center,
      ) {
        if (bitmap != null) {
          Image(
              provider = androidx.glance.ImageProvider(bitmap!!),
              contentDescription = null,
              modifier = GlanceModifier.fillMaxSize(),
              contentScale = ContentScale.Fit,
          )
        } else {
          Text(text = "Bitte in aktivplan+ einloggen")
        }
      }
    }
  }
}