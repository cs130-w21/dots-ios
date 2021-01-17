//
//  AddMembersView.swift
//  Dots
//
//  Created by user190399 on 1/14/21.
//

import SwiftUI

struct AddMembersView: View {
    @Binding var memberObject: Members.Data
    
    var body: some View {
        List{
            Section(header: Text("Add Member")){
                TextField("Member", text: $memberObject.name)
                
            }
            ColorPicker("Color",selection: $memberObject.color)
        }
    }
}

struct AddMembersView_Previews: PreviewProvider {
    static var previews: some View {
        AddMembersView()
    }
}
