import Foundation
import SwiftUI

struct Exercise: Identifiable, Hashable {
    let id = UUID()
    let name: String
    
    static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

struct Workout: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let description: String
    let iconName: String
    var exercises: [Exercise]
}
