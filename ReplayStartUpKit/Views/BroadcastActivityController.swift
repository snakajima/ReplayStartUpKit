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
        if UIDevice.current.userInterfaceIdiom == .pad {
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
                print("no sceneDelegate")
                return
            }
            guard let vc = sceneDelegate.uiWindow?.rootViewController else {
                print("no rootVC")
                return
            }
            guard let view = vc.view else {
                print("no view")
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
