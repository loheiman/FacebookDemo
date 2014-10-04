//
//  NewsFeedViewController.swift
//  Facebook
//
//  Created by Timothy Lee on 8/3/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImageView: UIImageView!
    var imageViewToSegue : UIImageView!
    var isPresenting: Bool = true
    var offset: Float!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure the content size of the scroll view
        scrollView.contentSize = CGSizeMake(320, feedImageView.image!.size.height)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollView.contentInset.top = 0
        scrollView.contentInset.bottom = 50
        scrollView.scrollIndicatorInsets.top = 0
        scrollView.scrollIndicatorInsets.bottom = 50
    }
    
    
    @IBAction func onImageTap(gestureRecognizer: UITapGestureRecognizer) {
        imageViewToSegue = gestureRecognizer.view as UIImageView
        performSegueWithIdentifier("PhotoSegue", sender: self)
        
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        //passing images
        var destinationViewController = segue.destinationViewController as PhotoViewController
        destinationViewController.image = self.imageViewToSegue.image
        
        //setting up transition
        var destinationVC = segue.destinationViewController as UIViewController
        destinationVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationVC.transitioningDelegate = self
        
    }
    
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 0.4
    }
    
   
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        
        if (isPresenting) {
            
            
            
            
            var window = UIApplication.sharedApplication().keyWindow
            var frame = window.convertRect(imageViewToSegue.frame, fromView: scrollView)
            var copyImageViewToSegue = UIImageView(frame: frame)
            copyImageViewToSegue.clipsToBounds = true
            copyImageViewToSegue.image = imageViewToSegue.image
            copyImageViewToSegue.contentMode = UIViewContentMode.ScaleAspectFill
            window.addSubview(copyImageViewToSegue)
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
            
              
                copyImageViewToSegue.frame.size.width = 320
                copyImageViewToSegue.frame.size.height = 320 * (copyImageViewToSegue.image!.size.height / copyImageViewToSegue.image!.size.width)
                copyImageViewToSegue.center.x = 320 / 2
                copyImageViewToSegue.center.y = 568 / 2
                toViewController.view.alpha = 1
                
            
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    copyImageViewToSegue.removeFromSuperview()
            }
        } else {
          
           
            /*
            
            var photoViewController = fromViewController as PhotoViewController
            var feedViewController = toViewController as NewsFeedViewController
            
            var copyImageViewToSegue = UIImageView()
            copyImageViewToSegue.image = photoViewController.image
            
            var window = UIApplication.sharedApplication().keyWindow
            containerView.addSubview(photoViewController.view)
            window.addSubview(copyImageViewToSegue)
            
            feedViewController.view.alpha = 0
            photoViewController.view.alpha = 0
            */
            
            
            var window = UIApplication.sharedApplication().keyWindow
            var copyImageViewToSegue = UIImageView()
            copyImageViewToSegue.clipsToBounds = true
            copyImageViewToSegue.image = imageViewToSegue.image
            copyImageViewToSegue.contentMode = UIViewContentMode.ScaleAspectFill
           
            
            copyImageViewToSegue.frame.size.width = 320
            copyImageViewToSegue.frame.size.height = 320 * (copyImageViewToSegue.image!.size.height / copyImageViewToSegue.image!.size.width)
            copyImageViewToSegue.center.x = 320 / 2
            copyImageViewToSegue.center.y = 568 / 2
            
            containerView.addSubview(fromViewController.view)
            window.addSubview(copyImageViewToSegue)
            
            toViewController.view.alpha = 0
            fromViewController.view.alpha = 0
            
            
            
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                
                copyImageViewToSegue.frame = window.convertRect(self.imageViewToSegue.frame, fromView: self.scrollView)
                
                toViewController.view.alpha = 1
                //   feedViewController.view.alpha = 1
            
                
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    
                    fromViewController.view.removeFromSuperview()
                    //  photoViewController.view.removeFromSuperview()
                    
                    copyImageViewToSegue.removeFromSuperview()
                   
                   
            }
        }
    }
    
    
    
    
}
