import SwiftUI

struct ContentView: View {
    @StateObject private var wordTabViewModel = WordTabViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(spacing: 0){
                    SelectWordBarTitle()
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            SelectWordBar(wordTabViewModel: wordTabViewModel)
                        }
                    }
                }
                WordDefinition(currSelectedWord: $wordTabViewModel.currSelectedWord).padding(.top, 45)
                PronounceViewModel(currSelectedWord: $wordTabViewModel.currSelectedWord).padding(.top)
                Spacer()
                NavigationLink(value: navDestination.addWord, label: {
                    Label("Add Word", systemImage: "plus").foregroundStyle(.white)
                })
                Spacer()
            }.navigationTitle("Home").navigationDestination(for: navDestination.self) { destination in
                switch(destination) {
                case .addWord:
                    AddWordView(savedWords: $wordTabViewModel.savedWords)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
