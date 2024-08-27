//
//  ContentView.swift
//  loaly
//
//  Created by Salvatore D'Armetta on 1/23/24.
//

import SwiftUI
import AudioToolbox
import AVFoundation
import PDFKit

extension String {
    public subscript(_ idx: Int) -> Character {
        self[self.index(self.startIndex, offsetBy: idx)]
    }
}

public class Piano: NSObject {
    
    let alphabet = ["A","a","B","b","C","c","D","d","E","e","F","f","G","g","H","h","I","i","J","j","K","k","L","l","M","m","N","n","O","o","P","p","Q","q","R","r","S","s","T","t","U","u","V","v","W","w","X","x","Y","y","Z","z"]
    let alphabetPiano: [Character:UInt8] = ["A":33,"a":33,"B":35,"b":35,"C":36,"c":36,"D":38,"d":38,"E":40,"e":40,"F":41,"f":41,"G":43,"g":43,"H":45,"h":45,"I":47,"i":47,"J":48,"j":48,"K":50,"k":50,"L":52,"l":52,"M":53,"m":53,"N":55,"n":55,"O":57,"o":57,"P":59,"p":59,"Q":60,"q":60,"R":62,"r":62,"S":64,"s":64,"T":65,"t":65,"U":67,"u":67,"V":69,"v":69,"W":71,"w":71,"X":72,"x":72,"Y":74,"y":74,"Z":76,"z":76, "!":0,",":0,".":0,"?":0]
}


public class Song: Piano, ObservableObject {
    
    var sentence = ""
    var sentenceInArray: [String] = []
    var chords: [[UInt8]] = [[]]
    
    private var counter: Int = 0
    private var tracks: [Int: MusicTrack] = [:]
    
    //function to create a random piano alphabet
    private func randomPiano() -> [String: String]{
        var randomPiano: [String: String] = [:]
        var i = 0
        while i != 52{
            let temp = Int.random(in: 0..<52)
            let temporaryKeyLetter = alphabet[i]
            let temporaryValueLetter = alphabet[temp]
            
            if !randomPiano.contains(where: {$0.value == temporaryValueLetter}){
                randomPiano.updateValue(temporaryValueLetter, forKey: temporaryKeyLetter)
                i = i + 1
            }else{
                //Do Nothing
            }
        }
    
        print(randomPiano)
        return randomPiano
    }
    
