//
//  Articles.swift
//  NewsApp
//
//  Created by Alikhan Tuxubayev on 26.05.2021.
//

import Foundation


struct Article {
    var sourse: String
    let author, title, articleDescription: String
    let url: String
    let urlToImage: String
    let publishedAt: String

    init(dictionary: Dictionary<String, Any>){
        sourse = (dictionary["source"] as? Dictionary<String, Any> ?? ["":""])["name"] as? String ?? ""
        author = dictionary["author"] as? String ?? ""
        title = dictionary["title"] as? String ?? ""
        articleDescription = dictionary["description"] as? String ?? ""
        url = dictionary["url"] as? String ?? ""
        urlToImage = dictionary["urlToImage"] as? String ?? ""
        publishedAt = dictionary["publishedAt"] as? String ?? ""
    }
}
