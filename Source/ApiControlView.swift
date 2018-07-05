//
//  ApiControlView.swift
//  PGDebugView
//
//  Created by Jin Hyong Park on 5/7/18.
//  Copyright © 2018 PropertyGuru Pte Ltd. All rights reserved.
//

internal typealias ApiControlViewHanlder = ((ApiControlSelectedDirection) -> ())

internal enum ApiControlSelectedDirection {
    case down
    case left
    case right
}

/**
 A view in order to facilitate api environment change.
 Basic concept is just mimicing google chrome pull to refresh ui.
 Developer have to set its target scrollview to eventSource first,
 and set handler to handle its event as well.
 */
internal final class ApiControlView: UIRefreshControl {
    private let dataSource = ["Staging", "Production", "Integration"]
    private var indicator = UIView()
    private let threshhold: CGFloat = 400.0
    private var gestureRecognizer: UIPanGestureRecognizer?
    
    internal var handler: ApiControlViewHanlder?
    internal let height: CGFloat = 65.0
    internal weak var eventSource: UIScrollView? {
        didSet {
            if let currentGestureRecognizer = gestureRecognizer,
                let currentEventSource = eventSource {
                currentEventSource.removeGestureRecognizer(currentGestureRecognizer)
            }
            if let eventSource = eventSource {
                let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.panned(recognizer:)))
                panGestureRecognizer.delegate = self
                eventSource.addGestureRecognizer(panGestureRecognizer)
                gestureRecognizer = panGestureRecognizer
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0.0, y: -height, width: UIScreen.main.bounds.width, height: height))
        let widthForLabel = self.frame.width / CGFloat(dataSource.count)
        indicator.frame = CGRect(x: widthForLabel * CGFloat(1), y: 0.0, width: widthForLabel, height: height)
        indicator.backgroundColor = UIColor.green
        self.addSubview(indicator)
        for (index, data) in dataSource.enumerated() {
            let xCoordinate = widthForLabel * CGFloat(index)
            let label = UILabel(frame: CGRect(x: xCoordinate, y: 0.0, width: widthForLabel, height: height))
            label.font = UIFont.systemFont(ofSize: 20.0)
            label.textAlignment = NSTextAlignment.center
            label.text = data
            label.backgroundColor = UIColor.clear
            self.addSubview(label)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func handleUserInteraction(direction: ApiControlSelectedDirection) {
        if direction == .down {
            animateViewTo(index: 1)
        } else if direction == .left {
            animateViewTo(index: 0)
        } else {
            animateViewTo(index: 2)
        }
        handler?(direction)
    }
    
    private func animateViewTo(index: Int) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let indicator = self?.indicator else {
                return
            }
            indicator.frame = CGRect(x: indicator.frame.size.width * CGFloat(index), y: indicator.frame.origin.y, width: indicator.frame.size.width, height: indicator.frame.size.height)
        }
    }
}

extension ApiControlView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension ApiControlView {
    /**
     Function for handle pull down event
     */
    override internal func beginRefreshing() {
        super.beginRefreshing()
        handleUserInteraction(direction: .down)
    }
    
    /**
     Function for handle swipe left and right event
     */
    @objc internal func panned(recognizer: UIPanGestureRecognizer) {
        if self.frame.origin.y > -height {
            return
        }
        // right panning
        if recognizer.velocity(in: eventSource).x > threshhold {
            handleUserInteraction(direction: .right)
        } else if recognizer.velocity(in: eventSource).x < -threshhold {
            handleUserInteraction(direction: .left)
        }
    }
}
