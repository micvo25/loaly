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


class Pianos {
    
    let alphabetPiano: [Character:UInt8] = ["A":33,"a":33,"B":35,"b":35,"C":36,"c":36,"D":38,"d":38,"E":40,"e":40,"F":41,"f":41,"G":43,"g":43,"H":45,"h":45,"I":47,"i":47,"J":48,"j":48,"K":50,"k":50,"L":52,"l":52,"M":53,"m":53,"N":55,"n":55,"O":57,"o":57,"P":59,"p":59,"Q":60,"q":60,"R":62,"r":62,"S":64,"s":64,"T":65,"t":65,"U":67,"u":67,"V":69,"v":69,"W":71,"w":71,"X":72,"x":72,"Y":74,"y":74,"Z":76,"z":76]
    let qwertyPiano = ["A":"Q","a": "q","B":"W","b":"w","C":"E","c":"e","D":"R","d":"r","E":"T","e":"t","F":"Y","f":"y","G":"U","g":"u","H":"I","h":"i","I":"O","i":"o","J":"P","j":"p","K":"A","k":"a","L":"S","l":"s","M":"D","m":"d","N":"F","n":"f","O":"G","o":"g","P":"H","p":"h","Q":"J","q":"j","R":"K","r":"k","S":"L","s":"l","T":"Z","t":"z","U":"X","u":"x","V":"C","v":"c","W":"V","w":"v","X":"B","x":"b","Y":"N","y":"n","Z":"M","z":"m", ",":",", ".":".","!":"!","?":"?", "_":"_"]
    let backwardPiano = ["A":"Z","a":"z","B":"Y","b":"y","C":"X","c":"x","D":"W","d":"w","E":"V","e":"v","F":"U","f":"u","G":"T","g":"t","H":"S","h":"s","I":"R","i":"r","J":"Q","j":"q","K":"P","k":"p","L":"O","l":"o","M":"N","m":"n","N":"M","n":"m","O":"L","o":"l","P":"K","p":"k","Q":"J","q":"j","R":"I","r":"i","S":"H","s":"h","T":"G","t":"g","U":"F","u":"f","V":"E","v":"e","W":"D","w":"d","X":"C","x":"c","Y":"B","y":"b","Z":"A","z":"a",",":",",".":".","!":"!","?":"?"," ":" ","_":"_"]
    let halfPiano = ["A":"N","a":"n","B":"O","b":"o","C":"P","c":"p","D":"Q","d":"q","E":"R","e":"r","F":"S","f":"s","G":"T","g":"t","H":"U","h":"u","I":"V","i":"v","J":"W","j":"w","K":"X","k":"x","L":"Y","l":"y","M":"Z","m":"z","N":"A","n":"a","O":"B","o":"b","P":"C","p":"c","Q":"D","q":"d","R":"E","r":"e","S":"F","s":"f","T":"G","t":"g","U":"H","u":"h","V":"I","v":"i","W":"J","w":"j","X":"K","x":"k","Y":"L","y":"l","Z":"M","z":"m",",":",",".":".","!":"!","?":"?"," ":" ","_":"_"]
    
}


class Song: Pianos, ObservableObject {
    
    var musicSequence: MusicSequence?
    var tracks: [Int: MusicTrack] = [:]
    var sentence = ""
    var sentenceInArray: [String] = []
    var songArray: [URL?] = []
    var counter: Int = 0
    var vowelsInEachWord: [Int] = []
    var totalVowelCount = 0
    var letterCount = 0
    var generated = false
    var chords: [[UInt8]] = [[]]
    
    override init() {
        guard NewMusicSequence(&musicSequence) == OSStatus(noErr) else {
            fatalError("Cannot create MusicSequence")
        }
    }
    
    

