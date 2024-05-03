//
//  AddUpdateMovieView.swift
//  SwiftUICoreData
//
//  Created by Martin Wainaina on 03/05/2024.
//

import SwiftUI

struct EditMovieConfig {
    var title: String = ""
    
    init(movie: Movie? = nil) {
        guard let movie = movie else { return }
        self.title = movie.title ?? ""
    }
}

struct AddUpdateMovieView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    var movie: Movie?
    @State private var editMovieConfig = EditMovieConfig()
    
    private func addOrUpdateMovie() {
        let movie = movie ?? Movie(context: viewContext) //if movie is nil, add a new Moview else update existing movie
        movie.title = editMovieConfig.title
        do {
            try movie.save()
            dismiss()
        }
        catch {
            print("DEBUG: Failed to save movie with error \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        Form {
            TextField("Title", text: $editMovieConfig.title)
                .textFieldStyle(.roundedBorder)
            
            Button("Save") {
                addOrUpdateMovie()
            }
        }
        .onAppear{
            if let movie = movie {
                editMovieConfig = EditMovieConfig(movie: movie)
            }
        }
    }
}

#Preview {
    AddUpdateMovieView()
        //.environment(\.managedObjectContext, CoreDataProvider.shared.viewContext)

}
