//
//  WidgetText.swift
//  WidgetText
//
//  Created by Anna Ershova on 23.05.2022.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct WidgetTextEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            Text(entry.date, style: .time)
            HStack {
                Link(destination: URL(string: "textApp://link/0")!) {
                    Text("text")
                }
                Spacer()
                Link(destination: URL(string: "textApp://link/2")!) {
                    Text("sort")
                }
            }
        }
    }
}

@main
struct WidgetText: Widget {
    let kind: String = "WidgetText"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetTextEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemLarge])
    }
}
//
//struct WidgetText_Previews: PreviewProvider {
//    static var previews: some View {
//        WidgetTextEntryView(entry: SimpleEntry(date: Date()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
