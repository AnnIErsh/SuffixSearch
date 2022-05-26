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
    
    var setSuffix: NSCountedSet {
        NSCountedSet(array: data)
    }
    
    var arrSuffix: Array<Any> {
        var arr = Array(setSuffix)
        arr.removeAll { ($0 as! Suffix).name.count < 3 }
        arr.sort { setSuffix.count(for: $0) > setSuffix.count(for: $1) }
        return Array(arr.prefix(4))
    }
}

struct WidgetTextEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            Text(entry.date, style: .time)
            VStack {
                ForEach(entry.arrSuffix.indices, id: \.self) { i in
                    HStack {
                        Text(String((entry.arrSuffix[i] as AnyObject).description))
                            .padding(16)
                        Spacer()
                        Text("\(entry.setSuffix.count(for: entry.arrSuffix[i]))")
                            .padding(16)
                    }
                }
            }
            HStack {
                Link(destination: URL(string: "textApp://link/0")!) {
                    Text("text")
                        .foregroundColor(.blue)
                        .padding(16)
                }
                Spacer()
                Link(destination: URL(string: "textApp://link/2")!) {
                    Text("sort")
                        .foregroundColor(.blue)
                        .padding(16)
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
