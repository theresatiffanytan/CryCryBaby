//
//  IntroView.swift
//  CryCryBaby
//
//  Created by Theresa Tiffany on 25/05/23.
//

import SwiftUI

struct IntroLayout: View {
    var page: Page
    
    var body: some View {
       
            Image("\(page.imageUrl)")
//                .position(CGPoint(x: 196.5, y: 367))
                .resizable()
//                .scaledToFit()
                .edgesIgnoringSafeArea(.all)
//                .padding()
//                .cornerRadius(30)
//                .position(x: 200,y: 600)
//
//            Text(page.name)
//                .font(.system(size: 55))
//                .position(x: 200, y: -150)
//
//            Text(page.description)
//                .font(.system(size: 30))
//                .position(x: 200, y: -300)
//            Spacer().frame().frame(height: 50)
        
    }
}

struct IntroLayout_Previews: PreviewProvider {
    static var previews: some View {
        IntroLayout(page: Page.samplePage)
    }
}
