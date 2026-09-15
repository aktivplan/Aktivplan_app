// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

//
//  HomeWidgets.swift
//  HomeWidgets
//
//  Created by Alphaport on 19.05.26.
//

import WidgetKit
import SwiftUI
import UIKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> KlimafitPlantEntry {
        KlimafitPlantEntry(date: Date(), plantImagePath: "", plantImageUrl: "", imageData: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (KlimafitPlantEntry) -> ()) {
        let prefs = UserDefaults(suiteName: "group.at.lbidhp.aktivplan")
        let plantImagePath = prefs?.string(forKey: "plantImagePath") ?? ""
        let plantImageUrl = prefs?.string(forKey: "plantImageUrl") ?? ""

        let data = fetchImageData(urlString: plantImageUrl, pathString: plantImagePath)
        let entry = KlimafitPlantEntry(date: Date(), plantImagePath: plantImagePath, plantImageUrl: plantImageUrl, imageData: data)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let prefs = UserDefaults(suiteName: "group.at.lbidhp.aktivplan")
        let plantImagePath = prefs?.string(forKey: "plantImagePath") ?? ""
        let plantImageUrl = prefs?.string(forKey: "plantImageUrl") ?? ""

        let data = fetchImageData(urlString: plantImageUrl, pathString: plantImagePath)
        let entry = KlimafitPlantEntry(date: Date(), plantImagePath: plantImagePath, plantImageUrl: plantImageUrl, imageData: data)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

// Helper: try load data from URL first, then fallback to file path
private func fetchImageData(urlString: String, pathString: String) -> Data? {
    // Try network
    if let url = URL(string: urlString), !urlString.isEmpty {
        let semaphore = DispatchSemaphore(value: 0)
        var resultData: Data? = nil
        var request = URLRequest(url: url)
        request.timeoutInterval = 8
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let d = data, let http = response as? HTTPURLResponse, http.statusCode == 200 {
                resultData = d
            }
            semaphore.signal()
        }
        task.resume()
        _ = semaphore.wait(timeout: .now() + 9)
        if let d = resultData {
            return d
        }
    }

    // Fallback to local file path (may include file://)
    if !pathString.isEmpty {
        var path = pathString
        if path.hasPrefix("file://") {
            path = String(path.dropFirst("file://".count))
        }
        let fileUrl = URL(fileURLWithPath: path)
        do {
            let d = try Data(contentsOf: fileUrl)
            return d
        } catch {
            // ignore
        }
    }

    return nil
}

struct KlimafitPlantEntry: TimelineEntry {
    let date: Date
    let plantImagePath: String
    let plantImageUrl: String
    let imageData: Data?
}

struct KlimafitPlantHomeWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            if let d = entry.imageData, let uiImage = UIImage(data: d) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(8)
            } else {
                VStack {
                    Text("Bitte in aktivplan+ einloggen")
                        .multilineTextAlignment(.center)
                        .padding(8)
                }
            }
        }
    }
}

struct KlimafitPlantHomeWidget: Widget {
    let kind: String = "KlimafitPlantHomeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                KlimafitPlantHomeWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                KlimafitPlantHomeWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Klimafit Pflanze")
        .description("Aktueller Trainingsfortschritt dargestellt als Pflanze")
    }
}

struct DailyActivitiesProvider: TimelineProvider {
    func placeholder(in context: Context) -> DailyActivitiesEntry {
        DailyActivitiesEntry(date: Date(), dailyActivitiesImagePath: "", dailyActivitiesImageUrl: "", imageData: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (DailyActivitiesEntry) -> ()) {
        let prefs = UserDefaults(suiteName: "group.at.lbidhp.aktivplan")
        let imagePath = prefs?.string(forKey: "dailyActivitiesImagePath") ?? ""
        let imageUrl = prefs?.string(forKey: "dailyActivitiesImageUrl") ?? ""

        let data = fetchImageData(urlString: imageUrl, pathString: imagePath)
        let entry = DailyActivitiesEntry(date: Date(), dailyActivitiesImagePath: imagePath, dailyActivitiesImageUrl: imageUrl, imageData: data)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<DailyActivitiesEntry>) -> ()) {
        let prefs = UserDefaults(suiteName: "group.at.lbidhp.aktivplan")
        let imagePath = prefs?.string(forKey: "dailyActivitiesImagePath") ?? ""
        let imageUrl = prefs?.string(forKey: "dailyActivitiesImageUrl") ?? ""

        let data = fetchImageData(urlString: imageUrl, pathString: imagePath)
        let entry = DailyActivitiesEntry(date: Date(), dailyActivitiesImagePath: imagePath, dailyActivitiesImageUrl: imageUrl, imageData: data)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct DailyActivitiesEntry: TimelineEntry {
    let date: Date
    let dailyActivitiesImagePath: String
    let dailyActivitiesImageUrl: String
    let imageData: Data?
}

struct DailyActivitiesHomeWidgetEntryView: View {
    var entry: DailyActivitiesProvider.Entry

    var body: some View {
        ZStack {
            if let d = entry.imageData, let uiImage = UIImage(data: d) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(8)
            } else {
                VStack {
                    Text("Bitte in aktivplan+ einloggen")
                        .multilineTextAlignment(.center)
                        .padding(8)
                }
            }
        }
    }
}

struct DailyActivitiesHomeWidget: Widget {
    let kind: String = "DailyActivitiesHomeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: DailyActivitiesProvider()) { entry in
            if #available(iOS 17.0, *) {
                DailyActivitiesHomeWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                DailyActivitiesHomeWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Tagesaktivitäten")
        .description("Darstellung der heutigen geplanten Aktivitäten")
    }
}

#if canImport(WidgetKit)
@available(iOS 17.0, *)
#Preview(as: .systemSmall) {
    KlimafitPlantHomeWidget()
} timeline: {
    KlimafitPlantEntry(date: .now, plantImagePath: "", plantImageUrl: "", imageData: nil)
}

@available(iOS 17.0, *)
#Preview(as: .systemSmall) {
    DailyActivitiesHomeWidget()
} timeline: {
    DailyActivitiesEntry(date: .now, dailyActivitiesImagePath: "", dailyActivitiesImageUrl: "", imageData: nil)
}
#endif
