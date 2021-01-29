//
//  AddBillView.swift
//  Dots
//
//  Created by Juan Bai on 1/18/21.
//

import SwiftUI




struct AddBillView: View {
    
    @Binding var bill: BillObject
    @State private var newBillName=""
    @State  var newBillDate = Date()
    var body: some View
{

    VStack{

        Image("cat")
            .resizable()
            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            .frame(width: 150, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .offset(y:30)
            .clipped()
            .cornerRadius(150)
            .padding()
        Text("Welcome To Dots")
            .font(.headline)
            
    List{
        Section(header: Text("Add New Bill"))
        {
            TextField("Bill Title", text: $bill.title)
            DatePicker("Date", selection: $bill.date, displayedComponents: .date)
        }
        // bill.title.append(newBillName)
        

       
        // ColorPicker("Color",selection: $BillObject.color)
        }
    }
}
}



struct AddBillView_Previews: PreviewProvider {
    static var previews: some View {
        AddBillView(bill: .constant(BillObject.sample[0]))
       .previewDevice("iPhone 12 Pro max")
        
    }
}
