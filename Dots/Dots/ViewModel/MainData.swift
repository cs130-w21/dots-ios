//
//  DotsData.swift
//  Dots
//
//  Created by Jack Zhao on 1/9/21.
//

import Foundation

class MainData: ObservableObject {
    private static var documentsFolder : URL {
        do {
            return try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false)
        } catch {
            fatalError("Cannot find documents directory.")
        }
    }
    
    private static var fileURL: URL {
        return documentsFolder.appendingPathComponent("dots.data")
    }
    
    @Published var mainData: DotsData = DotsData()
    
    func load() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = try? Data(contentsOf: Self.fileURL) else {
                return
            }
            guard let loadedDots = try? JSONDecoder().decode(DotsData.self, from: data) else {
                fatalError("Unable to decode the Dots data.")
            }
            DispatchQueue.main.async {
                self?.mainData = loadedDots
            }
        }
    }
    
    func save() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let saveMainData = self?.mainData else { fatalError("Self out of scope")}
            guard let data = try? JSONEncoder().encode(saveMainData) else { fatalError("Error encoding data.") }
            do {
                let outfile = Self.fileURL
                try data.write(to: outfile)
            } catch {
                fatalError("Cannot write to file.")
            }
        }
    }
}
