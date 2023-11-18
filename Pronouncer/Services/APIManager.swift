import Foundation

class APIManager {
    // fetchJSON() based off this: https://github.com/StewartLynch/DemystifyingCompletionHandlers/blob/main/LilStockQuote/Extensions%20%26%20Utilities/Service.swift
    // app crashes whenever error occurs (such as if word not found), which is not ideal
    static func fetchJSON(for wordEntry: WordEntry, completion: @escaping ([DictionaryEntry]) -> Void) {
        let url = "https://api.dictionaryapi.dev/api/v2/entries/en/\(wordEntry.word)"
        guard let url = URL(string: url) else {
            fatalError("URL could not be constructed")
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) {data, response, error in
            if let error = error {
                fatalError("Error retieving quote: \(error.localizedDescription)")
            }
            let decoder = JSONDecoder()
            guard let data = data else {
                fatalError("Data could not be retrieved")
            }
            do {
                let entry = try decoder.decode([DictionaryEntry].self, from: data)
                completion(entry)
            } catch {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("JSON String on error: \(jsonString)")
                }
                fatalError("Error while decoding data, \(error.localizedDescription)")
            }
        }
        .resume()
    }
}

struct Phonetics: Decodable {
    let text: String?
    let audio: String?
}

struct Meanings: Decodable {
    let partOfSpeech: String?
    let definitions: [Definition]
}

struct Definition: Decodable {
    let definition: String?
    let example: String?
    let synonyms: [String]?
    let antonyms: [String]?
}

struct DictionaryEntry: Decodable {
    let word: String
    let phonetics: [Phonetics]?
    let meanings: [Meanings]?
}
