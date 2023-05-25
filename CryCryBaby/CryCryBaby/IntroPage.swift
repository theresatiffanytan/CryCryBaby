//
//  IntroPage.swift
//  CryCryBaby
//
//  Created by Theresa Tiffany on 25/05/23.
//

import SwiftUI
import AVFoundation

extension UserDefaults {
    
    var welcomeScreenShown: Bool {
        get {
            return (UserDefaults.standard.value(forKey: "welcomeScreenShown") as? Bool) ?? false
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "welcomeScreenShown")
        }
    }
    
}

struct IntroPage: View {
    @State var movePage: Bool = false
    
    var body: some View {
        if UserDefaults.standard.welcomeScreenShown {
                ContentView(audioRecorder: AudioRecorder(), classifier: SoundClassifier())
        } else {
            if self.movePage{
                ContentView(audioRecorder: AudioRecorder(), classifier: SoundClassifier())
            }
            else{
                IntroScreen(isOn: $movePage)
            }
        }
    }
}

struct IntroScreen: View{
    
    var welcomeScreenShown: Bool = false
    @State private var pageIndex = 0
    private let pages: [Page] = Page.samplePages
    private let dotAppearance = UIPageControl.appearance()
    @Binding var isOn: Bool
    
    var body: some View{
            TabView(selection: $pageIndex) {
                ForEach(pages) { page in
                    ZStack {
//                        Spacer()
                        IntroLayout(page: page)
//                        Spacer()
                        if page == pages.last {
                            Button {
                                navigation()
                            } label: {
                                Text("Done").font(.system(size: 25))
                                    .foregroundColor(.white)
                                    .frame(width: 150, height: 40)
                                    .background(Color.secondary)
                                    .cornerRadius(20)
                                    .offset(y: -10)
                                    
                            }

                        } else {
                            Button {
                                incrementPage()
                            } label: {
                                Text("Next").font(.system(size: 25))
                                    .foregroundColor(.white)
                                    .frame(width: 150, height: 40)
                                    .background(Color.secondary)
                                    .cornerRadius(20)
                                    .offset(y: -60)
                            }

                        }
//                        Spacer()
                    }
                    .edgesIgnoringSafeArea(.all)
//                    .padding(.all,75)
                    .tag(page.tag)
                }
            }
            .edgesIgnoringSafeArea(.all)
            .animation(.easeInOut, value: pageIndex)
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            .tabViewStyle(PageTabViewStyle())
            .onAppear {
                dotAppearance.currentPageIndicatorTintColor = .black
                dotAppearance.pageIndicatorTintColor = .gray
                // Untuk aktifkan user default (hanya muncul saat pertama kali buka app)
//                UserDefaults.standard.welcomeScreenShown = true
            }
    }
    
    func incrementPage() {
        pageIndex += 1
    }
    func navigation() {
        self.isOn.toggle()
    }
    
}
