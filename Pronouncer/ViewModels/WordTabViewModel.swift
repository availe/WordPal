import SwiftUI

class WordTabViewModel: ObservableObject {
    // vector of words we have added in AddWordView()
    @Published var savedWords: [WordEntry]?
    @Published var currSelectedWord: WordEntry?
    
    func selectWord(for wordEntry: WordEntry) {
        currSelectedWord = wordEntry
    }
}

struct SelectWordBarTitle: View {
    var body: some View {
        Text("Saved Words:").font(.system(size: 20.0, weight: .semibold)).padding(.vertical, 10).padding(.leading, 10).frame(maxWidth: .infinity, alignment: .leading).padding(.top)
    }
}

struct SelectWordBar: View {
    @ObservedObject var wordTabViewModel: WordTabViewModel
    
    var body: some View {
        // creates each button in a HStack
        HStack(spacing: 0) {
            ForEach (wordTabViewModel.savedWords ?? []) { wordEntry in
                WordTabBtn(wordEntry: wordEntry, viewModel: wordTabViewModel)
            }
        }
    }
}

struct WordTabBtn: View {
    let wordEntry: WordEntry
    let viewModel: WordTabViewModel
    
    var body: some View {
        Button {
            viewModel.selectWord(for: wordEntry)
        } label: {
            HStack {
                Text(wordEntry.word).fontWeight(.semibold).foregroundColor(.white).padding(.horizontal, 40).padding(.vertical, 20).frame(maxWidth: .infinity)
            }
        }.background(wordEntry.color.opacity(0.95)).cornerRadius(0).shadow(radius:3, x:0, y:3)
            .contextMenu(ContextMenu(menuItems: {
                // option to delete word upon long press of wordTabBtn
                Button {
                    guard let index = viewModel.savedWords?.firstIndex(where: {
                        $0.id == wordEntry.id
                    }) else {return}
                    viewModel.savedWords?.remove(at: index)
                } label: {
                    Label("Delete word", systemImage: "trash")
                }
            }))
    }
}

#Preview {
    VStack {
        SelectWordBarTitle()
        ScrollView.init(.horizontal, showsIndicators: false) {
            SelectWordBar(wordTabViewModel: WordTabViewModel())
        }
        Spacer()
    }
}

