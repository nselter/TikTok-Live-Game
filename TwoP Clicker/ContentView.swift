//
//  ContentView.swift
//  TwoP Clicker
//
//  Created by Noah Selter  on 3/20/23.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    let n = 19.0
    @State var LGBTNum = 1.0
    @State var StraightNum = 1.0
    @State var sound: AVAudioPlayer!
    @State var LGBTwin = false
    @State var StrightWin = false
    @State var showSparks = false // new state variable for sparks
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("StrightFlag")
                    .resizable()
                    .frame(width: geo.size.width, height: geo.size.height)
                
                HStack(spacing: 0.0) {
                    Image("LGBTFlag")
                        .resizable()
                        .frame(width: (LGBTNum * geo.size.width/(2*n)), height: geo.size.height)
                        .onTapGesture {
                            addGirl()
                            showSparks = true // show sparks on tap
                        }
                    
                    Image("StraightFlag")
                        .resizable()
                        .frame(width: (StraightNum * geo.size.width/(2*n)), height: geo.size.height)
                        .onTapGesture {
                            
                            addBoy()
                            showSparks = true // show sparks on tap
                        }
                }
                .frame(width: geo.size.width)
                
                if LGBTwin {
                    Image("LGBTWin")
                        .resizable()
                        .onAppear(perform: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                LGBTwin = false
                            }
                        })
                }
                
                if StrightWin {
                    Image("StraightWin")
                        .resizable()
                        .onAppear(perform: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                StrightWin = false
                            }
                        })
                }
                
//                if showSparks {
//                    Image("Sparky1")
//                        .resizable()
//                        .onAppear(perform: {
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05
//                            ) {
//                                showSparks = false
//                            }
//                        })
//
//                }
                
            }
        }
        .ignoresSafeArea()
    }
    
    func addGirl() {
        LGBTNum += 1
        StraightNum -= 1
        playSound(soundName: "LGBTAudio")
        checkWin()
    }
    
    func addBoy() {
        StraightNum += 1
        LGBTNum -= 1
        playSound(soundName: "StraightAudio")
        checkWin()
    }
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        try! AVAudioSession.sharedInstance().setCategory(
            AVAudioSession.Category.playback,
            options: AVAudioSession.CategoryOptions.mixWithOthers
        )
        
        sound = try! AVAudioPlayer(contentsOf: url!)
        sound!.play()
    }
    
    func checkWin() {
        if LGBTNum<=0 || StraightNum<=0 {
            if LGBTNum<=0 {
                StrightWin = true
            } else {
                LGBTwin = true
            }
            playSound(soundName: "bonesss")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                LGBTNum = n
                StraightNum = n
            }
        }
    }
}


                    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
