import SwiftUI

struct AddWordView: View {
    @Binding var savedWords: [WordEntry]?
    @State var userInput: String = ""
    
    var body: some View {
            VStack{
                Spacer()
                TextField("Type word you want to add", text: $userInput)
                    .padding(.all).frame(maxWidth: 250)
                Button {
                    // we start from -1 so that first word created has id of 0
                    let newId = (savedWords?.last?.id ?? -1) + 1
                    if savedWords == nil {
                        savedWords = []
                    }
                    let newEntry = WordEntry(id: newId, word: userInput)
                    savedWords?.append(newEntry)
                    // we reset userInput after each submission
                    userInput = ""
                }
            label: {
                Label("Add Word", systemImage: "plus").foregroundStyle(.white)
            }.padding(.top)
                Spacer()
            }
    }
}

#Preview {
    AddWordView(savedWords: .constant([WordEntry(id: 0, word: "sample", definition: "placeholder")]))
}