    //function to generate the chords to play in MIDI
    func generateSong(userSentence: [String]) {
        
        print(userSentence)
        var vowelsInEachWord: [Int] = []
        var totalVowelCount = 0
        var letterCount = 0
        
        for i in 0..<userSentence.count{
            
            let word = userSentence[i]
            var tempCount = 0
            
            for j in 0..<word.count{
                if word[j] == "A" || word[j] == "a" || word[j] == "E" || word[j] == "e" || word[j] == "I" || word[j] == "i" || word[j] == "O" || word[j] == "o" || word[j] == "U" || word[j] == "u" || word[j] == "Y" || word[j] == "y"{
                    tempCount+=1
                }}
           
            vowelsInEachWord.append(tempCount)
        }
        
        print("This is the number of vowels in each word: ", vowelsInEachWord)
        
        for i in 0...vowelsInEachWord.count - 1{
            totalVowelCount = vowelsInEachWord[i] + totalVowelCount
        }
        
        print("This is the total number of vowels: ", totalVowelCount)
        
        var numberOfWords = userSentence.count
        if userSentence.last == "" {
            numberOfWords = numberOfWords - 1
        }
        
        print("This is the number of words: ", numberOfWords)
        
        var inputInCharacters: [Character] = []
        
        //remove punctuation
        for i in 0..<userSentence.count{
            
            let temp = userSentence[i]
            
            for mChar in temp{
                if alphabet.contains(String(mChar)){
                    inputInCharacters.append(mChar)
                }
            }
        }
        
        print(inputInCharacters)
        
        var song = String(inputInCharacters)
        
        letterCount = inputInCharacters.count
        
        var removeCount = letterCount - numberOfWords
        
        print("This is the song before removing letters: ", song)
        print("This is how many letters are being removed: ", removeCount)
        
        //make song string equal to number of words
        while(removeCount != 0){
                song.removeLast()
                removeCount-=1
        }
        
        print("This is the final song: ", song)
        
        var randomizedPiano = randomPiano()
        var fullSong = createSongString(originalSong: song, randomizedPiano: randomizedPiano, vowelsInEachWord: vowelsInEachWord, numberOfVowels: 0)
        randomizedPiano = randomPiano()
        var over1VowelSong = createSongString(originalSong: song, randomizedPiano: randomizedPiano, vowelsInEachWord: vowelsInEachWord, numberOfVowels: 1)
        randomizedPiano = randomPiano()
        var over2VowelsSong = createSongString(originalSong: song, randomizedPiano: randomizedPiano, vowelsInEachWord: vowelsInEachWord, numberOfVowels: 2)
        randomizedPiano = randomPiano()
        var over3VowelsSong = createSongString(originalSong: song, randomizedPiano: randomizedPiano, vowelsInEachWord: vowelsInEachWord, numberOfVowels: 3)
        randomizedPiano = randomPiano()
        var over4VowelsSong = createSongString(originalSong: song, randomizedPiano: randomizedPiano, vowelsInEachWord: vowelsInEachWord, numberOfVowels: 4)
        
        print(fullSong)
        print(over1VowelSong)
        print(over2VowelsSong)
        print(over3VowelsSong)
        print(over4VowelsSong)
        
        chords = [[UInt8]](repeating: [UInt8](repeating: 0, count: 0), count: fullSong.count)
        print(chords)
        
        for i in 0..<fullSong.count{
            
            if alphabet.contains(String(fullSong[i])){
                chords[i].append(alphabetPiano[fullSong[i]]!)
            }
            if alphabet.contains(String(over1VowelSong[i])){
                chords[i].append(alphabetPiano[over1VowelSong[i]]!)
            }
            if alphabet.contains(String(over2VowelsSong[i])){
                chords[i].append(alphabetPiano[over2VowelsSong[i]]!)
            }
            if alphabet.contains(String(over3VowelsSong[i])){
                chords[i].append(alphabetPiano[over3VowelsSong[i]]!)
            }
            if alphabet.contains(String(over4VowelsSong[i])){
                chords[i].append(alphabetPiano[over4VowelsSong[i]]!)
            }
        }
        
        print(chords)
    }
    
    private func createSongString(originalSong: String, randomizedPiano: [String:String], vowelsInEachWord: [Int], numberOfVowels: Int) -> String{
        var countingVowelsSong = String()
        
        for i in 0...originalSong.count - 1{
            
            let mCharArray = Array(originalSong)
            let mChar = mCharArray[i]
            
            if randomizedPiano[String(mChar)] != nil{
                if vowelsInEachWord[i] > numberOfVowels{
                    countingVowelsSong.append(randomizedPiano[String(mChar)]!)
                }
                else{
                    countingVowelsSong.append("_")
                }
            }
        }
        
        return countingVowelsSong
    }
}

class MidiPlayer: Song {
    @Published var musicSequence: MusicSequence?
    @Published var midiPlayer: AVMIDIPlayer?
    @Published var bankURL: URL
    
    override init() {
        
        guard let bankURL = Bundle.main.url(forResource: "FluidR3_GM2-2", withExtension: "SF2") else {
            fatalError("\"FluidR3_GM2-2.sf2\" file not found.")
        }
        self.bankURL = bankURL
        super.init()
        guard NewMusicSequence(&musicSequence) == OSStatus(noErr) else {
            fatalError("Cannot create MusicSequence")
        }
    }
    
    func prepareSong(musicSequence: MusicSequence){
        var data: Unmanaged<CFData>?
        guard MusicSequenceFileCreateData(musicSequence, MusicSequenceFileTypeID.midiType, MusicSequenceFileFlags.eraseFile, 480, &data) == OSStatus(noErr) else {
            fatalError("Cannot create music midi data")
        }
        
        if let md = data {
            let midiData = md.takeUnretainedValue() as Data
            do {
                errno = 0
                try self.midiPlayer = AVMIDIPlayer(data: midiData, soundBankURL: self.bankURL)
            } catch let error {
                fatalError(error.localizedDescription)
            }
        }
        self.midiPlayer!.prepareToPlay()
    }
    
