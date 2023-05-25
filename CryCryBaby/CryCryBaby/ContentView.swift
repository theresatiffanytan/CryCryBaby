
import SwiftUI
import AVFoundation
import CoreML


struct ContentView: View {
    
    @ObservedObject var audioRecorder: AudioRecorder
    @ObservedObject var classifier : SoundClassifier
    @State private var isVisualizing = false
    @State private var soundwave = false
    @State var currentPrediction: String? = ""
    
    var body: some View {
        //        NavigationView {
        GeometryReader { geometry in
            ZStack {
                Image("CryBabyBG")
                    .scaledToFit()
                
                //                                Recordings(audioRecorder: AudioRecorder())
                
                Text("\(classifier.result ?? "")")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 40))
                    .animation(.easeOut(duration: 2))
                    .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.1)
                    .position(x: geometry.size.width / 2 ,y: geometry.size.height * 0.575)
                
                
                VStack {
                    switch currentPrediction {
                    case "Discomfort":
                        Text("Your Baby is...")
                            .foregroundColor(.white)
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.1)
                            .position(x: geometry.size.width * 0.38 ,y: geometry.size.height * 0.7)
                        Image("Discomfort")
                            .resizable()
                            .frame(width: 450, height: 450)
                            .position(x: geometry.size.width * 0.465 ,y: geometry.size.height * 0.6)
                        Text("Your baby might need your attention.")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.1)
                            .position(x: geometry.size.width/2 ,y: geometry.size.height * 0.47)
                        
                    case "Hungry":
                        Text("Your Baby is...")
                            .foregroundColor(.white)
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.1)
                            .position(x: geometry.size.width * 0.38 ,y: geometry.size.height * 0.7)
                        Image("Hungry")
                            .resizable()
                            .frame(width: 450, height: 450)
                            .position(x: geometry.size.width * 0.465 ,y: geometry.size.height * 0.6)
                        Text("Oh no, your baby is craving for some milk.")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.1)
                            .position(x: geometry.size.width/2 ,y: geometry.size.height * 0.47)
                        
                    case "Sleepy":
                        Text("Your Baby is...")
                            .foregroundColor(.white)
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.1)
                            .position(x: geometry.size.width * 0.38 ,y: geometry.size.height * 0.7)
                        Image("Sleepy")
                            .resizable()
                            .frame(width: 450, height: 450)
                            .position(x: geometry.size.width * 0.465 ,y: geometry.size.height * 0.6)
                        Text("Your baby is trying to sleep, give your baby a kiss.")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.1)
                            .position(x: geometry.size.width/2 ,y: geometry.size.height * 0.47)
                        
                    case "Lower Gas":
                        Text("Your Baby is...")
                            .foregroundColor(.white)
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.1)
                            .position(x: geometry.size.width * 0.38 ,y: geometry.size.height * 0.7)
                        Image("Lower Gas")
                            .resizable()
                            .frame(width: 450, height: 450)
                            .position(x: geometry.size.width * 0.465 ,y: geometry.size.height * 0.6)
                        Text("Oops, your baby will fart in a moment. Brace yourself.")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.1)
                            .position(x: geometry.size.width/2 ,y: geometry.size.height * 0.47)
                        
                    default:
                        Text("Cry Cry Baby")
                            .foregroundColor(.white)
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.1)
                            .position(x: geometry.size.width * 0.38 ,y: geometry.size.height * 0.7)
                        Image("")
                            .resizable()
                            .frame(width: 450, height: 450)
                            .position(x: geometry.size.width * 0.465 ,y: geometry.size.height * 0.6)
                        Text("Record your Baby's voice")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.1)
                            .position(x: geometry.size.width/2 ,y: geometry.size.height * 0.47)
                        
                    }
                    
                }.position(x: geometry.size.width/2)
                
                
                VStack{
                    Text("Shhh, remember! ")
                        .foregroundColor(.white)
                        .italic()
                        .bold()
                        .font(.system(size: 20))
                        .position(x: geometry.size.width * 0.27 , y: geometry.size.height * 0.80)
                    Text("It is important to keep your device close to  ")
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                        .position(x: geometry.size.width * 0.50 , y: geometry.size.height * 0.465)
                    Text("your baby while recording")
                        .foregroundColor(.white)
                        .position(x: geometry.size.width * 0.31 , y: geometry.size.height * 0.115)
                    
                }
                
                HStack (spacing: 3) {
                    if soundwave {
                        ForEach(0 ..< 6) { item in
                            RoundedRectangle(cornerRadius: 2)
                                .frame(width: 3, height: .random(in: isVisualizing ? 4...16 : 4...20))
                                .foregroundColor(.white)
                        }
                        .animation(.easeInOut(duration: 0.25).repeatForever(autoreverses: true), value: isVisualizing)
                        .onAppear{
                            isVisualizing.toggle()
                        }
                    }
                    
                }.position(x: geometry.size.width / 2 , y: geometry.size.height * 0.92)
                
                
                Button{
                    if audioRecorder.recording == false {
                        self.audioRecorder.startRecording()
                        self.soundwave = true
                    }else{
                        self.audioRecorder.stopRecording()
                        self.soundwave = false
                        classifier.performSoundClassification()
                        self.currentPrediction = classifier.result
                    }
                }label: {
                    
                    if audioRecorder.recording == false{
                        ZStack{
                            Image(systemName: "circle.fill")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 70, height: 70)
                            
                            Circle()
                                .stroke(lineWidth: 2)
                            
                                .foregroundColor(.white)
                                .frame(width: 80, height: 80)
                            
                        }
                    }else {
                        ZStack{
                            Image(systemName: "stop.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.red)
                                .frame(width: 45)
                            
                            Circle()
                                .stroke(lineWidth: 2)
                                .foregroundColor(.white)
                                .frame(width: 80, height: 80)
                            
                        }
                    }
                }.position(x: geometry.size.width/2, y: geometry.size.height * 1.02)
                
                
                //            .navigationBarItems(trailing: EditButton())
                //            }.ignoresSafeArea()
                //            .navigationBarTitle("Cry Cry Baby")
                
                
            }.ignoresSafeArea()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(audioRecorder: AudioRecorder(), classifier: SoundClassifier())
    }
}