    func generateSong(userSentence: [String]) {
        
        //inputArray = (userSentence.components(separatedBy: " "))
        print(userSentence)
        
        //count number of times vowels appear in text
        for i in 0..<userSentence.count{
            
            let temp = userSentence[i]
            var tempCount = 0
            
            if temp.contains("A"){
                tempCount += 1
            }
            if temp.contains("a"){
                tempCount+=1
            }
            if temp.contains("E"){
                tempCount+=1
            }
            if temp.contains("e"){
                tempCount+=1
            }
            if temp.contains("I"){
                tempCount+=1
            }
            if temp.contains("i"){
                tempCount+=1
            }
            if temp.contains("O"){
                tempCount+=1
            }
            if temp.contains("o"){
                tempCount+=1
            }
            if temp.contains("U"){
                tempCount+=1
            }
            if temp.contains("u"){
                tempCount+=1
            }
            if temp.contains("Y"){
                tempCount+=1
            }
            if temp.contains("y"){
                tempCount+=1
            }
            if temp.contains("."){
                vowelsInEachWord.append(0)
            }
            if temp.contains(","){
                vowelsInEachWord.append(0)
            }
            if temp.contains("?"){
                vowelsInEachWord.append(0)
            }
            if temp.contains("!"){
                vowelsInEachWord.append(0)
            }
            
            vowelsInEachWord.append(tempCount)
        }
        
        print("This is the number of vowels in each word: ", vowelsInEachWord)
        
        for i in 0...vowelsInEachWord.count - 1{
            totalVowelCount = vowelsInEachWord[i] + totalVowelCount
        }
        
        print("This is the total number of vowels: ", totalVowelCount)
        
        //number of words in text
        var numberOfWords = userSentence.count
        if userSentence.last == "" {
            numberOfWords = numberOfWords - 1
        }
        
        print("This is the number of words: ", numberOfWords)
        //if text is too long
        /*
         if numberOfWords > 2000{
         
         
         let alert = UIAlertController(title: "Error", message: "Text is too long", preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
         //self.present(alert, animated: true, completion: nil)
         
         return
         }
         */
        
        var inputInCharacters: [Character] = []
        
        //create song structure based on chosen letters
        for i in 0..<userSentence.count{
            
            let temp = userSentence[i]
            
            for mChar in temp{
                inputInCharacters.append(mChar)
            }
        }
        
        print(inputInCharacters)
        
        //combine input into one string
        var song = String(inputInCharacters)
        
        //count number of letters in song structure
        for mChar in inputInCharacters{
            if mChar != "," && mChar != "." && mChar != "?" && mChar != "!" && mChar != "’"{
                letterCount+=1
            }
        }
        
        var removeCount = letterCount - numberOfWords
        
        print("This is the song before removing letters: ", song)
        print("This is how many letters are being removed: ", removeCount)
        
        //make song structure equal to number of vowels
        while(removeCount != 0){
            
            if song.last! != "," && song.last! != "." && song.last! != "?" && song.last! != "!" && song.last! != "’"{
                song.removeLast()
                removeCount-=1
            }
            else{
                song.removeLast()
            }
            
        }
        
        print("This is the final song: ", song)
        var qwertySong = String()
        var backwardSong = String()
        var halfSong = String()
        
        for i in 0...song.count - 1{
            
            let mCharArray = Array(song)
            let mChar = mCharArray[i]
            
            if qwertyPiano[String(mChar)] != nil{
                qwertySong.append(qwertyPiano[String(mChar)]!)
            }
            else{}
            
            if backwardPiano[String(mChar)] != nil{
                if vowelsInEachWord[i] > 1{
                    backwardSong.append(backwardPiano[String(mChar)]!)
                }
                else{
                    backwardSong.append("_")
                }
            }
            else{}
            
            if halfPiano[String(mChar)] != nil{
                if vowelsInEachWord[i] > 2{
                    halfSong.append(halfPiano[String(mChar)]!)
                }
                else{
                    halfSong.append("_")
                }
            }
            else{}
        }
        
        print(qwertySong)
        print(backwardSong)
        print(halfSong)
        
        chords.append([UInt8(qwertySong.count), 3])
        
        for i in 0..<qwertySong.count{
            
            chords[i].append(alphabetPiano[qwertySong[i]]!)
            
            if backwardSong[i] != "_"{
                chords[i].append(alphabetPiano[backwardSong[i]]!)
            }
            if halfSong[i] != "_"{
                chords[i].append(alphabetPiano[halfSong[i]]!)
            }
        }
        
        print(chords)
        
    }
    
    //after user upload, generate song
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
       
        self.handleFileSelection(inUrl: urls.first!)
        
    }

    private func handleFileSelection(inUrl:URL) -> Void {
        
        var text = String()
        
        do {
         // inUrl is the document's URL
            let data = try Data(contentsOf: inUrl)
        } catch {
            print("document loading error")
        }
        
        //extract text from PDF
        if let pdf = PDFDocument(url: inUrl) {
            let pageCount = pdf.pageCount
            let documentContent = NSMutableAttributedString()

            for i in 0 ..< pageCount {
                guard let page = pdf.page(at: i) else { continue }
                guard let pageContent = page.attributedString else { continue }
                documentContent.append(pageContent)
            }
            
            text = documentContent.string //convert text to string
        }
        
        sentenceInArray = text.components(separatedBy: " ")
        generateSong(userSentence: sentenceInArray)
        print(text)
    }
    
    
}

class MidiPlayer {
    var midiPlayer: AVMIDIPlayer?
    var bankURL: URL
    var song: Song
    
    init(song: Song) {
        
        guard let bankURL = Bundle.main.url(forResource: "FluidR3_GM2-2", withExtension: "SF2") else {
            fatalError("\"Steinway Model L Grand Piano.sf2\" file not found.")
        }
        self.bankURL = bankURL
        self.song = song
    }
    
    func generateMIDIFile(song: Song){
                
        var documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
        let qwertyURL = documentDirectoryURL.appendingPathComponent("mySong.m4a")
        
        guard MusicSequenceFileCreate(song.musicSequence!, qwertyURL! as CFURL, MusicSequenceFileTypeID.midiType, MusicSequenceFileFlags.eraseFile, 0) == OSStatus(noErr) else{
            fatalError("Cannot create midi file")
        }
        
    }
    
