//
//  ViewController.swift
//  QRCode
//
//  Created by hwen on 1/12/20.
//

import UIKit
import QRCoder

class ViewController: UIViewController {

    @IBOutlet weak var QRImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let generator = QRCodeGenerator()
        //Default correction level is M
        generator.correctionLevel = .H
        QRImage.image = generator.createImage(value: "Hello world!",size: CGSize(width: 200,height: 200))!
        
    }


}

