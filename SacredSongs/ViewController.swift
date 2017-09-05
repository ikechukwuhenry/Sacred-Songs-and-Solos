//
//  ViewController.swift
//  SacredSongs
//
//  Created by MAC on 04/05/2016.
//  Copyright © 2016 Ikhub. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UISearchBarDelegate, UISearchControllerDelegate {
    
   // @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var searchController: UISearchController?
    var imageView: UIImageView!
    
    var searchBar: UISearchBar!
        var myHymns = [Hymn]()
     var hymnIndex = 0
    
    
    override func viewWillAppear(_ animated: Bool) {
        // to hide the search bar
        self.collectionView.setContentOffset(CGPoint(x: 0, y: 45), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.collectionView.frame.width, height: self.collectionView.frame.height))
//        self.imageView.image = UIImage(named: "background")
//        self.collectionView.addSubview(imageView)
        collectionView.dataSource = self
        let fileName = "allsongs"
        let fileType = "json"
        let parser = Parser()
        let data = parser.createDataFromFile(fileName, ofType: fileType)
        if let hymns = parser.parseData(data) {
            myHymns = hymns
        }
//        if myHymns != nil {
//            var hymn = myHymns[0]
//        }
        let firstHymn = myHymns[0]
        
        print(firstHymn.chorus)
        
        self.searchBar = UISearchBar(frame: CGRect(x: 0, y: 10, width: self.view.frame.size.width, height: 44))
        self.searchBar.delegate = self
       // self.searchBar.autocorrectionType = false
        self.collectionView.addSubview(self.searchBar)
        
        
        
//        //setup the search controller
//        searchController = ({
//            let searchController = UISearchController(searchResultsController: nil)
//            searchController.searchResultsUpdater = self
//            searchController.hidesNavigationBarDuringPresentation = true
//            searchController.dimsBackgroundDuringPresentation = false
//            
//            //setup the search bar
//            searchController.searchBar.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
//            self.searchBarContainer?.addSubview(searchController.searchBar)
//            searchController.searchBar.sizeToFit()
//            
//            return searchController
//        })()
        
        let postEndpoint: String = "http://jsonplaceholder.typicode.com/posts/1"
        guard let url = URL(string: postEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            // this is where the completion handler code goes
            })
        task.resume()

    }
    
    
    
 
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
       // return 1
        return myHymns.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if myHymns[hymnIndex].hasChorus {
//            return myHymns[hymnIndex].verses.count + 1
//        }
//        return myHymns[hymnIndex].verses.count
        if myHymns[section].hasChorus {
            return myHymns[section].verses.count + 1
        }
        
        return myHymns[section].verses.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCell
        //let fontSize = 18.0
        //let fontName = "Helvetica Neue"
        //cell.cellLabel.font = UIFont(descriptor: UIFontDescriptor., size: <#T##CGFloat#>)
        //cell.backgroundColor = UIColor.blueColor()
        //let hymn = myHymns[hymnIndex]
        let hymn = myHymns[indexPath.section]
        var cellVerses = hymn.verses
        
        // cell.cellLabel.text = cellVerses[indexPath.row]
        if hymn.hasChorus && indexPath.row == 1 {
            
            cell.cellLabel.text = hymn.chorus!
            
        }else{
            
            if indexPath.row == 0 {
                
                
               cell.cellLabel.text = cellVerses[indexPath.row]
                
            }else{
                
                if hymn.hasChorus {
                    
                    cell.cellLabel.text = cellVerses[indexPath.row - 1]
                    
                }else {
                    
                    cell.cellLabel.text = cellVerses[indexPath.row]
                     // cell.cellLabel.text =
                }
                
            }
            
        }
       
        //cell.backgroundColor = UIColor.whiteColor()
        //cell.cellLabel.sizeToFit()
//        let minimunFontSize = 18
//        var font = UIFont(name: "Helvetica Neue", size: 10)
//        font?.fontWithSize(<#T##fontSize: CGFloat##CGFloat#>)
        //cell.cellLabel.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        
        return cell
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = false
        self.searchBar.text = ""
        self.searchBar.resignFirstResponder()
    }
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
//    {
//        //size each cell based on the size of the text for that cell
//        let hymn = myHymns[indexPath.section]
//        
//        let labelText = hymn.verses[indexPath.row]
//        let attributes = [NSFontAttributeName:labelFont()]
//        let textRect = labelText.boundingRectWithSize(CGSize(width: CGFloat.max, height: 36), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil)
//        return CGSizeMake(textRect.size.width + 20, 36)
//    }
//
//    func labelFont() -> UIFont
//    {
//        return UIFont.systemFontOfSize(17)
//    }

}