    func prepareSong(song: Song){
        var data: Unmanaged<CFData>?
        guard MusicSequenceFileCreateData(song.musicSequence!, MusicSequenceFileTypeID.midiType, MusicSequenceFileFlags.eraseFile, 480, &data) == OSStatus(noErr) else {
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
    
    func playSong() async {
        if let md = self.midiPlayer {
            md.currentPosition = 0
            await md.play()
        }
    }
    
    func createMusicSequence(chords: [[UInt8]] )  {

        
        //var musicSequence: MusicSequence?
        var status = NewMusicSequence(&song.musicSequence)
        if status != noErr {
            print(" bad status \(status) creating sequence")
        }
        
        var tempoTrack: MusicTrack?
        if MusicSequenceGetTempoTrack(song.musicSequence!, &tempoTrack) != noErr {
            assert(tempoTrack != nil, "Cannot get tempo track")
        }

        //MusicTrackClear(tempoTrack, 0, 1)
        if MusicTrackNewExtendedTempoEvent(tempoTrack!, 0.0, 256.0) != noErr {
            print("could not set tempo")
        }
        if MusicTrackNewExtendedTempoEvent(tempoTrack!, 4.0, 256.0) != noErr {
            print("could not set tempo")
        }
        
        
        // add a track
        var track: MusicTrack?
        status = MusicSequenceNewTrack(song.musicSequence!, &track)
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
                
            }// beat changes after this
            beat += 1
        }
        
        CAShow(UnsafeMutablePointer<MusicSequence>(song.musicSequence!))
        
    }
    
    
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}



struct ContentView: View {
    
    struct OvalTextFieldStyle: TextFieldStyle {
        func _body(configuration: TextField<Self._Label>) -> some View {
            configuration
                .padding(10)
                .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(20)
                .shadow(color: .gray, radius: 10)
        }
    }
    
   
    let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.pdf], asCopy: true)
    @State var userText = ""
    @State var showAlert = false
    @State var enterButtonIsPresented = false
    @State var uploadButtonIsPresented = false
    @State private var importing = false
    @State private var isLoading = false
    @StateObject var song = Song()
    
    var body: some View {
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
                    HStack{
                        Spacer()
                        TextField("Enter a Sentence", text: $userText)
                            .padding()
                            .textFieldStyle(OvalTextFieldStyle())
                            .submitLabel(.done)
                        NavigationLink(destination: SongView(), isActive: $enterButtonIsPresented){
                            Image(systemName: "arrowshape.right.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .accentColor(.black)
                                .padding()
                                .onTapGesture {
                                    isLoading = true
                                        //song.sentence = userText
                                        song.sentenceInArray = userText.components(separatedBy: " ")
                                        //song.sentenceInArray.removeLast()
                                        
                                        if song.sentenceInArray.count > 2000{
                                            showAlert = true
                                        }
                                        else{
                                            song.generateSong(userSentence: song.sentenceInArray)
                                            song.generated = false
                                        }
                                        
                                        song.counter = 0
                                        song.vowelsInEachWord = []
                                        song.letterCount = 0
                                        song.totalVowelCount = 0
                                        
                                    
                                    
                                        self.enterButtonIsPresented = true
                                    
                                }
                        }
                        .disabled(userText.isEmpty)
                        
                    }.alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Text is Too Long"),
                            message: Text("Please enter a shorter text")
                        )
                    }
                    Spacer()
                    Text("or")
                        .font(.system(size: 50))
                        .frame(width: 100, height: 100)
                    Spacer()
                    Text("Upload File(PDF): ")
                    Spacer()
                    NavigationLink(destination: SongView(), isActive: $uploadButtonIsPresented){
                        Image(systemName: "doc.badge.arrow.up.fill")
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
                                
                                guard fileUrl.startAccessingSecurityScopedResource() else { return }
                                let contents = try  Data(contentsOf: fileUrl)
                                
                                //extract text from PDF
                                if let pdf = PDFDocument(url: fileUrl) {
                                    let pageCount = pdf.pageCount
                                    let documentContent = NSMutableAttributedString()
                                    
                                    for i in 0 ..< pageCount {
                                        guard let page = pdf.page(at: i) else { continue }
                                        guard let pageContent = page.attributedString else { continue }
                                        documentContent.append(pageContent)
                                    }
                                    
                                    song.sentence = documentContent.string //convert text to string
                                    
                                    song.sentenceInArray = song.sentence.components(separatedBy: " ")
                                    if song.sentenceInArray.count > 2000{
                                        showAlert = true
                                    }
                                    else{
                                        song.generateSong(userSentence: song.sentenceInArray)
                                    }
                                    
                                    song.counter = 0
                                    song.vowelsInEachWord = []
                                    song.letterCount = 0
                                    song.totalVowelCount = 0
                                    
                                    uploadButtonIsPresented = true
                                    
                                }
                            }
                            catch {
                                print("document loading error")
                            }
                        
                    }
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
        .navigationViewStyle(.stack)
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




#Preview {
    ContentView()
}
