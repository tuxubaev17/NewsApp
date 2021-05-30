//
//  TableViewCell.swift
//  NewsApp
//
//  Created by Alikhan Tuxubayev on 30.05.2021.
//

import UIKit

class NewsTableViewCellViewModel {
    let title: String
    let imgUrl: URL?
    var imgData: Data? = nil
    
    init(title:String, imgUrl: URL?) {
        self.title = title
        self.imgUrl = imgUrl
    }
}

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coverPhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with viewModel: NewsTableViewCellViewModel){
        titleLabel.text = viewModel.title
        
        if let data = viewModel.imgData{
            coverPhoto.image = UIImage(data: data)
        }else if let url = viewModel.imgUrl {
            URLSession.shared.dataTask(with: url) {data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imgData = data
                DispatchQueue.main.async {
                    self.coverPhoto.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
