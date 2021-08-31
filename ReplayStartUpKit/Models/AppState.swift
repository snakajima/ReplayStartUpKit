//
//  AppState.swift
//  ReplayStartUpKit
//
//  Created by SATOSHI NAKAJIMA on 8/31/21.
//

import Foundation
import ReplayKit

class AppState: NSObject, ObservableObject {
    static let shared = AppState()
    enum ActivePopup: Identifiable {
        case broadCast
        var id: Int {
            hashValue
        }
    }
    @Published var activePopup: ActivePopup?
    var bavController: RPBroadcastActivityViewController?
    var broadCastController: RPBroadcastController? {
        didSet {
            isBroadcasting = broadCastController != nil
        }
    }
    @Published var isBroadcasting = false

    func startBroadcast() {
        if let broadCastController = self.broadCastController,
           broadCastController.isBroadcasting {
            broadCastController.finishBroadcast { error in
                print("finishBroadcast", error ?? "success")
            }
            return
        }
        
        let recorder = RPScreenRecorder.shared()
        recorder.isMicrophoneEnabled = true
        
        RPBroadcastActivityViewController.load { controller, error in
            print("###", controller ?? "no controller", error ?? "success")
            if let controller = controller {
                self.bavController = controller
                controller.delegate = self
                self.activePopup = .broadCast
            }
        }
    }
}

extension AppState: RPBroadcastActivityViewControllerDelegate {
    func broadcastActivityViewController(_ broadcastActivityViewController: RPBroadcastActivityViewController, didFinishWith broadcastController: RPBroadcastController?, error: Error?) {
        print("###", error ?? "success")
        DispatchQueue.main.async {
            self.bavController?.delegate = nil
            self.bavController = nil
            self.activePopup = nil
        }
        guard let broadcastController = broadcastController else {
            return
        }
        broadcastController.startBroadcast { error in
            if let error = error {
                print("startBroadcast failed", error)
                return
            }
            print("startBroadcast started", broadcastController.broadcastURL)
            broadcastController.delegate = self
            self.broadCastController = broadcastController
        }
    }
}

extension AppState : RPBroadcastControllerDelegate {
    func broadcastController(_ broadcastController: RPBroadcastController, didFinishWithError error: Error?) {
        if let error = error {
            print("didFinishWithError", error.localizedDescription)
        } else {
            print("didFinish")
        }
        self.broadCastController?.delegate = nil
        self.broadCastController = nil
    }
    
    func broadcastController(_ broadcastController: RPBroadcastController, didUpdateBroadcast broadcastURL: URL) {
        print("didUpdateBroadcast", broadcastURL)
    }
    
    func broadcastController(_ broadcastController: RPBroadcastController, didUpdateServiceInfo serviceInfo: [String : NSCoding & NSObjectProtocol]) {
        print("didUpdateServiceInfo", serviceInfo)
    }
}
