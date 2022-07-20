//
//  ActivityView.swift
//  WeatherTestApp
//
//  Created by Admin on 18.07.22.
//

import Foundation
import UIKit

func alertLoadingShow() {

    let window = UIWindow.key
    let alertView: AlertLoadingView = AlertLoadingView.fromNib()
    window?.addSubview(alertView)
    alertView.fillSuperview()
    alertView.animatedApperance()
//    alertView.startBringinOnFront()
}

func alertLoadingRemove() {

    let window = UIWindow.key
    window?.subviews.forEach({ (view) in
        if let loadingView = view as? AlertLoadingView {
            loadingView.animatedRemove()

        }
    })
}



class GView: UIView {

    private var activityView: AlertLoadingView = AlertLoadingView.fromNib()

    func start() {
        alertLoadingShow()
    }

    func stop() {
        alertLoadingRemove()
    }
}

class AlertLoadingView: UIView {

    @IBOutlet private weak var containerForBlur: UIView!
    @IBOutlet private weak var activityView: UIActivityIndicatorView!

    let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        return view
    }()

    var needToBringOnFront = true

    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        containerForBlur.addSubview(blurEffectView)
        blurEffectView.fillSuperview()
        activityView.startAnimating()
    }

    deinit {
        print("LOG_AlertLoadingView_Deinited")
    }

    private func setupViews() {

//        alpha = 1
        backgroundColor = UIColor.gray.withAlphaComponent(0.2)
    }

    func animatedApperance() {
//        UIView.animate(withDuration: 0.2) { self.alpha = 1 }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self = self else { return }
            self.superview?.bringSubviewToFront(self)
        }
    }

    func animatedRemove() {
//        UIView.animate(withDuration: 0.2) { self.alpha = 0 }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.21) { self.removeFromSuperview() }
        self.removeFromSuperview()
    }

}

//
//func startBringinOnFront() {
//
//    if needToBringOnFront {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
//            guard let self = self else { return }
//            self.superview?.bringSubviewToFront(self)
//            self.startBringinOnFront()
//        }
////            self.superview?.bringSubviewToFront(self)
////            startBringinOnFront()
//    }
//}
//
//func animatedApperance() {
////        UIView.animate(withDuration: 0.2) { self.alpha = 1 }
//}
//
//func animatedRemove() {
////        UIView.animate(withDuration: 0.2) { self.alpha = 0 }
////        DispatchQueue.main.asyncAfter(deadline: .now() + 0.21) { self.removeFromSuperview() }
//    needToBringOnFront = false
//    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//        self.removeFromSuperview()
//    }
//}
//

protocol ViewRequestProtocol: AnyObject {
    func startRequest()
    func finishRequest()
}
