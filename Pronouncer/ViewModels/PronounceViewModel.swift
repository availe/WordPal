import SwiftUI
import AVFoundation

struct PronounceViewModel: View {
    @Binding var currSelectedWord: WordEntry?
    private let synthesizer = AVSpeechSynthesizer()
    
    var body: some View {
        Button {
            if let wordEntry = currSelectedWord {
                let readThis = "Word: \(wordEntry.word). Definition: \(wordEntry.definition ?? "No definition available")"
                let utterance = AVSpeechUtterance(string: readThis)
                utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                utterance.rate = 0.4
                synthesizer.speak(utterance)
            }
        } label: {
            Label("Hear Pronunciation", systemImage: "speaker").foregroundColor(.white).font(.title2)
        }.padding(.all, 10).cornerRadius(3.0)
        
    }
}

#Preview {
    PronounceViewModel(currSelectedWord: .constant(WordEntry(id: 0, word: "sample", definition: "definition")))
}
