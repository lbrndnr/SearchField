//
//  Qualifier.swift
//  
//
//  Created by Laurin Brandner on 04.07.23.
//

import SwiftUI

struct QualifierKey: EnvironmentKey {
    
    static var defaultValue = [String: Qualifier]()
    
}

extension EnvironmentValues {
    
    var qualifiers: [String: Qualifier] {
        get { self[QualifierKey.self] }
        set { self[QualifierKey.self] = newValue }
    }
    
}

public struct Qualifier {
    
    public var keyword: String
    public var attributes: AttributeContainer
    
}

extension Qualifier: ViewModifier {
    
    public func body(content: Content) -> some View {
        content
            .transformEnvironment(\.qualifiers) { qualifiers in
                qualifiers[keyword] = self
            }
    }
    
}
