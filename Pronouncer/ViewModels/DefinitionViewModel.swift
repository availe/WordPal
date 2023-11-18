import SwiftUI

struct WordDefinition: View {
    @State private var isExpanded = false
    @Binding var currSelectedWord: WordEntry?
    @State var definition: String = "Loading definition..."
    
    var body: some View {
        let titleKey = currSelectedWord?.word ??  "Waiting for word..."
        
        DisclosureGroup(
            isExpanded: $isExpanded,
            content: {
                ScrollView {
                    Text(definition).font(.title2).foregroundStyle(.white)
                }
            },
            label: {
                HStack {
                    Spacer()
                    Image(systemName: isExpanded ? "lightbulb.fill" : "lightbulb").font(.title2).foregroundColor(.white)
                    Text(titleKey).font(.title).fontWeight(.semibold).foregroundStyle(.white)
                    Spacer()
                }
            }
        ).padding(.all, 5).frame(maxWidth: 250, alignment: .center).cornerRadius(3.0).disabled(currSelectedWord == nil)
            .onChange(of: currSelectedWord) {
            if let wordEntry = currSelectedWord {
                DefinitionManager.fetchDefinition(for: wordEntry) { definition in
                    // used to update content: in DisclosureGroup, or the box where you see the definition displayed in
                    self.definition = definition ?? "No definition available"
                    // used to pass around the definition to other Views and ViewModels
                    self.currSelectedWord?.definition = definition ?? "No definition available"
                }
            }
        }
    }
}

#Preview {
    WordDefinition(currSelectedWord: .constant(WordEntry(id: 0, word: "Sample")))
}
