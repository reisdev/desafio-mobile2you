//
//  SceneView.swift
//  Mobile2You
//
//  Created by ReisDev on 19/04/21.
//

import SwiftUI

struct SceneView: View {
    var body: some View {
        NavigationView{
            MoviesView(presenter: MoviesPresenter(interactor: MoviesInteractor()))
        }
    }
}
