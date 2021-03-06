//
//  ContentView.swift
//  WordScramble
//
//  Created by mZain on 21/04/2021.
//

import SwiftUI
struct DrawText: ViewModifier {
    let font = Font.system(size: 22, weight: .heavy, design: .default)
    
    func body(content: Content) -> some View {
        content
        .font(font)
    }
}

struct DrawHorizontalText: View {
    var text: String
    var textResult: String
    
    var body: some View {
        HStack {
            Text(text)
            .modifier(DrawText())
                .foregroundColor(Color.green)
            
            Text(textResult)
            .modifier(DrawText())
                .foregroundColor(Color.red)
        }
    }
}
struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
//    alert
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var countLetter_in_word = 0
    @State private var listCount:Int = 0
    var scoreCount:Int {
        
        let scorePoint = countLetter_in_word
        return scorePoint
    }
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text : $newWord, onCommit: addNewWord)
//                    off the auto capitlization
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                List(usedWords ,id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text("Dynamic row \($0)")
                }
                Text("Your Score is : \(scoreCount)>>>\(listCount)")
                DrawHorizontalText(text: "Score: ", textResult: "\(scoreCount)")
                .navigationTitle(rootWord)
                .onAppear(perform: startGame)
            }
            .navigationBarItems(leading:
                Button(action : startGame) {
                  Text("Start Over")
                })
            
        }
        .alert(isPresented: $showingError) {
            Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }
    func addNewWord() {
        // lowercase and trim the word, to make sure we don't add duplicate words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        // exit if the remaining string is empty
        guard answer.count > 0 else {
            return
        }

        // extra validation to come
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real word.")
            return
        }

        usedWords.insert(answer, at: 0)
        countLetter_in_word += newWord.count
        listCount = usedWords.count
        
        newWord = ""
    }
    
    func isOriginal(word:String) -> Bool{
        !usedWords.contains(word)
    }
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }
    func isReal(word: String) -> Bool {
//        not disallowd word less theen 4
        if word.count < 4 {
            return false
        }
//        Compare first letter of input word with the root if they r same return false
        if word == rootWord {
            return false
        }
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    func startGame() {
        // 1. Find the URL for start.txt in our app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // 2. Load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL) {
                // 3. Split the string up into an array of strings, splitting on line breaks
                let allWords = startWords.components(separatedBy: "\n")

                // 4. Pick one random word, or use "silkworm" as a sensible default
                rootWord = allWords.randomElement() ?? "silkworm"

                // If we are here everything has worked, so we can exit
                return
            }
        }

        // If were are *here* then there was a problem ??? trigger a crash and report the error
        fatalError("Could not load start.txt from bundle.")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
