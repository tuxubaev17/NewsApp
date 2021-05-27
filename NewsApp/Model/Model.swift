//
//  Model.swift
//  NewsApp
//
//  Created by Alikhan Tuxubayev on 26.05.2021.
//

import Foundation

var articles: [Article] {
    let data = try? Data(contentsOf: urlToData)
    if data == nil { return [] }
    
    let dictionaryAny = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Dictionary<String, Any>
    if dictionaryAny == nil { return []}
    
    let dictionary = dictionaryAny as? Dictionary<String, Any>
    if dictionary == nil { return [] }
    
    if let arr = dictionary!["articles"] as? [Dictionary<String, Any>]{
        var returnArray: [Article] = []
        
        for item in arr {
            let newArticle = Article(dictionary: item)
            returnArray.append(newArticle)
        }
        
        return returnArray
    }
    return []
}
var urlToData: URL {
    let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0] + "/data.json"
    let urlPath = URL(fileURLWithPath: path)
    return urlPath
}


func newsLoad(completionHandler: (()->Void)?) {
    let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=f24593c0a2d44cb3bf329255abf74903")!
    
    let session = URLSession(configuration: .default)
    let task = session.downloadTask(with: url) { (dataUrlFile , response, error) in
        if dataUrlFile != nil {
            try? FileManager.default.copyItem(at: dataUrlFile!, to: urlToData)
            completionHandler?()
        }
    }
    task.resume()
}

