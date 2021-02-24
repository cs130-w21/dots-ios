//
//  Members.swift
//  Dots
//
//  Created by Juan Bai on 1/14/21.
//

import SwiftUI

struct Members: Identifiable
{
    let id: UUID
    var name: String
    var color: Color
    
    init(id:UUID = UUID(), name: String, color: Color)
    {
        self.id = id
        self.name = name
        self.color = color
    }
}
extension Members
    {
        
        struct Data {
            var name: String = ""
            var color: Color = Color(
                red:   .random(in: 0...1),
                green: .random(in: 0...1),
                blue:  .random(in: 0...1)
                                    )
    }
        

        var data: Data
        {
            return Data(name: name,color: color)
        }

    }

extension Members
{
    static var data: [Members]
    {
        [
            Members(name: "Lucy", color: Color.red),
            Members(name: "Daisy", color: Color.yellow),
            
        ]
    }
}
