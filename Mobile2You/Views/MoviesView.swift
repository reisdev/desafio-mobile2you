//
//  MovieView.swift
//  Mobile2You
//
//  Created by ReisDev on 19/04/21.
//

import SwiftUI

struct MoviesView: View {

    @ObservedObject var presenter: MoviesPresenter;
    
    var body: some View {
        if presenter.movie != nil {
            Image(presenter.movie.poster_path)}
        else {
            HStack(alignment: .center) {
                ProgressView()
                    .scaleEffect(2,anchor: .center)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
