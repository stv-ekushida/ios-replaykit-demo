//
//  ViewController.swift
//  ReplayKit-demo
//
//  Created by eiji kushida on 2019/09/18.
//  Copyright © 2019 eiji kushida. All rights reserved.
//

import UIKit
import ReplayKit

final class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startRecording(_ sender: Any) {
        RPScreenRecorder.shared().isMicrophoneEnabled = true
        RPScreenRecorder.shared().startRecording { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        RPScreenRecorder.shared().stopRecording { viewController, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let viewController = viewController else {
                return
            }
            viewController.previewControllerDelegate = self
            self.present(viewController, animated: true, completion: nil)
        }
    }
}

extension ViewController: RPPreviewViewControllerDelegate {
    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        DispatchQueue.main.async {
            previewController.dismiss(animated: true, completion: nil)
        }
    }
}

