//
//  PasswordViewController.swift
//  StampKitDemo
//
//  Created by Sam Smallman on 14/04/2020.
//  Copyright © 2020 Artifice Industries Ltd. All rights reserved.
//

import Cocoa
import StampKit

protocol PasswordDelegate {
    func passwordController(_ controller: PasswordViewController, didConnectToTimeline timeline: SKTimeline)
}
class PasswordViewController: NSViewController {
    
    private let timeline: SKTimeline
    public var delegate: PasswordDelegate?
    
    @IBOutlet weak var timelineLabel: NSTextField!
    @IBOutlet weak var textField: NSTextField!
    
    init(timeline: SKTimeline, connectedTimeline: inout SKTimeline?) {
        self.timeline = timeline
        super.init(nibName: "PasswordViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timelineLabel.stringValue = timeline.name
    }
    
    @IBAction func connect(_ sender: Any) {
        if !textField.stringValue.isEmpty {
            timeline.connect(with: textField.stringValue, completionHandler: { [weak self] timeline in
                guard let strongSelf = self else { return }
                print("Connecting to \(timeline.name)")
                strongSelf.delegate?.passwordController(strongSelf, didConnectToTimeline: timeline)
            })
        }
        dismiss(self)
    }
}
