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
    var imageCenter: CGPoint!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImageView.image = image
        println(photoImageView.image?.imageAsset)
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: 1600, height: 568)
        scrollView.backgroundColor = UIColor(white: 0, alpha: 1)
        
        // scrollView.contentSize = photoImageView.frame.size
        photoImageView.hidden = true
        
        // setting image size
        if photoImageView.image!.size.height > photoImageView.image!.size.width {
            photoImageView.frame.size.height = 470
            photoImageView.frame.size.height = 470 * photoImageView.image!.size.width / photoImageView.image!.size.height
         
        }
            
        else {
            photoImageView.frame.size.width = 320
            photoImageView.frame.size.height = 320 * photoImageView.image!.size.height / photoImageView.image!.size.width
          
        }
        photoImageView.center.y = view.center.y

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
    
   
    
    
    func convertValue(value: Float, r1Min: Float, r1Max: Float, r2Min: Float, r2Max: Float) -> Float {
        var ratio = (r2Max - r2Min) / (r1Max - r1Min)
        return value * ratio + r2Min - r1Min * ratio
    }
    
    
    /*
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        // This method is called as the user scrolls
        offset = Float(scrollView.contentOffset.y)
        
        var buttonAlpha = CGFloat(convertValue(offset, r1Min: 0, r1Max: -60, r2Min: 1, r2Max: 0))
        doneButton.alpha = buttonAlpha
        actionsPanel.alpha = buttonAlpha
        scrollView.backgroundColor = UIColor(white: 0, alpha: CGFloat(convertValue(offset, r1Min: 0, r1Max: -100, r2Min: 1, r2Max: 0.5)))
  
        
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView!) {
        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView!,
        willDecelerate decelerate: Bool) {
            // This method is called right as the user lifts their finger
            if offset < -70 {
                dismissViewControllerAnimated(true , completion: nil)
              
            }
            else {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.scrollView.contentOffset.y = 0
                }, completion: nil  )
                
                            }
            
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView!) {
        // This method is called when the scrollview finally stops scrolling.
    }
    
*/
  
    
    @IBAction func panImage(sender: AnyObject) {
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            
            imageCenter = photoImageView.center
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            photoImageView.center.y = translation.y + imageCenter.y
            var delta = Float(photoImageView.center.y - imageCenter.y)
            
            var buttonAlpha = CGFloat(convertValue(delta, r1Min: 0, r1Max: 60, r2Min: 1, r2Max: 0))
            doneButton.alpha = buttonAlpha
            actionsPanel.alpha = buttonAlpha
            scrollView.backgroundColor = UIColor(white: 0, alpha: CGFloat(convertValue(delta, r1Min: 0, r1Max: 60, r2Min: 1, r2Max: 0.5)))
            
            println("delta \(delta)")
        
            
            
            
        } else if sender.state == UIGestureRecognizerState.Ended{
            
            if translation.y > 100 {
                dismissViewControllerAnimated(true , completion: nil)
                println(translation.y)
            }
            else {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.photoImageView.center = self.imageCenter
                    self.doneButton.alpha = 1
                    self.actionsPanel.alpha = 1
                    self.scrollView.backgroundColor = UIColor(white: 0, alpha: 1)
                    
                    }, completion: nil  )
                
            }
            
        }
    }
    
    
    
    
    
    
    
    
    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
        return photoImageView
    }
    
    
    @IBAction func doubleTapImage(sender: AnyObject) {
        if scrollView.zoomScale > scrollView.minimumZoomScale {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
            
        }
        
        else {
            var location = sender.locationInView(view)
            self.scrollView.zoomToRect(CGRect(x: location.x, y: location.y, width: 50, height: 50), animated: true)
        }
        
    }
    
    
    
    
}