    //function to create MIDI music sequence out of chords generated
    func createMusicSequence(chords: [[UInt8]] )  {

        var status = NewMusicSequence(&musicSequence)
        if status != noErr {
            print(" bad status \(status) creating sequence")
        }
        
        var tempoTrack: MusicTrack?
        if MusicSequenceGetTempoTrack(musicSequence!, &tempoTrack) != noErr {
            assert(tempoTrack != nil, "Cannot get tempo track")
        }

        if MusicTrackNewExtendedTempoEvent(tempoTrack!, 0.0, 256.0) != noErr {
            print("could not set tempo")
        }
        if MusicTrackNewExtendedTempoEvent(tempoTrack!, 4.0, 256.0) != noErr {
            print("could not set tempo")
        }
        
        
        // add a track
        var track: MusicTrack?
        status = MusicSequenceNewTrack(musicSequence!, &track)
        if status != noErr {
            print("error creating track \(status)")
        }
        
        // make some notes and put them on the track
        var beat: MusicTimeStamp = 0.0
       
        for batch in 0..<chords.count {
            for note: UInt8 in chords[batch] {
                var mess = MIDINoteMessage(channel: 0,
                                           note: note,
                                           velocity: 64,
                                           releaseVelocity: 0,
                                           duration: 1.0 )
                status = MusicTrackNewMIDINoteEvent(track!, beat, &mess)
                if status != noErr {    print("creating new midi note event \(status)") }
                
            }
            beat += 1
        }
        
        CAShow(UnsafeMutablePointer<MusicSequence>(musicSequence!))
        
    }
    
    func playSong() async {
        if let md = self.midiPlayer {
            if md.isPlaying {
                md.stop()
            } else {
                md.currentPosition = 0
                await md.play()
                
            }
        }
    }
    
