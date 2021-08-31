//
//  BroadcastActivityController.swift
//  ReplayStartUpKit
//
//  Created by SATOSHI NAKAJIMA on 8/30/21.
//

import SwiftUI
import ReplayKit

struct BroadcastActivityController: UIViewControllerRepresentable {
    let controller: RPBroadcastActivityViewController
    func makeUIViewController(context: Context) -> RPBroadcastActivityViewController {
        return controller
    }
    
    func updateUIViewController(_ uiViewController: RPBroadcastActivityViewController, context: Context) {
        // Hack to work around iPad issue
        if UIDevice.current.userInterfaceIdiom == .pad {
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
                  let vc = sceneDelegate.uiWindow?.rootViewController,
                  let view = vc.view else {
                print("somethign is really wrong")
                return
            }
            controller.modalPresentationStyle = .popover
            if let popover = controller.popoverPresentationController {
                popover.sourceRect = CGRect(origin: .zero, size: CGSize(width: 10, height: 10))
                popover.sourceView = view
                popover.permittedArrowDirections = []
            }
        }
    }
    
    typealias UIViewControllerType = RPBroadcastActivityViewController
}
