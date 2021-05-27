//
//  DetailNewsController.swift
//  NewsApp
//
//  Created by Alikhan Tuxubayev on 26.05.2021.
//

import UIKit
import SafariServices

class DetailNewsController: UIViewController, SFSafariViewControllerDelegate {
    
    var article: Article!
    var index: Int = 0
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var pubData: UILabel!
    
    @IBAction func pushActionButton(_ sender: Any) {
        if let url = URL(string: article.url) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let svc = SFSafariViewController(url: url, configuration: config )
            svc.delegate = self
            present(svc, animated: true, completion: nil)
        }
    }
    
    @IBAction func share(_ sender: Any) {
        if let url = URL(string: article.url) {
            let title = "Share"
            let avc = UIActivityViewController(activityItems: [title, url], applicationActivities: nil)
            avc.popoverPresentationController?.sourceView = self.view
            present(avc, animated: true, completion: nil)
        }
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        authorLabel.text = article.author
        pubData.text = article.publishedAt
        
        DispatchQueue.main.async {
            if let url = URL(string: self.article.urlToImage){
                if let data = try? Data(contentsOf: url){
                    self.imageView.image = UIImage(data: data)
                }
            }
        }
    }
}
