import SwiftUI

struct DetailSettingView: View
{
    @State var titleMS:String = ""
    @State var numMS:String = ""
    @State var messageMS:String = ""
    @Binding var thisBooks: SeriesData
    @Binding var isPresentShown: Bool
    @State var seriesOrNot: Bool = true
    var noNumList: [Int]
    var nums: [Int]
    @State var num: Int = 0
    @State var reNum: Bool = false
    
    var body: some View
    {
        VStack
        {
            Picker("シリーズか詳細か", selection: $seriesOrNot)
            {
                Text("シリーズ").tag(true)
                Text("詳細").tag(false)
            }
            .pickerStyle(.segmented)
            .padding(.vertical, 25)
            
            HStack
            {
                Text("タイトル")
                .foregroundColor(Color(red:0.3, green:0.3, blue:0.3))
                Spacer()
            }
            TextField("タイトル", text: $titleMS)
            .padding(10)
            .frame(height:40)
            .border(.gray, width:0.5)
            .padding(.bottom, 15)
            
            //変わる表示内容
            HStack
            {
                Text($seriesOrNot.wrappedValue ? "番号" : "内容")
                .foregroundColor(Color(red:0.3, green:0.3, blue:0.3))
                Spacer()
            }
            if $seriesOrNot.wrappedValue == true
            {
                SeriesNumPicker(noNumList: noNumList, nums: nums, num: $num)
            }
            else
            {
                //2行にできないかな？
                TextField("内容", text : $messageMS)
                .padding(10)
                .frame(height:60)
                .border(.gray, width:0.5)
                .padding(.bottom, 20)
            }
            
            //作成ボタン
            HStack
            {
                Button
                {
                    if $seriesOrNot.wrappedValue == true
                    {
                        //num関連
                        thisBooks.datas.serieses.append(SeriesData(title: titleMS, num: num, datas: SeriesesAndDetailsData(serieses: [], details: [])))
                    }
                    else
                    {
                        //詳細
                        thisBooks.datas.details.append(DetailData(title: titleMS, message: messageMS))
                    }
                    isPresentShown = false
                }
                label:
                {
                    ZStack
                    {
                        RoundedRectangle(cornerRadius:8)
                        .frame(maxWidth:200, maxHeight:60)
                        .foregroundColor(.teal)
                        .shadow(radius: 3)
                        .padding(.vertical, 25)
                        Text($seriesOrNot.wrappedValue ? "シリーズ作成" : "詳細作成")
                        .font(.title2)
                        .foregroundColor(.white)
                    }
                }
            }
        }
        .padding(40)
    }
}
