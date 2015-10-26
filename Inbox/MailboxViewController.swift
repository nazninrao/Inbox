//
//  MailboxViewController.swift
//  Inbox
//
//  Created by Naznin Richhariya on 10/24/15.
//  Copyright © 2015 wm. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController,UIGestureRecognizerDelegate {

    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var masterView: UIView!
    @IBOutlet weak var navImage: UIImageView!
    @IBOutlet weak var singleMessageImage: UIImageView!
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var laterIconImage: UIImageView!
    @IBOutlet weak var tickIconImage: UIImageView!
    @IBOutlet weak var deleteIconImage: UIImageView!
    @IBOutlet weak var listIconImage: UIImageView!
    
    @IBOutlet weak var rescheduleImage: UIImageView!
    @IBOutlet var messagePanGestureView: UIPanGestureRecognizer!
    
   // var screenEdgeGesture: UIScreenEdgePanGestureRecognizer!
    
    var messageOriginalCenter: CGPoint!
    var laterIconOriginalCenter: CGPoint!
    var tickIconOriginalcenter: CGPoint!
    var masterViewOriginalCenter: CGPoint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        rescheduleImage.alpha = CGFloat(0)
        scrollView.contentSize = feedImage.image!.size

        //Screen Edge Pan Gesture instantitated here
        
        let edgeGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        
        masterView.userInteractionEnabled = true
        edgeGestureRecognizer.edges = UIRectEdge.Left
        masterView.addGestureRecognizer(edgeGestureRecognizer)
    
       // laterIconImage.alpha = CGFloat(0.6)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func onPanSingleMessage(sender: UIPanGestureRecognizer) {
        
       // let location = messagePanGestureView.locationInView(view)
        let translation = messagePanGestureView.translationInView(view)
        
        if messagePanGestureView.state == UIGestureRecognizerState.Began
        {
            
            messageOriginalCenter = singleMessageImage.center
            print("message center started at: \(singleMessageImage.center.x)")
            
            laterIconOriginalCenter = laterIconImage.center
            print("Later icon started at \(laterIconImage.center.x)")
            
            tickIconOriginalcenter = tickIconImage.center
            print("Tick icon started at \(tickIconImage.center.x)")
            
            listIconImage.alpha = CGFloat(0)
            deleteIconImage.alpha = CGFloat(0)
            
            

        }
        
        else if messagePanGestureView.state == UIGestureRecognizerState.Changed
        {
            
            
            singleMessageImage.center = CGPoint(x: messageOriginalCenter.x + translation.x, y: messageOriginalCenter.y)
            print("message center at: \(singleMessageImage.center.x)")
            
            
            
            if singleMessageImage.center.x < 160 && singleMessageImage.center.x > 100
            {
                
                //gray color and later icon
                
                backgroundView.backgroundColor = UIColor.grayColor()
                laterIconImage.alpha = CGFloat(0.6)
                laterIconImage.center.x = CGFloat(300)
                
            }
                
        
            else if singleMessageImage.center.x < 100 && singleMessageImage.center.x > -30
            {
             
                //yellow color and move later icon
                
                backgroundView.backgroundColor = UIColor(red: 251/255, green: 212/255, blue: 13/255, alpha: 1)
                
                laterIconImage.alpha = CGFloat(1)
                
                laterIconImage.center = CGPoint(x: laterIconOriginalCenter.x + translation.x + 36 , y: messageOriginalCenter.y)
                
                print("Later icon center changed at \(laterIconImage.center.x)")
                
                
//                if laterIconImage.center.x < 180
//                {
//                  print("disappear icon")
//                  laterIconImage.alpha = CGFloat(0)
//
//                }
            }
                
            
            else if singleMessageImage.center.x < -70
            {

                //brown color and list icon
                
               
                laterIconImage.alpha = CGFloat(0)
                tickIconImage.alpha = CGFloat(0)
                
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.backgroundView.backgroundColor = UIColor(red: 217/255, green: 166/255, blue: 113/255, alpha: 1)
                    self.listIconImage.alpha = CGFloat(1)
                })
                
                
                
            }
            
            if singleMessageImage.center.x > 160 && singleMessageImage.center.x < 220
            {
                //gray and tick icon
                
                    tickIconImage.alpha = CGFloat(0.6)
                    backgroundView.backgroundColor = UIColor.grayColor()
            
            }
            
            else if singleMessageImage.center.x > 220 && singleMessageImage.center.x < 380
            {
                //green and tick icon
 
                tickIconImage.alpha = CGFloat(1)
                backgroundView.backgroundColor = UIColor(red: 108/255, green:  219/255, blue: 91/255, alpha: 1)
                
                tickIconImage.center = CGPoint(x: tickIconOriginalcenter.x + translation.x - 36 , y: tickIconOriginalcenter.y)
                
                print("icon center at \(laterIconImage.center.x)")
            }
            
            else if singleMessageImage.center.x > 380
            {
            
                //red and close icon
            
                self.tickIconImage.alpha = CGFloat(0)
                
                UIView.animateWithDuration(
                    0.1, animations: { () -> Void in
                        self.deleteIconImage.alpha = CGFloat(1)
                   self.backgroundView.backgroundColor = UIColor(red: 237/255, green:  83/255, blue: 41/255, alpha: 1)
                })
                
                
            }


        }
        
        else if messagePanGestureView.state == UIGestureRecognizerState.Ended
        {
            

            if singleMessageImage.center.x > 160 && singleMessageImage.center.x < 220
            {
                print("message ended at: \(singleMessageImage.center.x)")
                singleMessageImage.center = CGPoint(x: 160, y: singleMessageImage.center.y)
            }

            if singleMessageImage.center.x < 160 && singleMessageImage.center.x > 100
            {
                
                singleMessageImage.center = CGPoint(x: 160, y: singleMessageImage.center.y)
                
            }
            
            if singleMessageImage.center.x < 0 && singleMessageImage.center.x > -30
            {
            
                listIconImage.alpha = CGFloat(0)
                laterIconImage.alpha = CGFloat(0)
                tickIconImage.alpha = CGFloat(0)
                deleteIconImage.alpha = CGFloat(0)
                
                singleMessageImage.center = CGPoint(x: -160, y: singleMessageImage.center.y)

                UIView.animateWithDuration(0.2, animations: { () -> Void in
                                        self.rescheduleImage.alpha = CGFloat(1)})
            }

            
        }

               
    }

    @IBAction func onTapReschedule(sender: UITapGestureRecognizer) {
        
        rescheduleImage.alpha = CGFloat(0)
        
        UIView.animateWithDuration(
            0.6, animations: { () -> Void in
                print("moved up")
                self.feedImage.center.y = self.feedImage.center.y - 86
            }) { (Bool) -> Void in
                self.singleMessageImage.center.x = 160
                self.laterIconImage.alpha = CGFloat(0)
                self.laterIconImage.center.x = CGFloat(300)
                print("single message center: \(self.singleMessageImage.center.x)")
                
                UIView.animateWithDuration(0.6, animations: { () -> Void in
                    print("moved down")
                    self.feedImage.center.y = self.feedImage.center.y + 86
                })
        }

        }

    func onEdgePan(edgeGestureRecognizer: UIScreenEdgePanGestureRecognizer){
        
        var point = edgeGestureRecognizer.locationInView(view)
        let translation = edgeGestureRecognizer.translationInView(view)
        
        
        
        if edgeGestureRecognizer.state == UIGestureRecognizerState.Began
        {
            masterViewOriginalCenter = masterView.center
            print("screen center begin \(masterView.center.x)")
        }
        
        else if edgeGestureRecognizer.state == UIGestureRecognizerState.Changed
        {
        
            masterView.center = CGPoint(x: masterViewOriginalCenter.x + translation.x, y: masterViewOriginalCenter.y)
            print("screen edge changed \(masterView.frame.origin)")
        }
        
        else if edgeGestureRecognizer.state == UIGestureRecognizerState.Ended
        {
            print("screen center ended \(masterView.center.x)")
            
            if masterView.center.x > 160 && masterView.center.x < 320
            {
                masterView.frame.origin = CGPoint(x:0, y:0)
            }
            
            
            else if masterView.center.x > 280
            {
                masterView.frame.origin = CGPoint(x:272, y:0.0)
            
         
            }

        
    
        }
    
    }

    @IBAction func onTapListButton(sender: AnyObject) {
        masterView.frame.origin = CGPoint(x:0, y: 0)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
