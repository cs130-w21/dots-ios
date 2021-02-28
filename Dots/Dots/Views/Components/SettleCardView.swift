import SwiftUI

struct SettleCardView: View {
    var creditor: Int
    var amount: Double
    var debtors: [(Int, Double)]
    let background: Color
    
    let diameter: Double = 20
    let minScaleFactor: CGFloat = 0.6
    var body: some View {
        
        VStack (spacing: 0) {
            HStack {
                CircleView(index: self.creditor, diameter: diameter, hasRing: false, ringStroke: 0)
                Text("+\(self.amount, specifier: "%.2f")")
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(Color.green)
                    .minimumScaleFactor(minScaleFactor)
                    .lineLimit(1)
            }
            
            Divider()
                .padding(.horizontal)
                .padding(.vertical, 10)
            
            HStack(alignment: .top, spacing: 0) {
                let numLeft = debtors.count/2 + debtors.count%2
                
                VStack(alignment: .leading) {
                    ForEach(0..<numLeft, id: \.self) { index in
                        HStack{
                            CircleView(index: self.debtors[index].0, diameter: diameter, hasRing: false, ringStroke: 0)
                            Text("-\(self.debtors[index].1, specifier: "%.2f")")
                                .font(.system(.body, design: .rounded))
                                .fontWeight(.medium)
                                .foregroundColor(Color.red)
                                .minimumScaleFactor(minScaleFactor)
                                .lineLimit(1)
                        }
                    }
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    ForEach(numLeft..<debtors.count, id: \.self) { index in
                        HStack {
                            CircleView(index: self.debtors[index].0, diameter: diameter, hasRing: false, ringStroke: 0)
//                            Text("\(self.debtors[index].0) - ")
                            Text("-\(self.debtors[index].1, specifier: "%.2f")")
                                .font(.system(.body, design: .rounded))
                                .fontWeight(.medium)
                                .foregroundColor(Color.red)
                                .minimumScaleFactor(minScaleFactor)
                                .lineLimit(1)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 16)
        .background(background)
        
    }
}

struct Settle_Previews: PreviewProvider {
    static var previews: some View {
        SettleCardView(creditor: 5, amount: 23, debtors: [(1, 2000), (3, 3), (1, 2000), (3, 3)], background: Color.gray)
    }
}
