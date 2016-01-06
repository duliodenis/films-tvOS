//
//  ViewController.swift
//  films
//
//  Created by Dulio Denis on 1/2/16.
//  Copyright © 2016 Dulio Denis. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let defaultSize = CGSizeMake(268, 412) // the Film's Poster Default Size when not in focus
    let inFocusSize = CGSizeMake(295, 454) // 10% increase for when it is in focus
    
    var films = [Film]()
    
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        downloadData()
    }
    
    
    // MARK: CollectionView Delegate functions
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier(REUSE_ID_COLLECTIONVIEW, forIndexPath: indexPath) as? FilmCell {
            let film = films[indexPath.row]
            cell.configureCell(film)
            
            // Add a select tap gesture recognizer if there is not one already there
            if cell.gestureRecognizers?.count == nil {
                let tap = UITapGestureRecognizer(target: self, action: "tapped:")
                tap.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)]
                cell.addGestureRecognizer(tap)
            }
            
            return cell
        } else {
            return FilmCell()
        }
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return films.count
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(348.0, 481.0)
    }
    
    
    // MARK: Data Download Function
    
    func downloadData() {
        let url = NSURL(string: "\(URL_BASE)?api_key=\(API_KEY)")!
        let request = NSURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            if error != nil {
                print(error.debugDescription)
            } else {
                do {
                    let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? Dictionary<String, AnyObject>
                    if let results = dict!["results"] as? [Dictionary<String, AnyObject>] {
                        for filmJSON in results {
                            let film = Film(filmDictionary: filmJSON)
                            self.films.append(film)
                        }
                        
                        // Update the UI on the main thread once the model updated is complete
                        dispatch_async(dispatch_get_main_queue()) { self.collectionView.reloadData() }
                    }
                } catch {
                    
                }
            }
        }
        task.resume()
    }
    
    
    // MARK: Focus Related Function
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        if let previous = context.previouslyFocusedView as? FilmCell {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                previous.filmPoster.frame.size = self.defaultSize
            })
        }
        
        if let next = context.nextFocusedView as? FilmCell {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                next.filmPoster.frame.size = self.inFocusSize
            })
        }
    }
    
    
    // MARK: Tap Gesture Recognizer Function
    
    func tapped(gesture: UITapGestureRecognizer) {
        if let cell = gesture.view as? FilmCell {
            performSegueWithIdentifier("FilmDetailVC", sender: cell)
        }
    }
    
    
    // MARK: Navigation Function
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "FilmDetailVC" {
            if let detailVC = segue.destinationViewController as? FilmDetailVC {
                if let film = sender as? FilmCell {
                    detailVC.film = film
                }
            }
            
        }
    }
}

