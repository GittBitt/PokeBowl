//
//  BerryViewModel.swift
//  Pokeberry
//
//  Created by Nghi Huynh on 10/28/24.
//

import Foundation

class BerryViewModel: ObservableObject {
    @Published var berries: [BerryResponse] = []

    func fetchBerries() {
        // Clear the array to prevent duplicates
        self.berries.removeAll()

        let berryCount = 10 // Fetch berries with IDs 1...10
        let group = DispatchGroup()
        
        for id in 1...berryCount {
            group.enter()
            fetchBerryData(withID: id) { berryResponse in
                if let berry = berryResponse {
                    DispatchQueue.main.async {
                        self.berries.append(berry)
                    }
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.berries.sort { $0.id < $1.id }
            print("All berry data fetched and sorted.")
        }
    }

    private func fetchBerryData(withID id: Int, completion: @escaping (BerryResponse?) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/berry/\(id)/") else {
            print("Invalid URL")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching berry data: \(String(describing: error))")
                completion(nil)
                return
            }

            do {
                let berryResponse = try JSONDecoder().decode(BerryResponse.self, from: data)
                completion(berryResponse)
            } catch {
                print("Error decoding berry JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
