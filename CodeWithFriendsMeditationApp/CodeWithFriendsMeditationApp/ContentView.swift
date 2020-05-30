//
//  ContentView.swift
//  CodeWithFriendsMeditationApp
//
//  Created by Jacob Pernell on 5/10/20.
//  Copyright © 2020 Jacob Pernell. All rights reserved.
//

/*
Jacob notes: I FEEL LIKE I'M SO CLOSE to getting this to work the way I want to. Unfortunately I didn't quite get the toggle switch functionality to work/play audio the way I wanted, but I'll keep working at it. :) In the future, I think I will try to redo this using normal Swift. ^^' Was a fun learning experience though, and am glad I dove in to try to poke at Swift! :)
 */

import SwiftUI
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("error finding/playing audio file")
        }
    }
}

struct ContentView: View {
    
    var body: some View {
        ZStack {
            VStack {
                Text("Meditation App")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                Text("Code With Friends! :D")
                Text("Jacob Pernell - Spring 2020")
                Divider()
                List {
                    AudioLayer(layerName: "Music Layer 1", audioFile: "layer1", audioType: "mp3", toggleBool: true, volume: 100)
                    AudioLayer(layerName: "Music Layer 2", audioFile: "layer2", audioType: "mp3", toggleBool: true, volume: 50)
                    AudioLayer(layerName: "Music Layer 33323432", audioFile: "layer3", audioType: "mp3", toggleBool: false, volume: 100)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AudioLayer: View {
    
    let layerName: String
    let audioFile: String
    let audioType: String
    @State var toggleBool: Bool
    @State var volume: Double
    
    var body: some View {
        
        VStack {
            HStack {
                
                Toggle(layerName, isOn: self.$toggleBool) {
                    if (self.toggleBool) {
                        Text("\(self.playSound(sound: audioFile, type: audioType))")
//                        print("\(layerName) enabled")
                    } else {
//                        print("\(layerName) disabled")
                        // volume = 0, don't play
                    }
                }
                
                Slider(value: $volume, in: 0...100, step: 1.0)
                    .disabled(toggleBool ? false : true)
                Text("\(Int(volume))")
                    .foregroundColor(toggleBool ? Color.black : Color.gray)
                    .frame(width: 55)
            
            }
            .padding(15)
        }
        .padding(10)
    }
}
