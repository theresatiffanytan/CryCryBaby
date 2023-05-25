//
//  Recordings.swift
//  CryCryBaby
//
//  Created by Theresa Tiffany on 22/05/23.
//

import SwiftUI

struct Recordings: View {
    
    @ObservedObject var audioRecorder: AudioRecorder
    
    var body: some View {
//        List {
            ForEach(audioRecorder.recordings, id: \.createdAt) { recording in
                RecordingRow(audioURL: recording.fileURL)
//            }
//        .onDelete(perform: delete)
        }
    }
    
//    func delete(at offsets: IndexSet) {
//        var urlsToDelete = [URL]()
//        for index in offsets {
//            urlsToDelete.append(audioRecorder.recordings[index].fileURL)
//        }
//        audioRecorder.deleteRecording(urlsToDelete: urlsToDelete)
//    }
}

struct RecordingRow: View {
    
    var audioURL: URL
    
    @ObservedObject var audioPlayer = AudioPlayer()
    
    
    var body: some View {
        HStack {
            Text("\(audioURL.lastPathComponent)")
                .foregroundColor(.white)
//            Spacer()
            if audioPlayer.isPlaying == false {
                Button(action: {
                    self.audioPlayer.startPlayback(audio: self.audioURL)
                }) {
                    Image(systemName: "play.circle")
                        .imageScale(.large)
                }
            } else {
                Button(action: {
                    self.audioPlayer.stopPlayback()
                }) {
                    Image(systemName: "stop.fill")
                        .imageScale(.large)
                }
            }
        }
    }
}

struct Recordings_Previews: PreviewProvider {
    static var previews: some View {
        Recordings(audioRecorder: AudioRecorder())
    }
}

