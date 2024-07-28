import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    @State private var isGridView: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if isGridView {
                    gridView
                } else {
                    listView
                }
            }
            .navigationTitle("Moonshot")
            .background(Color.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button(action: toggleView) {
                    Label("Switch View", systemImage: "arrow.triangle.2.circlepath")
                }
            }
        }
    }
    
    private var gridView: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink{
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        missionCard(mission: mission)
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
    
    private var listView: some View {
        List {
            ForEach(missions) { mission in
                NavigationLink{
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    missionCard(mission: mission)
                }
            }
        }
        .listStyle(.plain)
        .listRowBackground(Color.darkBackground)
    }
    
    private func missionCard(mission: Mission) -> some View {
        VStack {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()
            
            VStack {
                Text(mission.displayName)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(mission.formattedLaunchDate)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(Color.lightBackground)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.lightBackground)
        )
    }
    
    private func toggleView() {
        isGridView.toggle()
    }
}

#Preview {
    ContentView()
}
