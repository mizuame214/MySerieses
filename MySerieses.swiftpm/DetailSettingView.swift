import SwiftUI

struct DetailSettingView: View {
    @State var titleMS:String = ""
    @State var numMS:String = ""
    @State var messageMS:String = ""
    @Binding var thisBooks: SeriesData
    @Binding var isPresentShown: Bool
    @State var seriesOrNot: Bool = true
    var noNumList: [Int]
    var lastNum: Int
    @State var num: Int = 0
    
    func blackOrGray(fibI: Int) -> Bool
    {
        for nnl in noNumList
        {
            if fibI == nnl || lastNum < fibI
            {
                return true
            }
        }
        return false
    }
    
    var body: some View {
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
                Picker("番号", selection: $num)
                {
                    let numMinusTwo: Int = num-2 > 0 ? num-2 : 1
                    ForEach(numMinusTwo ... num+2, id:\.self)
                    { i in
                        Text(String(i))
                        .foregroundColor(blackOrGray(fibI: i) ? .black : Color(red: 0.8, green: 0.8, blue: 0.8))
                    }
                }
                .pickerStyle(.wheel)
                //上の方押すと勝手に回っちゃう
                .frame(height: 60)
                //機能しないらしい.compositingGroup()
                .clipped()
                .onAppear()
                {
                    num = lastNum + 1
                }
            }
            else
            {
                TextField("内容", text : $messageMS)
                .padding(10)
                .frame(height:40)
                .border(.gray, width:0.5)
            }
            
            //ボタン
            HStack
            {
                Button
                {
                    if $seriesOrNot.wrappedValue == true
                    {
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
                        .frame(maxWidth:.infinity, maxHeight:60)
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
