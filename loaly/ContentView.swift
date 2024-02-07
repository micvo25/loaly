//
//  ContentView.swift
//  loaly
//
//  Created by Salvatore D'Armetta on 1/23/24.
//

import SwiftUI
import AVFoundation
import PDFKit

extension AVMutableCompositionTrack {
    func appendToSong(url: URL) {
        let newAsset = AVURLAsset(url: url)
        let range = CMTimeRangeMake(start: CMTime.zero, duration: newAsset.duration)
        let end = timeRange.end
        if let track = newAsset.tracks(withMediaType: AVMediaType.audio).first {
            try! insertTimeRange(range, of: track, at: end)
        }  else{
            print("ERROR - Appending")
        }
        }
}

class PianoKeys{
    
    let AKey = Bundle.main.url(forResource: "A-Updated", withExtension: "mov")
    let BKey = Bundle.main.url(forResource: "B-Updated", withExtension: "mov")
    let CKey = Bundle.main.url(forResource: "C-Updated", withExtension: "mov")
    let DKey = Bundle.main.url(forResource: "D-Updated", withExtension: "mov")
    let EKey = Bundle.main.url(forResource: "E-Updated", withExtension: "mov")
    let FKey = Bundle.main.url(forResource: "F-Updated", withExtension: "mov")
    let GKey = Bundle.main.url(forResource: "G-Updated", withExtension: "mov")
    let HKey = Bundle.main.url(forResource: "H-Updated", withExtension: "mov")
    let IKey = Bundle.main.url(forResource: "I-Updated", withExtension: "mov")
    let JKey = Bundle.main.url(forResource: "J-Updated", withExtension: "mov")
    let KKey = Bundle.main.url(forResource: "K-Updated", withExtension: "mov")
    let LKey = Bundle.main.url(forResource: "L-Updated", withExtension: "mov")
    let MKey = Bundle.main.url(forResource: "M-Updated", withExtension: "mov")
    let NKey = Bundle.main.url(forResource: "N-Updated", withExtension: "mov")
    let OKey = Bundle.main.url(forResource: "O-Updated", withExtension: "mov")
    let PKey = Bundle.main.url(forResource: "P-Updated", withExtension: "mov")
    let QKey = Bundle.main.url(forResource: "Q-Updated", withExtension: "mov")
    let RKey = Bundle.main.url(forResource: "R-Updated", withExtension: "mov")
    let SKey = Bundle.main.url(forResource: "S-Updated", withExtension: "mov")
    let TKey = Bundle.main.url(forResource: "T-Updated", withExtension: "mov")
    let UKey = Bundle.main.url(forResource: "U-Updated", withExtension: "mov")
    let VKey = Bundle.main.url(forResource: "V-Updated", withExtension: "mov")
    let WKey = Bundle.main.url(forResource: "W-Updated", withExtension: "mov")
    let XKey = Bundle.main.url(forResource: "X-Updated", withExtension: "mov")
    let YKey = Bundle.main.url(forResource: "Y-Updated", withExtension: "mov")
    let ZKey = Bundle.main.url(forResource: "Z-Updated", withExtension: "mov")
    let quarterPause = Bundle.main.url(forResource: "LOA(QUARTERPAUSE)", withExtension: "mov")
    let eightPause = Bundle.main.url(forResource: "LOA(EIGHTPAUSE)", withExtension: "mov")

}

class Piano: PianoKeys {
    
    var alphabetPiano: [String: URL?] = [:]
    let qwertyPiano = ["A":"Q","a": "q","B":"W","b":"w","C":"E","c":"e","D":"R","d":"r","E":"T","e":"t","F":"Y","f":"y","G":"U","g":"u","H":"I","h":"i","I":"O","i":"o","J":"P","j":"p","K":"A","k":"a","L":"S","l":"s","M":"D","m":"d","N":"F","n":"f","O":"G","o":"g","P":"H","p":"h","Q":"J","q":"j","R":"K","r":"k","S":"L","s":"l","T":"Z","t":"z","U":"X","u":"x","V":"C","v":"c","W":"V","w":"v","X":"B","x":"b","Y":"N","y":"n","Z":"M","z":"m", ",":",", ".":".","!":"!","?":"?", "_":"_"]
    let backwardPiano = ["A":"Z","a":"z","B":"Y","b":"y","C":"X","c":"x","D":"W","d":"w","E":"V","e":"v","F":"U","f":"u","G":"T","g":"t","H":"S","h":"s","I":"R","i":"r","J":"Q","j":"q","K":"P","k":"p","L":"O","l":"o","M":"N","m":"n","N":"M","n":"m","O":"L","o":"l","P":"K","p":"k","Q":"J","q":"j","R":"I","r":"i","S":"H","s":"h","T":"G","t":"g","U":"F","u":"f","V":"E","v":"e","W":"D","w":"d","X":"C","x":"c","Y":"B","y":"b","Z":"A","z":"a",",":",",".":".","!":"!","?":"?"," ":" ","_":"_"]
    let halfPiano = ["A":"N","a":"n","B":"O","b":"o","C":"P","c":"p","D":"Q","d":"q","E":"R","e":"r","F":"S","f":"s","G":"T","g":"t","H":"U","h":"u","I":"V","i":"v","J":"W","j":"w","K":"X","k":"x","L":"Y","l":"y","M":"Z","m":"z","N":"A","n":"a","O":"B","o":"b","P":"C","p":"c","Q":"D","q":"d","R":"E","r":"e","S":"F","s":"f","T":"G","t":"g","U":"H","u":"h","V":"I","v":"i","W":"J","w":"j","X":"K","x":"k","Y":"L","y":"l","Z":"M","z":"m",",":",",".":".","!":"!","?":"?"," ":" ","_":"_"]
    
