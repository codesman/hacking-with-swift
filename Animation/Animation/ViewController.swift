//
//  ViewController.swift
//  Animation
//
//  Created by Tom Holland on 5/18/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var imageView: UIImageView!
    var currentAnimation = 0
    
    @IBOutlet var tap: UIButton!
    
    @IBAction func tapped(_ sender: Any) {
        
        tap.isHidden = true
        
        UIView.animate(
            withDuration: 1,
            delay: 0,
            options: [],
            animations: { [unowned self] in self.switchAnimation() },
            completion: { [unowned self] (finished: Bool) in self.tap.isHidden = false }
        )
    }
    
    func switchAnimation() {
        switch self.currentAnimation {
        case 0:
            self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
        default:
            break
        }
        
        currentAnimation += 1
        
        guard currentAnimation < 8 else {
            
            currentAnimation = 0
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(image: UIImage(named: "penguin"))
        imageView.center = CGPoint(x: 512, y: 384)
        view.addSubview(imageView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
