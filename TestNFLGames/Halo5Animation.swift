//
//  SuccessAnimationView.swift
//  Planet
//
//  Created by Ty Schultz on 10/25/15.
//  Copyright © 2015 Ty Schultz. All rights reserved.
//

import UIKit

class Halo5Animation: UIView {

    let BACKGROUNDCOLOR = UIColor(red:0.18, green:0.45, blue:0.64, alpha:1)
    let ANIMATIONTIME = 0.1
    let ALPHA :CGFloat = 0.9
    
    //Objects
    var backgroundView : UIView?
    var box : UIView?
    var label : UILabel?

    //Lines
    var leftBorderLine : UIView?
    var rightBorderLine : UIView?
    var topBorderLine : UIView?
    var bottomBorderLine : UIView?
    
    
    var name: String?
    
     init(frame: CGRect, name: String = "Victory") {
        super.init(frame: frame)
        
        self.name = name
        self.initialize()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.initialize()
    }
    
    func closeView(){
        self.removeFromSuperview()
    }
    
    func initialize() {
        
       let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(Halo5Animation.closeView))
        addGestureRecognizer(tapRecognizer)
        
        backgroundColor = UIColor.clear
        
        
        backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: self.frame.size.height))
        backgroundView?.backgroundColor = BACKGROUNDCOLOR
        backgroundView?.alpha = ALPHA
        
        addSubview(backgroundView!)
        
        createBox()
        createLines()
        createLabel()
        animateLines()

        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
            self.backgroundView!.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)

            }) { (Bool) -> Void in
        }
    }
    
    func createBox() {
        let width = self.frame.size.width-128
        let height :CGFloat = 100
        box = UIView(frame: CGRect(x: 64, y: self.frame.midY-150, width: width, height: height))
        box?.backgroundColor = UIColor.clear
        addSubview(box!)
    }
    
    func createLabel() {
        let width = self.frame.size.width-128
        let height :CGFloat = 100

        label = UILabel(frame: CGRect(x: 64, y: self.frame.midY-150, width: width, height: height))
        label?.text = name
        label?.font = UIFont(name: "Avenir Medium", size: 40.0)
        label?.textColor = UIColor.white
        label?.textAlignment = NSTextAlignment.center
        label?.alpha = 0.0
        addSubview(label!)
    }
    
    func createLines () {
        let LINECOLOR = UIColor(red:0.77, green:0.91, blue:1, alpha:1)
        let STARTSIZE : CGFloat = 1.0
        let RIGHTX : CGFloat = box!.frame.size.width
        let BOTTOMY : CGFloat = box!.frame.size.height
        
        
        leftBorderLine = UIView(frame: CGRect(x: 0, y: BOTTOMY, width: STARTSIZE, height: STARTSIZE))
        leftBorderLine?.backgroundColor = LINECOLOR
        box!.addSubview(leftBorderLine!)
        
        rightBorderLine = UIView(frame: CGRect(x: RIGHTX, y: 0, width: STARTSIZE, height: STARTSIZE))
        rightBorderLine?.backgroundColor = LINECOLOR
        box!.addSubview(rightBorderLine!)
        
        topBorderLine = UIView(frame: CGRect(x: 0, y: 0, width: STARTSIZE, height: STARTSIZE))
        topBorderLine?.backgroundColor = LINECOLOR
        box!.addSubview(topBorderLine!)
        
        bottomBorderLine = UIView(frame: CGRect(x: RIGHTX, y: BOTTOMY, width: STARTSIZE, height: STARTSIZE))
        bottomBorderLine?.backgroundColor = LINECOLOR
        box!.addSubview(bottomBorderLine!)
        
    }
    
   
    
    func animateLines() {
        let LINEWIDTH :CGFloat = 1.0
        let HEIGHT :CGFloat = 100
        let WIDTH :CGFloat = box!.frame.size.width
        let RIGHTX : CGFloat = box!.frame.size.width
        let BOTTOMY : CGFloat = box!.frame.size.height
        
        flashLabelAlpha(3)
        
        UIView.animate(withDuration: 0.1, animations:  { () -> Void in
            self.leftBorderLine?.frame = CGRect(x: 0, y: 0, width: LINEWIDTH, height: HEIGHT) //Left Bar
            }, completion: { (Bool) -> Void in
                UIView.animate(withDuration: 0.05, animations: { () -> Void in
                    self.topBorderLine?.frame = CGRect(x: 0, y: 0, width: WIDTH, height: LINEWIDTH) //top Bar
                    }, completion: { (Bool) -> Void in
                        UIView.animate(withDuration: 0.05, animations: { () -> Void in
                            self.rightBorderLine!.frame = CGRect(x: RIGHTX, y: 0, width: LINEWIDTH, height: HEIGHT) // right Bar
                            }, completion: { (Bool) -> Void in
                                UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
                                    self.bottomBorderLine?.frame = CGRect(x: 0, y: BOTTOMY, width: WIDTH, height: LINEWIDTH) // Bottom Bar
                                    }) { (Bool) -> Void in
                                        self.animateBars() // Call bar animations
                                }
                        }) 
                }) 
        }) 
    }
    
    func animateBars(){
        let BARCOLOR = UIColor(red:0.77, green:0.91, blue:1, alpha:1)
        let HEIGHT :CGFloat = 100
        let WIDTH :CGFloat = box!.frame.size.width
        let RIGHTX : CGFloat = box!.frame.size.width
        let BOTTOMY : CGFloat = box!.frame.size.height
        
        //Create two bars for sideways motion
        let secondBar = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: HEIGHT))
        secondBar.backgroundColor = BARCOLOR
        secondBar.alpha = 0.6
        box!.addSubview(secondBar)
        box!.sendSubview(toBack: secondBar)
        
        let firstBar = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: HEIGHT))
        firstBar.backgroundColor = BARCOLOR
        firstBar.alpha = 0.3
        box!.addSubview(firstBar)
        box!.sendSubview(toBack: firstBar)
        
        
        //Create animations
        let firstBarAnimation  = {
            firstBar.frame = CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT)
        }
        
        let secondBarAnimation = {
            secondBar.frame = CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT)
        }
        
        let secondBarShrinkWithTopLine = {
            secondBar.frame = CGRect(x: RIGHTX, y: 0, width: 0, height: HEIGHT)
            self.topBorderLine?.frame = CGRect(x: RIGHTX, y: 0, width: 0, height: 0)
        }
        
        let shrinkBottomAndRightLine = {
            self.bottomBorderLine?.frame = CGRect(x: RIGHTX, y: BOTTOMY, width: 0, height: 0)
            self.rightBorderLine?.frame = CGRect(x: RIGHTX, y: BOTTOMY, width: 0, height: 0)
        }
        
        let fadeBackgroundView = {
            self.backgroundView!.alpha = 0.0
        }
        
        let fadeLabelAndFirstBar = {
            firstBar.frame = CGRect(x: RIGHTX, y: 0, width: 0, height: HEIGHT)
            self.label?.alpha = 0.0
        }
  
        
        //Run Animations
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions(), animations: firstBarAnimation) { (Finished) -> Void in
            UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions(), animations: secondBarAnimation ) { (Finished) -> Void in
                //Shrink
                self.leftBorderLine?.alpha  = 0.0

                UIView.animate(withDuration: 0.3, delay: 0.0,  options: UIViewAnimationOptions(), animations: secondBarShrinkWithTopLine, completion: nil)
                UIView.animate(withDuration: 0.3, delay: 0.15, options: UIViewAnimationOptions(), animations: shrinkBottomAndRightLine, completion: nil)
                UIView.animate(withDuration: 0.3, delay: 0.1,  options: UIViewAnimationOptions(), animations: fadeLabelAndFirstBar, completion:nil)
                UIView.animate(withDuration: 0.7, delay: 0.5,  options: UIViewAnimationOptions(), animations: fadeBackgroundView, completion: { (Finished) -> Void in
                    self.removeFromSuperview()
                })
            }
        }
    }
   
    
    
    func flashLabelAlpha(_ flashes : Int){
        if flashes == 0 { return }
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveLinear, animations: { () -> Void in
            if self.label!.alpha == 1.0 {
                self.label!.alpha = 0.0
            }else{
                self.label!.alpha = 1.0
            }
        }, completion: { (Bool) -> Void in
              self.flashLabelAlpha(flashes-1)
        })
    }
    
}
