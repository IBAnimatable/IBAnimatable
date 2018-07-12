//
//  GradientMode.swift
//  IBAnimatable
//
//  Created by Tom Baranes on 08/01/2018.
//  Copyright © 2018 IBAnimatable. All rights reserved.
//

import Foundation

public enum GradientMode: String, IBEnum {
  case linear
  case radial
  case conical
}

#if swift(>=4.2)
extension GradientMode: CaseIterable {}
#endif
