import SwiftUI

public let seriesJsonPath = LocalPath.localFile(fibName: "SeriesesData", fibExt: "json")

struct ContentView: View
{
    @State var books:[SeriesData] = loadBooks()
    
    static func loadBooks() -> [SeriesData]
    {
        var data = SeriesData.load(path: seriesJsonPath)
        if data.count == 0
        {
            data = SeriesData.parse(json: Resource.load(fibName: "SeriesesData", fibExt: "json"))
        }
        return data
    }
    
    var body: some View
    {
        VStack
        {
            //初期値
            FirstView(thisBooks: $books[0])
        }
        .onChange(of: books)
        { books in
            SeriesData.save(path: seriesJsonPath, data: books)
        }
    }
}
