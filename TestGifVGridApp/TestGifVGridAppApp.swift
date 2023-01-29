//
//  TestGifVGridAppApp.swift
//  TestGifVGridApp
//
//  Created by Andy Lin on 1/29/23.
//

import SwiftUI

@main
struct TestGifVGridAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct GifObject: Codable {
    let images: Images
}

struct GifObjectShell: Codable, Identifiable {
    var id = UUID()
    
    let data: GifObject
    
    private enum CodingKeys : String, CodingKey {
        case data
    }
}

struct Object: Codable {
    let url: String
}

struct Images: Codable {
    let fixed_height_downsampled: Object
}

func pullImages() async throws -> [GifObjectShell] {
    var gifObjects: [GifObjectShell] = []
    for i in 0...100 {
        let request = URLRequest(url: URL(string: "https://api.giphy.com/v1/gifs/random?api_key=oCBbE8KLSchvtU06IIFCGJiGGsQUXhBJ&tag=&rating=g")!)
        let (data, response) = try await URLSession.shared.data(for: request)
        let parsedData = try JSONDecoder().decode(GifObjectShell.self, from: data)
        gifObjects.append(parsedData)
    }
    return gifObjects
}
