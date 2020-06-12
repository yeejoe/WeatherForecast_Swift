//
//  BaseNavigationController.swift
//  weatherforecast
//
//  Created by Joe on 12/06/2020.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let topSafeArea = view.safeAreaInsets.top
        // Do any additional setup after loading the view.
        let gradient = CAGradientLayer()
        let sizeLength = UIScreen.main.bounds.size.height * 2
        let defaultNavigationBarFrame = CGRect(x: 0, y: topSafeArea, width: sizeLength, height: 64)
        gradient.frame = defaultNavigationBarFrame
        gradient.colors = [UIColor.white.cgColor, UIColor.black.cgColor]
        UINavigationBar.appearance().setBackgroundImage(self.image(fromLayer: gradient), for: .default)
    }
    func image(fromLayer layer: CALayer) -> UIImage {
        UIGraphicsBeginImageContext(layer.frame.size)

        layer.render(in: UIGraphicsGetCurrentContext()!)

        let outputImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return outputImage!
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
