//
//  ArchivedItemsTableViewController.swift
//  
//
//  Created by Gary O'Donoghue on 20/01/2019.
//

import UIKit

class ArchivedItemsViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private let dataAccess = ArchivedDataAccess()
    private let commonDataAccess = CommonDataAccess()
    
    private var comics: [Comic]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        scrollView.delegate = self
        
        dataAccess.getArchived(completion: { result in
            self.comics = result
            self.pageController.numberOfPages = self.comics!.count
            self.pageController.currentPage = 0
            self.setupComicScrollView(comics: self.createComics())
        })
        
    }
    
    func createComics() -> [ComicView] {
        var comicsArray : [ComicView] = []
        
        for comic in self.comics! {
            let comicInstance: ComicView = Bundle.main.loadNibNamed("ComicView", owner: self, options: nil)?.first as! ComicView
                comicInstance.comicTitle.text = comic.title
                self.commonDataAccess.getImage(byUrl: comic.imageUrl, completion: { data in
                    comicInstance.comicImage.image = UIImage(data: data)
                })
            
            comicsArray.append(comicInstance)
        }
        
        return comicsArray
    }
    
    func setupComicScrollView(comics : [ComicView]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(comics.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< comics.count {
            comics[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(comics[i])
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeLeft
    }

    override var shouldAutorotate: Bool {
        return true
    }
}