    private func generateMIDIFile(musicSequence: MusicSequence) {
                
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
        let qwertyURL = documentDirectoryURL.appendingPathComponent("mySong.m4a")
        
        guard MusicSequenceFileCreate(musicSequence, qwertyURL! as CFURL, MusicSequenceFileTypeID.midiType, MusicSequenceFileFlags.eraseFile, 0) == OSStatus(noErr) else{
            fatalError("Cannot create midi file")
        }
        
    }
    
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView: View {
   
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(sortDescriptors: []) private var userSongs: FetchedResults<UserSong>
    
    @State private var userText = ""
    @State private var showAlert = false
    @State private var enterButtonIsPresented = false
    @State private var uploadButtonIsPresented = false
    @State private var importing = false
    @State private var isLoading = false
    
    @ObservedObject var player: MidiPlayer
    @ObservedObject var detailViewPlayer: MidiPlayer
    
    @EnvironmentObject var song: Song
    
    private let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.pdf], asCopy: true)
    
    var body: some View {
        TabView{
            NavigationView{
                ZStack{
                    Color.yellow
                        .ignoresSafeArea()
                    VStack{
                        HStack{
                            Image("ostrich logo-02")
                                .resizable()
                                .frame(width: 300, height: 300)
                                .aspectRatio(contentMode: .fill)
                        }
                        userTextField
                        Spacer()
                        Text("or")
                            .font(.system(size: 50))
                            .frame(width: 100, height: 100)
                        Spacer()
                        Text("Upload File(PDF): ")
                        Spacer()
                        uploadPDFButton
                        Spacer()
                    }
                    if isLoading{
                        LoadingView()
                    }
                }
                .onDisappear(){
                    isLoading = false
                }
                .onTapGesture {
                    UIApplication.shared.endEditing()
                }
                
            }
            .tabItem {
                Image(systemName: "house.fill")
            }
            .navigationViewStyle(.stack)
            savedSongsView
                .tabItem { Image(systemName: "list.bullet") }
        }
    }
    
    private var userTextField: some View{
        HStack{
            Spacer()
            TextField("Enter a Sentence", text: $userText)
                .padding()
                .textFieldStyle(OvalTextFieldStyle())
                .submitLabel(.done)
            NavigationLink(destination: SongView(player: player), isActive: $enterButtonIsPresented){
                Image(systemName: "arrow.right.circle").renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .accentColor(.black)
                    .padding()
                    .onTapGesture {
                        isLoading = true
                        song.sentence = userText
                        song.sentenceInArray = userText.components(separatedBy: " ")
                        
                        isUnder2000Words(song: song)
                        enterButtonIsPresented = true
                    }
            }
            .disabled(userText.isEmpty)
            
        }.alert(isPresented: $showAlert) {
            Alert(
                title: Text("Text is Too Long"),
                message: Text("Please enter a shorter text")
            )
        }
    }
    
    private var uploadPDFButton: some View{
        HStack{
            NavigationLink(destination: SongView(player: player), isActive: $uploadButtonIsPresented){
                Image(systemName: "square.and.arrow.up")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .accentColor(.black)
                    .padding()
                    .onTapGesture {
                        importing = true
                    }
            }
            .fileImporter(isPresented: $importing, allowedContentTypes: [.pdf]) { (res) in
                isLoading = true
                do{
                    let fileUrl = try res.get()
                    print(fileUrl)
                    
                    readPDF(fileUrl: fileUrl)
                    isUnder2000Words(song: song)
                    uploadButtonIsPresented = true
                }
                catch {
                    print("document loading error")
                }
                
            }
        }.alert(isPresented: $showAlert) {
            Alert(
                title: Text("Text is Too Long"),
                message: Text("Please enter a shorter text")
            )
        }
    }
    
    private var savedSongsView: some View{
        NavigationView{
                if #available(iOS 16.0, *) {
                    List{
                        ForEach(userSongs, id: \.name){ userSong in
                            NavigationLink{
                                DetailView(detailViewPlayer: detailViewPlayer, userSong: userSong)
                            } label: {
                                Text(userSong.name ?? "mySong")
                            }
                        }
                        .onDelete(perform: delete)
                    }
                    .navigationTitle("My Songs")
                    .navigationBarItems(leading: EditButton())
                    .scrollContentBackground(.hidden)
                    .background(Color.yellow)
                    .overlay(Group {
                        if(userSongs.count == 0) {
                            ZStack() {
                                Color.yellow.ignoresSafeArea()
                            }
                        }
                    })
                }
                else {
                    // Fallback on earlier versions
                    List{
                        ForEach(userSongs){ userSong in
                            Text(userSong.name ?? "mySong")
                        }
                        .onDelete(perform: delete)
                    }
                    .navigationTitle("My Songs")
                    .navigationBarItems(leading: EditButton())
                    .background(Color.yellow)
                    .overlay(Group {
                        if(userSongs.count == 0) {
                            ZStack() {
                                Color.yellow.ignoresSafeArea()
                            }
                        }
                    })
                }
        }
    }
    
    private func readPDF(fileUrl: URL){
        
        guard fileUrl.startAccessingSecurityScopedResource() else { return }
        
        //extract text from PDF
        if let pdf = PDFDocument(url: fileUrl) {
            let pageCount = pdf.pageCount
            let documentContent = NSMutableAttributedString()
            
            for i in 0 ..< pageCount {
                guard let page = pdf.page(at: i) else { continue }
                guard let pageContent = page.attributedString else { continue }
                documentContent.append(pageContent)
            }
            
            song.sentence = documentContent.string
            
            song.sentenceInArray = song.sentence.components(separatedBy: " ")
            
        }
    }
    
    private func isUnder2000Words(song: Song){
        if song.sentenceInArray.count > 2000{
            isLoading = false
            showAlert = true
        }
        else{
            song.generateSong(userSentence: song.sentenceInArray)
                
            player.createMusicSequence(chords: song.chords)
            player.prepareSong(musicSequence: player.musicSequence!)
        }
    }
    
    func delete(at offsets: IndexSet){
        for offset in offsets{
            let userSong = userSongs[offset]
            moc.delete(userSong)
        }
        
        try? moc.save()
    }
}

struct LoadingView: View{
    var body: some View{
        ZStack{
            Color.yellow
                .ignoresSafeArea()
            
            ProgressView()
                .progressViewStyle(.circular)
                .scaleEffect(3)
        }
    }
}

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(20)
            .shadow(color: .gray, radius: 10)
    }
}



/*
#Preview {
    ContentView()
        .environmentObject(Song())
}
*/
