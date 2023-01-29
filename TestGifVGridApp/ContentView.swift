//
//  ContentView.swift
//  TestGifVGridApp
//
//  Created by Andy Lin on 1/29/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    var items: [GridItem] = Array(repeating: .init(.adaptive(minimum: 400, maximum: 1000)), count: 4)
    @State var gifs: [GifObjectShell] = []
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: items) {
                ForEach(gifs) { gif in
                    AnimatedImage(url: URL(string: gif.data.images.fixed_height_downsampled.url))
                        .resizable()
                        .scaledToFit()
                        .contextMenu {
                            Button("Copy GIF URL") {
                                NSPasteboard.general.setString(gif.data.images.fixed_height_downsampled.url, forType: .string)
                            }
                        }
                }
            }
        }
        .task {
            gifs = try! await pullImages()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
