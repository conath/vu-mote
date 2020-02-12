//
//  SwiftUITweaks.swift
//  VUMote
//
//  Created by Christoph Parstorfer on 11.02.20.
//  Copyright © 2020 Christoph Parstorfer. All rights reserved.
//

import Foundation
import SwiftUI

extension View {
    // Conditional transform
    func `if`<T: View>(_ condition: Bool, transform: (Self) -> T) -> some View {
        Group {
            if condition {
                transform(self)
            } else {
                self
            }
        }
    }
    // Inverse of content.mask(self)
    func maskContent<T: View>(using: T) -> some View {
        using.mask(self)
    }
}
