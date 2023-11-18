import Foundation
import SwiftUI

class WordEntry: Identifiable, Equatable {
    static func == (lhs: WordEntry, rhs: WordEntry) -> Bool {
        lhs.id == rhs.id
    }
    
    // in retrospect should've used UUID but ColorManager relies on id being an Int
    let id: Int
    let word: String
    var color: Color { ColorManager.instance.getColor(index: id) }
    var definition: String?
    
    init(id: Int, word: String, definition: String? = nil) {
        self.id = id
        self.word = word
        self.definition = definition
    }
}

class ColorManager {
    // singleton instance for ColorManager
    static let instance = ColorManager()
    private let colors: [Color] = [.blue, .green]
    
    func getColor(index: Int) -> Color {
        return colors[index % colors.count]
    }
}
