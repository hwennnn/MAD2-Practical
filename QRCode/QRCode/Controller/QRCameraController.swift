//
//  QRCameraController.swift
//  QRCode
//
//  Created by hwen on 5/12/20.
//

import Foundation
import UIKit
import QRCoder
import AVFoundation
import QRCodeReader

class QRCameraController: UIViewController {
    
    weak var delegate : QRCodeReaderViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // Good practice: create the reader lazily to avoid cpu overload during the
    // initialization and each time we need to scan a QRCode
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            
            // Configure the view controller (optional)
            $0.showTorchButton        = false
            $0.showSwitchCameraButton = false
            $0.showCancelButton       = false
            $0.showOverlayView        = true
            $0.rectOfInterest         = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()

    @IBAction func scanAction(_ sender: AnyObject) {
      // Retrieve the QRCode content
      // By using the delegate pattern
        readerVC.delegate = self.delegate

      // Or by using the closure pattern
      readerVC.completionBlock = { (result: QRCodeReaderResult?) in
        let value = result?.value;
        print(value!)

        self.showAlert(value!)
      }

      // Presents the readerVC as modal form sheet
      readerVC.modalPresentationStyle = .formSheet
     
      present(readerVC, animated: true, completion: nil)
    }
    
    func showAlert(_ link : String){
        self.dismiss(animated: true, completion: nil)
        let alertView = UIAlertController(title: "Result", message: "This is the scan result \(link)", preferredStyle: UIAlertController.Style.alert)
        
        alertView.addAction(UIAlertAction(title: "Close",style: UIAlertAction.Style.default, handler: { _ in }))
        
        self.present(alertView, animated: true, completion: nil)
    }
    
    // MARK: - QRCodeReaderViewController Delegate Methods

    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
      reader.stopScanning()

      dismiss(animated: true, completion: nil)
    }


    func readerDidCancel(_ reader: QRCodeReaderViewController) {
      reader.stopScanning()

      dismiss(animated: true, completion: nil)
    }
}

