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
        return SimpleEntry(date: Date(), data: Settings.suff)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), data: Settings.suff)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        let currentDate = Date()
        for sec in 0 ..< 3 {
            let entryDate = Calendar.current.date(byAdding: .second, value: sec, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, data: Settings.suff)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    var data: [Suffix]
}

struct WidgetTextEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            Text(entry.date, style: .time)
            Text(String((entry.data[0] as AnyObject).description))
            HStack {
                Link(destination: URL(string: "textApp://link/0")!) {
                    Text("text")
                }
                Spacer()
                Link(destination: URL(string: "textApp://link/2")!) {
                    Text("sort")
                }
            }
            .padding()
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
