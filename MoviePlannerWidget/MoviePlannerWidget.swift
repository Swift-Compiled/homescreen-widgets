//
//  MoviePlannerwidget.swift
//  MoviePlannerwidget
//
//  Created by Alex Brown on 30/06/2020.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: TimelineProvider {
    var movieUpdater: MovieUpdater = MovieUpdater()
        
    func timeline(with context: Context,
                  completion: @escaping (Timeline<MovieEntry>) -> ()) {
        // Create a timeline entry for "now."
        let date = Date()
        let entry = MovieEntry(date: date, movie: movieUpdater.movie)

        // Create a date that's 15 minutes in the future.
        let nextUpdateDate = Calendar.current.date(byAdding: .minute, value: 15, to: date)!

        // Create the timeline with the entry and a reload policy with the date
        // for the next update.
        let timeline = Timeline(
            entries: [entry],
            policy: .after(nextUpdateDate)
        )

        completion(timeline)
    }
        
    func snapshot(with context: Context,
                  completion: @escaping (MovieEntry) -> ()) {
                
        let date = Date()
        let entry = MovieEntry(date: date, movie: movieUpdater.movie)
        
        completion(entry)
    }
}

struct MovieEntry: TimelineEntry {
    public let date: Date
    public let movie: Movie
}

struct PlaceholderView : View {
    var body: some View {
        Text("Placeholder View")
    }
}

struct MoviePlannerWidgetEntryView : View {
    var entry: Provider.Entry

    var gradient: Gradient {
        Gradient(stops:
                    [Gradient.Stop(color: .clear, location: 0),
                     Gradient.Stop(color: Color.black.opacity(0.95),
                                   location: 0.6)])
    }
    
    var body: some View {
        ZStack {
            Image(entry.movie.movieImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .mask(
                    RoundedRectangle(cornerRadius: 10)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(minHeight: 0, maxHeight: .infinity)
                )
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(minHeight: 0, maxHeight: .infinity)
            
            VStack {
                Spacer()
                LinearGradient(gradient: gradient,
                               startPoint: .top,
                               endPoint: .bottom)
                    .frame(height: 100)
            }
            VStack(alignment: .leading) {
                Spacer()
                Text(entry.movie.name)
                    .padding(.all, 10)
                    .font(.headline)
                    .foregroundColor(.white)
            }
        }
    }
}

@main
struct MoviePlannerWidget: Widget {
    private let kind: String = "MoviePlannerwidget"

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,
                            provider: Provider(),
                            placeholder: PlaceholderView()) { entry in
            MoviePlannerWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}