    override init(){
        
        super.init()
        self.alphabetPiano = ["A":AKey,"a":AKey,"B":BKey,"b":BKey,"C":CKey,"c":CKey,"D":DKey,"d":DKey,"E":EKey,"e":EKey,"F":FKey,"f":FKey,"G":GKey,"g":GKey,"H":HKey,"h":HKey,"I":IKey,"i":IKey,"J":JKey,"j":JKey,"K":KKey,"k":KKey,"L":LKey,"l":LKey,"M":MKey,"m":MKey,"N":NKey,"n":NKey,"O":OKey,"o":OKey,"P":PKey,"p":PKey,"Q":QKey,"q":QKey,"R":RKey,"r":RKey,"S":SKey,"s":SKey,"T":TKey,"t":TKey,"U":UKey,"u":UKey,"V":VKey,"v":VKey,"W":WKey,"w":WKey,"X":XKey,"x":XKey,"Y":YKey,"y":YKey,"Z":ZKey,"z":ZKey,",":eightPause,".":eightPause,"!":quarterPause,"?":quarterPause, "_":eightPause]
        
    }
    
}

class Song: Piano{
    
    var sentence = ""
    var sentenceInArray: [String] = []
    var songArray: [URL?] = []
    var counter: Int = 0
    var vowelArrayCount: [Int] = []
    var vowelCount = 0
    var letterCount = 0
    var generated = false

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
                vowelArrayCount.append(0)
            }
            if temp.contains(","){
                vowelArrayCount.append(0)
            }
            if temp.contains("?"){
                vowelArrayCount.append(0)
            }
            if temp.contains("!"){
                vowelArrayCount.append(0)
            }
            
            vowelArrayCount.append(tempCount)
        }
        
        print("This is the number of vowels in each: ", vowelArrayCount)
        
        for i in 0...vowelArrayCount.count - 1{
            vowelCount = vowelArrayCount[i] + vowelCount
        }
        
        print("This is the number of vowels: ", vowelCount)
        
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
        
        var finalArray: [Character] = []
        
        //create song structure based on chosen letters
        for i in 0..<userSentence.count{
            
            let temp = userSentence[i]
            
            for mChar in temp{
                finalArray.append(mChar)
            }
        }
        
        print(finalArray)
        var song = String(finalArray)
        
        //count number of letters in song structure
        for mChar in finalArray{
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
                if vowelArrayCount[i] > 1{
                    backwardSong.append(backwardPiano[String(mChar)]!)
                }
                else{
                    backwardSong.append("_")
                }
            }
            else{}
            
            if halfPiano[String(mChar)] != nil{
                if vowelArrayCount[i] > 2{
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
        
        //create compositions
        let qwertyComposition = AVMutableComposition()
        let qwertyCompositionAudioTrack = qwertyComposition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid)
        let backwardComposition = AVMutableComposition()
        let backwardCompositionAudioTrack = backwardComposition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid)
        let halfComposition = AVMutableComposition()
        let halfCompositionAudioTrack = halfComposition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid)

        for mChar in qwertySong{
            
            let letter = String(mChar)
            
            if alphabetPiano[letter] != nil {
                qwertyCompositionAudioTrack!.appendToSong(url: alphabetPiano[letter]!! )
            }
            else{
                qwertyCompositionAudioTrack!.appendToSong(url: alphabetPiano["_"]!! )
            }
        }
        
        for mChar in backwardSong{
            
            let letter = String(mChar)
            
            if alphabetPiano[letter] != nil {
                backwardCompositionAudioTrack!.appendToSong(url: alphabetPiano[letter]!! )
            }
            else{
                backwardCompositionAudioTrack!.appendToSong(url: alphabetPiano["_"]!! )
            }
            
        }
        
        for mChar in halfSong{
            
            let letter = String(mChar)
            
            if alphabetPiano[letter] != nil {
                halfCompositionAudioTrack!.appendToSong(url: alphabetPiano[letter]!! )
            }
            else{
                halfCompositionAudioTrack!.appendToSong(url: alphabetPiano["_"]!! )
            }
            
        }
        
        //export qwerty song
        var documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
        let qwertyURL = documentDirectoryURL.appendingPathComponent("LOAComposition.m4a")
        exportURL(destinationURL: qwertyURL!, composition: qwertyComposition)
        
        
        //export backward song (UNCOMMENT THIS)
        documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
        let backwardURL = documentDirectoryURL.appendingPathComponent("backwardComposition.m4a")
        exportURL(destinationURL: backwardURL!, composition: backwardComposition)
        
         
       
        //export half song
        documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
        let halfURL = documentDirectoryURL.appendingPathComponent("halfComposition.m4a")
        exportURL(destinationURL: halfURL!, composition: halfComposition)
         
        
        
        //let audioFileUrls = [qwertyURL, backwardURL, halfURL]
        //await mergeAudioFiles(audioFileUrls: audioFileUrls)
        generated = true
    }
    
    
    //export function
    func exportURL(destinationURL: URL, composition: AVMutableComposition) {
                
        do { // delete old video
            try FileManager.default.removeItem(at: destinationURL)
            } catch { print(error.localizedDescription) }
        
        //exporting to file
        if let assetExport = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetAppleM4A) {
            //assetExport.audioMix = audioMix
          assetExport.outputFileType = AVFileType.m4a
            assetExport.outputURL = destinationURL
            
            assetExport.exportAsynchronously( completionHandler:    {
                
                switch assetExport.status {
                    
                case AVAssetExportSession.Status.failed:
                    print("failed \(assetExport.error)")
                case AVAssetExportSession.Status.cancelled:
                    print("cancelled \(assetExport.error)")
                case AVAssetExportSession.Status.unknown:
                    print("unknown\(assetExport.error)")
                case AVAssetExportSession.Status.waiting:
                    print("waiting\(assetExport.error)")
                case AVAssetExportSession.Status.exporting:
                    print("exporting\(assetExport.error)")
                    
                default:
                    print("COMPLETED YAY!!!")
                    print(destinationURL)
                }
                
            })
        }//asset export end
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

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

