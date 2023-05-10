import SwiftUI

struct EditView: View
{
    @Binding var thisBooks: SeriesData
    var seriesList: [SeriesData]
    
    @State var editMode: EditMode = .active
    @State var isPre: Bool
    
    //戻るボタンのカスタム
    @Environment(\.dismiss) var dismiss
    
    var body: some View
    {
        ZStack
        {
            List
            {
                //詳細部分の表示
                Section
                {
                    ForEach($thisBooks.datas.details)
                    { detail in
                        EditInfoView(title: detail.title, mainText: detail.message)
                    }
                    .onMove
                    { from, to in
                        thisBooks.datas.details.move(fromOffsets: from, toOffset: to)
                    }
                    .onDelete
                    { indexSet in
                        //できてるっぽい
                        thisBooks.datas.details.remove(atOffsets: indexSet)
                    }
                }
                //シリーズ部分の表示
                Section
                {
                    ForEach(seriesList)
                    { series in
                        Button
                        {
                            isPre = true
                        }
                        label:
                        {
                            AList(data: series)
                        }
                        .sheet(isPresented: $isPre)
                        {
                            //一つ一つリストの編集画面
                        }
                    }
                    .onMove
                    { from, to in
                        //thisBooks.datas.serieses.move(fromOffsets: from, toOffset: to)
                        //移動前のシリーズを取得できないぴえ
                        //thisBooks.datas.serieses[1].num = to
                    }
                    .onDelete
                    { indexSet in
                        //消すのはいいんだけど、numをどうにかしないといけないから単純に消せない
                        thisBooks.datas.serieses.remove(atOffsets: indexSet)
                        //seriesList.remove(atOffsets: indexSet)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle(thisBooks.title)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(trailing:
                Button( action:
                {
                    dismiss()
                    //ここで再登録？できればいいかもな。消した時はリストから番号を消して、入れ替えは上から順にリストの番号を当てはめていく
                },
                label:
                {
                    Image(systemName: "checkmark")
                })
            )
            .environment(\.editMode, self.$editMode)
            //*/
        }
    }
}
