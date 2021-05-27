//
//  PageViewController.swift
//  NewsApp
//
//  Created by Alikhan Tuxubayev on 27.05.2021.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        newsLoad {
            self.showViewContollers()
        }
    }
    
    func showViewContollers(){
        DispatchQueue.main.async {
            if let vc = self.pageViewController(for: 0){
            self.setViewControllers([vc], direction: .forward, animated: false, completion: nil)
            }
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = ((viewController as? DetailNewsController)?.index ?? 0) - 1
        
        return self.pageViewController(for: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = ((viewController as? DetailNewsController)?.index ?? 0) + 1
        
        return self.pageViewController(for: index)
    }
    
    func pageViewController(for index: Int) -> DetailNewsController? {
        if index < 0 {
            return nil
        }
        
        if index >= articles.count {
            return nil
        }
        let dvc = (storyboard?.instantiateViewController(withIdentifier: "detailNewsSbId") as! DetailNewsController)
        dvc.article = articles[index]
        dvc.index = index
        
        return dvc
    }
}
