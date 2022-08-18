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
    // Inverse of content.mask(self)
    func maskContent<T: View>(using: T) -> some View {
        using.mask(self)
    }
}
