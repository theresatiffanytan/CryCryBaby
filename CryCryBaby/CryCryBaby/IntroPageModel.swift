//
//  IntroPageModel.swift
//  CryCryBaby
//
//  Created by Theresa Tiffany on 25/05/23.
//

import Foundation

struct Page: Identifiable, Equatable {
    let id = UUID()
//    var name: String
//    var description: String
    var imageUrl: String
    var tag: Int
    
    static var samplePage = Page(imageUrl: "IntroPage1", tag: 0)

    static var samplePages: [Page] = [
        Page(imageUrl: "IntroPage1", tag: 0),
        Page(imageUrl: "IntroPage2", tag: 1)
    ]
}