class AudioPlayerViewModel: ObservableObject{
    
    let sound: URL
    var audioPlayer: AVAudioPlayer?
    @Published var isPlaying = false

    init() {
      sound = Bundle.main.url(forResource: "LOA(EIGHTPAUSE)", withExtension: ".mov")!
      do {
        audioPlayer = try AVAudioPlayer(contentsOf: sound)
      } catch {
          print(error.localizedDescription)
      }
   
      do {
          try AVAudioSession.sharedInstance().setCategory(.playback)
      } catch let error {
          print(error.localizedDescription)
      }
      
  }

func documentDirectory() -> URL {
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    return documentsDirectory
}
    
  func playOrPause() {
    guard let player = audioPlayer else { return }

      if player.isPlaying {
      player.pause()
      isPlaying = false
    } else {
      player.play()
      isPlaying = true
    }
      
      do {
          try AVAudioSession.sharedInstance().setCategory(.playback)
      } catch let error {
          print(error.localizedDescription)
      }
  }
    
    func loadNewFile(){
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let composition = documentsDirectory.appendingPathComponent("LOAComposition.m4a")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: composition)
        }
        catch{
            print(error.localizedDescription)
        }
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
    
    @StateObject var audioPlayerViewModel = AudioPlayerViewModel()
    @State var song = Song()
    let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.pdf], asCopy: true)
    @State var userText = ""
    @State var showAlert = false
    @State var enterButtonIsPresented = false
    @State var uploadButtonIsPresented = false
    @State private var importing = false
    @State private var isLoading = false
    
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
                                        song.vowelArrayCount = []
                                        song.letterCount = 0
                                        song.vowelCount = 0
                                        
                                    
                                    
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
                                    song.vowelArrayCount = []
                                    song.letterCount = 0
                                    song.vowelCount = 0
                                    
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
                audioPlayerViewModel.loadNewFile()
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
            
        }
        .environmentObject(audioPlayerViewModel)
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
