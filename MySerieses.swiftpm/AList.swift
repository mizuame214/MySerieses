import SwiftUI

//画面のうちのシリーズ部分１個の表示
struct AList: View
{
    var data: SeriesData
    var edit: Bool
    
    var body: some View
    {
        let nums = numberSort(fibData: data)
        let noNumList = makeNoNumList(fibNums: nums, plus: false)
        
        VStack
        {
            HStack
            {
                if(edit)
                {
                    //巻数の表示
                    Text(String(data.num))
                    .font(.system(size:15))
                    .foregroundColor(Color(.sRGB, red:1.0, green:0.2, blue:0.2, opacity:1.0))
                    .padding(.trailing, 10)
                }
                
                Text(data.title)
                .font(.system(size:15))
                .lineLimit(1)
                
                if(noNumList != [] && edit == false)
                {
                    Circle()
                    .foregroundColor(.pink)
                    .frame(width: 15, height: 15, alignment: .leading)
                    .padding(.horizontal, 2)
                }
            }
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 10)
    }
}
