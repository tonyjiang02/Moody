//
//  MoodyWidget.swift
//  MoodyWidget
//
//  Created by Tony Jiang on 4/17/22.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> ImageEntry {
        ImageEntry(date: Date(), image: "annie_sad")
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (ImageEntry) -> ()) {
        let entry = ImageEntry(date: Date(), image: "annie_sad")
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [ImageEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = ImageEntry(date: entryDate, image: "annie_sad")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct ImageEntry: TimelineEntry {
    let date: Date
    let image: String
}

struct MoodyWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
//        Image(systemName: "plus").resizable().scaledToFill().frame(width: 300, height: 300)
//        Image(entry.image).resizable().scaledToFill().frame(width: 300, height: 300)
        Image("annie_sad").resizable().scaledToFit()
    }
}

@main
struct MoodyWidget: Widget {
    let kind: String = "MoodyWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            MoodyWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}
