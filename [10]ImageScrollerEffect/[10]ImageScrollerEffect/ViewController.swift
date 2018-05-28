//
//  ViewController.swift
//  [10]ImageScrollerEffect
//
//  Created by Seven on 2018/5/28.
//  Copyright © 2018年 侯伟杰. All rights reserved.
//

/*
 自动布局之autoresizingMask
 
 UIViewAutoresizingNone                 不会随父视图的改变而改变
 
 UIViewAutoresizingFlexibleLeftMargin   自动调整view与父视图左边距，以保证右边距不变
 
 UIViewAutoresizingFlexibleWidth        自动调整view的宽度，保证左边距和右边距不变
 
 UIViewAutoresizingFlexibleRightMargin  自动调整view与父视图右边距，以保证左边距不变
 
 UIViewAutoresizingFlexibleTopMargin    自动调整view与父视图上边距，以保证下边距不变
 
 UIViewAutoresizingFlexibleHeight       自动调整view的高度，以保证上边距和下边距不变
 
 UIViewAutoresizingFlexibleBottomMargin 自动调整view与父视图的下边距，以保证上边距不变
 
 
 scrollView 手势捏合
 
 - minimumZoomScale
 - maximumZoomScale
 
 
 layoutIfNeeded 如果试图
 
 */
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    func updateMinZoomScaleForSize(_ size: CGSize) {
        
        let widthScale = size.width / imageView.bounds.size.width
        let heightScale = size.height / imageView.bounds.size.height
        
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 3.0
        scrollView.zoomScale = minScale
    }
    //当scrollView的内容大小小于边界时，内容将放置在左上角而不是中心，updateConstraintForSize方法处理这个问题；通过调整图像视图的布局约束。
    func updateConstraintsForSize(_ size: CGSize) {
        let yOffset = max(0, (size.height - imageView.bounds.size.height)/2)
        let xOffset = max(0, (size.width - imageView.bounds.size.width)/2)
        
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset
        
        view.layoutIfNeeded()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateMinZoomScaleForSize(view.bounds.size)
    }
    
    override func didReceiveMemoryWarning() {    super.didReceiveMemoryWarning()}
}

extension ViewController: UIScrollViewDelegate {
    //缩放比例更改
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraintsForSize(view.bounds.size)
    }
    //返回缩放图
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}

