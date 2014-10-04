//
//  PhotoViewController.swift
//  Facebook
//
//  Created by Loren on 10/2/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var actionsPanel: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var photoImageView: UIImageView!
    var image: UIImage!
    var offset: Float!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImageView.image = image
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: 320, height: 700)
        scrollView.backgroundColor = UIColor(white: 0, alpha: 1)
        
        // scrollView.contentSize = photoImageView.frame.size
        photoImageView.hidden = true
    }
    
    override func viewDidAppear(animate: Bool) {
    photoImageView.hidden = false

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func onDoneTap(sender: AnyObject) {
        dismissViewControllerAnimated(true , completion: nil)
    }
    
    
    /*
    func showPhotoImage() {
    photoImageView.hidden = false
    }
    */
    
    
    func convertValue(value: Float, r1Min: Float, r1Max: Float, r2Min: Float, r2Max: Float) -> Float {
        var ratio = (r2Max - r2Min) / (r1Max - r1Min)
        return value * ratio + r2Min - r1Min * ratio
    }
    
    
    
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        // This method is called as the user scrolls
        offset = Float(scrollView.contentOffset.y)
        
        var buttonAlpha = CGFloat(convertValue(offset, r1Min: 0, r1Max: -60, r2Min: 1, r2Max: 0))
        doneButton.alpha = buttonAlpha
        actionsPanel.alpha = buttonAlpha
        scrollView.backgroundColor = UIColor(white: 0, alpha: CGFloat(convertValue(offset, r1Min: 0, r1Max: -100, r2Min: 1, r2Max: 0.5)))
  

        print("running!")
        
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView!) {
        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView!,
        willDecelerate decelerate: Bool) {
            // This method is called right as the user lifts their finger
            if offset < -70 {
                dismissViewControllerAnimated(true , completion: nil)
              //  NewsFeedViewController.offset = self.offset
                
            }
            
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView!) {
        // This method is called when the scrollview finally stops scrolling.
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        println("prepare for segue")
        //passing images
        var destinationViewController = segue.destinationViewController as NewsFeedViewController
        destinationViewController.offset = self.offset
        
        
    }


    
    
    
    
    
    
    
}
