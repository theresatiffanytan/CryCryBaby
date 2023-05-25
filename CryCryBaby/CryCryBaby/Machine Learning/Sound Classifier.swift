//
//  Sound Classifier.swift
//  CryCryBaby
//
//  Created by Theresa Tiffany on 23/05/23.
//

import AVFoundation
import CoreML

class SoundClassifier: ObservableObject {
    private let model: BabiesCrying
    var audioURL = ""
    @Published var result : String? = ""
    
    init() {
        guard let mlModel = try? BabiesCrying(configuration: MLModelConfiguration()) else {
            fatalError("Failed to load the model.")
        }
        model = mlModel
    }
    
    func performSoundClassification() {
        
        // Load the Core ML model
        guard let model = try? BabiesCrying(configuration: MLModelConfiguration()) else {
            fatalError("Failed to load the model.")
        }
        
        // Prepare your sound data for classification
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioURL = documentDirectory.appendingPathComponent("babiesCrying.m4a")
        
        // Create an AVAudioFile from the audio URL
        guard let audioFile = try? AVAudioFile(forReading: audioURL) else {
            fatalError("Failed to create AVAudioFile.")
        }
        
        // Get the audio format information
        let audioFormat = audioFile.processingFormat
//        let sampleRate = audioFormat.sampleRate
        let frameCount = AVAudioFrameCount(audioFile.length)
        
        // Create an AVAudioPCMBuffer to hold the audio data
        guard let audioBuffer = AVAudioPCMBuffer(pcmFormat: audioFormat, frameCapacity: frameCount) else {
            fatalError("Failed to create AVAudioPCMBuffer.")
        }
        
        do {
            try audioFile.read(into: audioBuffer)
        } catch {
            fatalError("Failed to read audio file into buffer.")
        }
        
        // Extract the float channel data
        guard let floatChannelData = audioBuffer.floatChannelData else {
            fatalError("Failed to get float channel data from audio buffer.")
        }
        
        // Convert the float channel data into an MLMultiArray
        let channelCount = Int(audioFormat.channelCount)
        let inputSize = Int(frameCount)
        let inputArray = try! MLMultiArray(shape: [1, NSNumber(value: channelCount), NSNumber(value: inputSize)], dataType: .float32)
        
        for channel in 0..<channelCount {
            let channelData = floatChannelData[channel]
            let channelDataArray = stride(from: 0, to: inputSize, by: 1).map { channelData[$0] }
            for (index, element) in channelDataArray.enumerated() {
                inputArray[[0, NSNumber(value: channel), NSNumber(value: index)]] = NSNumber(value: element)
            }
        }
        
        // Create the input for the sound classification model
        let input = BabiesCryingInput(audioSamples: inputArray)
        
        // Make predictions with the model
        if let prediction = try? model.prediction(input: input) {
            // Access the predicted class or probabilities
            let predictedClass = prediction.classLabel
            let probabilities = prediction.classLabelProbs
            
            self.result = predictedClass
//            print("result: \(result)")
            // Process the prediction results as needed
            print("Predicted class: \(predictedClass)")
            print("Probabilities: \(probabilities)")
        } else {
            fatalError("Failed to make a prediction.")
        }
    }
}
