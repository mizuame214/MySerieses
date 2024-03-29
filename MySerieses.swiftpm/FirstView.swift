import SwiftUI

struct FirstView: View
{
    @State var editMode: Bool = false
    @Binding var thisBooks: SeriesData
    @Binding var upBooks: SeriesData
    //@State var editMode: EditMode = .inactive
    
    //苦し紛れ
    @State var fibDetailData: DetailData = DetailData(title: "仮", message: "仮")
    @State var fibSeriesData: SeriesData = SeriesData(title: "仮", num: 0, datas: SeriesesAndDetailsData(serieses: [], details: []))
    
    var body: some View
    {
        ZStack
        {
            ScrollView
            {
                //詳細部分の表示
                Section
                {
                    VStack(spacing: 0)
                    {
                        ForEach($thisBooks.datas.details)
                        { detail in
                            InfoView(title: detail.title.wrappedValue, mainText: detail.message.wrappedValue)
                            .padding(.bottom, 12)
                        }
                    }
                }
                //シリーズ部分の表示
                Section
                {
                    VStack(spacing: 0)
                    {
                        ForEach($thisBooks.datas.serieses)
                        { series in
                            NavigationLink( destination:
                            {
                                FirstView(thisBooks: series, upBooks: $thisBooks)
                            },
                            label:
                            {
                                AList(data: series.wrappedValue, edit: false, thisBooks: $thisBooks, color: .white)
                                .foregroundColor(.black)
                            })
                            .padding(.bottom, 12)
                        }
                    }
                }
                .padding(.top, 12)
            }
            .onAppear
            {
                //データ削除
                //SeriesData.clear(path: seriesJsonPath)
            }
            .onChange(of: thisBooks)
            { thisBooks in
                self.thisBooks.datas.serieses = thisBooks.datas.serieses.sorted { $0.num < $1.num }
            }
            .padding(.top, 12)
            .padding(.horizontal, 20)
            .navigationTitle(thisBooks.title)
            
            //編集モード用
            .navigationBarItems(trailing:
                NavigationLink(
                    destination:
                        {
                            EditView(thisBooks: $thisBooks, upBooks: $upBooks, detailData: $fibDetailData, seriesData: $fibSeriesData, dragData: $fibSeriesData)
                        },
                        label:
                        {
                            Image.init(systemName: "square.and.pencil")
                            .foregroundColor(.teal)
                        }
                )
            )
            //.environment(\.editMode, self.$editMode)
            
            PlusButton(thisBooks: $thisBooks)
        }
    }
}

