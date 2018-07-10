//
//  StringCornerDesignable.swift
//  IBAnimatable
//
//  Created by Steven on 5/12/17.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import Foundation
@testable import IBAnimatable

// MARK: - StringCornerDesignable Protocol

protocol StringCornerDesignable: CornerDesignable {

  var _cornerSides: String? { get set }

}

// MARK: - Classes with StringCornerDesignable conformance

extension AnimatableView: StringCornerDesignable {}
extension AnimatableScrollView: StringCornerDesignable {}
extension AnimatableButton: StringCornerDesignable {}
extension AnimatableCheckBox: StringCornerDesignable {}
extension AnimatableImageView: StringCornerDesignable {}
extension AnimatableLabel: StringCornerDesignable {}
extension AnimatableStackView: StringCornerDesignable {}
extension AnimatableTableViewCell: StringCornerDesignable {}
extension AnimatableTextField: StringCornerDesignable {}
extension AnimatableTextView: StringCornerDesignable {}
extension AnimatableCollectionViewCell: StringCornerDesignable {}
