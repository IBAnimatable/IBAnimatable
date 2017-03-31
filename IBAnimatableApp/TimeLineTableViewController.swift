//
//  TimeLineTableViewController.swift
//  IBAnimatable
//
//  Created by Eric Marchand on 31/03/2017.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import UIKit
import IBAnimatable

public class TimeLineTableViewController: AnimatableTableViewController {

  override public func viewDidLoad() {
    super.viewDidLoad()

    // Install action on refresh
    self.refreshControl?.addTarget(self, action: #selector(TimeLineTableViewController.refresh(_:)), for: .valueChanged)
  }

  public func refresh(_ refreshControl: UIRefreshControl) {
    // could update attributedTitle of refreshControl here

    // Simulate an asynchrone refresh, could be a network request...
    DispatchQueue.background.after(5) {
       // could update attributedTitle at each step

      // end refreshing, maybe reload table data if you do not implement table delegate to update each insert, update and delete events
      DispatchQueue.main.async {
        refreshControl.endRefreshing()
      }
    }
  }

}

fileprivate extension DispatchQueue {

  static var background: DispatchQueue { return DispatchQueue.global(qos: .background) }

  func after(_ delay: TimeInterval, execute closure: @escaping () -> Void) {
    asyncAfter(deadline: .now() + delay, execute: closure)
  }

}
