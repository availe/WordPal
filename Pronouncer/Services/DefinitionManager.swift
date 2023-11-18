import Foundation

class DefinitionManager {
    // fetches a definition string, which is later used in definitionViewModel() to update the definition of currSelectedWord
    static func fetchDefinition(for wordEntry: WordEntry, completion: @escaping (String?) -> Void) {
        APIManager.fetchJSON(for: wordEntry) { dictionaryEntry in
                // navigate to struct Meanings
                let firstMeaning = dictionaryEntry.first?.meanings?.first
                // navigate to struct Definitions and get definition string from it
                let definition = firstMeaning?.definitions.first?.definition
                let updatedEntry = wordEntry
                DispatchQueue.main.async {
                updatedEntry.definition = definition ?? "No definition available."
                completion(updatedEntry.definition)
                }
        }
    }
}
