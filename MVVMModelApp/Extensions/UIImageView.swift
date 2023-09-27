//
//  UIImageView.swift
//  MVVMModelApp
//
//  Created by magdi sherif on 27/09/2023.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func load(with url: String?, placeHolder: UIImage? = UIImage(named: "App Placeholder") , cop: ((_ image: UIImage?) -> Void)? = nil) {
        
        image = placeHolder
        
        guard let urlString = url else { return }
        guard let url = URL(string: urlString) else { return }
        
        var activityIndicatorView: UIActivityIndicatorView
        
        if #available(iOS 13.0, *) {
            activityIndicatorView = UIActivityIndicatorView(style: .medium)
        } else {
            activityIndicatorView = UIActivityIndicatorView(style: .gray)
        }
        addSubview(activityIndicatorView)
//        activityIndicatorView.centerInSuperview()
        activityIndicatorView.startAnimating()
//        activityIndicatorView.color = .mainColor
        activityIndicatorView.isHidden = false
        activityIndicatorView.hidesWhenStopped = true
        let options: SDWebImageOptions = [.continueInBackground]
        
        sd_setImage(with: url, placeholderImage: placeHolder, options: options, progress: nil) {[weak self] (image, error, cache, url) in
            activityIndicatorView.removeFromSuperview()
            if image == nil {
                self?.image = placeHolder
                cop?(nil)
            } else {
                self?.image = image
                cop?(image)
            }
        }
    }
}
