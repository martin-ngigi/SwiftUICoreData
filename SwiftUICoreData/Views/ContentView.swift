//
//  ContentView.swift
//  SwiftUICoreData
//
//  Created by Martin Wainaina on 03/05/2024.
//

import SwiftUI

struct ContentView: View {
    
    @FetchRequest(fetchRequest: Movie.all)
    private var movieResults: FetchedResults<Movie>
    
    @State private var isPresented: Bool = false
    
    private func deleteMovie(indexSet: IndexSet){
        guard let index = indexSet.map({ $0 }).first else { return }
        let movie = movieResults[index]
        do {
            try movie.delete()
        }
        catch {
            print("DEBUG: failed to delete movie with error \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(movieResults) { movie in
                    //Text(movie.title ?? "")
                    NavigationLink(movie.title ?? "", value: movie)
                }
                .onDelete(perform: deleteMovie)
            }
            .navigationDestination(for: Movie.self, destination: { movie in
               // Navigating to detail view where allows us to update the movie
                AddUpdateMovieView(movie: movie)
            })
            .navigationTitle("Movies")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        isPresented = true
                    }
                }
            }
            .sheet(isPresented: $isPresented) {
                AddUpdateMovieView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, CoreDataProvider.shared.viewContext)

}
