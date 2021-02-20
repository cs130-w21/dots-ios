import SwiftUI

struct SettleCardView: View {
    var creditor: Int
    var amount: Double
    var debtors: [(Int, Double)]

    var body: some View {
        ZStack {
            Color.white
            
            VStack {
                HStack {
                    CircleView(index: self.creditor, diameter: 25, hasRing: false, ringStroke: 0)
                    Text("+\(self.amount, specifier: "%.2f")")
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.medium)
                        .foregroundColor(Color.green)
                }

                Divider()

                HStack(alignment: .top) {
                    let numLeft = debtors.count/2 + debtors.count%2
                    let numRight = debtors.count/2
                    
                    VStack(alignment: .leading) {
                        ForEach(0..<numLeft) { index in
                            HStack{
                                CircleView(index: self.debtors[index].0, diameter: 25, hasRing: false, ringStroke: 0)
                                Text("-\(self.debtors[index].1, specifier: "%.2f")")
                                    .font(.system(.body, design: .rounded))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color.red)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)

                    VStack(alignment: .leading) {
                        ForEach(numLeft..<debtors.count) { index in
                            HStack {
                                CircleView(index: self.debtors[index].0, diameter: 25, hasRing: false, ringStroke: 0)
                                Text("-\(self.debtors[index].1, specifier: "%.2f")")
                                    .font(.system(.body, design: .rounded))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color.red)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding()
        }.mask(RoundedRectangle(cornerRadius: 16.0))
    }
}
