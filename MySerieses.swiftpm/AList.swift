import SwiftUI

//画面のうちのシリーズ部分１個の表示
struct AList: View
{
    let data: SeriesData
    let edit: Bool
    
    @Binding var thisBooks: SeriesData
    
    let color: Color
    
    var body: some View
    {
        let noNumList = makeNoNumList(fibData: data, plus: false)
        
        ZStack
        {
            RoundedRectangle(cornerRadius: 10)
            .frame(height: 60)
            .foregroundColor(color)
            
            HStack
            {
                if(edit)
                {
                    //巻数の表示
                    Text(String(data.num))
                    .font(.system(size:15))
                    .foregroundColor(.pink)
                    .padding(.trailing, 10)
                }
                
                Text(data.title)
                .font(.system(size:16))
                .lineLimit(1)
                
                if(noNumList != [] && edit == false)
                {
                    Circle()
                    .foregroundColor(.pink)
                    .frame(width: 15, height: 15, alignment: .leading)
                    .padding(.horizontal, 2)
                }
                Spacer()
                
                if(edit == false)
                {
                    Text(">")
                    .font(.system(size:16))
                    .foregroundColor(.gray)
                }
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 15)
            .background(
                RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 1)
            )
        }
    }
}
