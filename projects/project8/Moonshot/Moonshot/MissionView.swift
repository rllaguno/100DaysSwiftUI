//
//  MissionView.swift
//  Moonshot
//
//  Created by Rodrigo Llaguno on 27/07/24.
//

import SwiftUI

struct MissionView: View {
    
    struct CrewMember: Hashable {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    var crew: [CrewMember]

    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                    .padding(.top)
                
                Text(mission.formattedLaunchDate != "N/A" ? "Launched in \(mission.formattedLaunchDate)" : "Mission did not launch")
                    .font(.headline)
                    .foregroundStyle(.gray)
                    .padding(.top)
                

                VStack(alignment: .leading) {
                    RectangleSeparatorView()
                    
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)

                    Text(mission.description)
                    
                    RectangleSeparatorView()
                    
                    Text("Crew Members")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                }
                .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(crew, id: \.role) { crewMember in
                            NavigationLink(value: crewMember) {
                                HStack {
                                    Image(crewMember.astronaut.id)
                                        .resizable()
                                        .frame(width: 104, height: 72)
                                        .clipShape(.circle)
                                        .overlay(
                                            Circle()
                                                .strokeBorder(.white, lineWidth: 1)
                                        )
                                    
                                    VStack(alignment: .leading) {
                                        Text(crewMember.astronaut.name)
                                            .foregroundStyle(.white)
                                            .font(.headline)
                                        
                                        Text(crewMember.role)
                                            .foregroundStyle(.gray)
                                    }
                                }
                                .padding(.horizontal)                            }
                        }
                    }
                    .navigationDestination(for: CrewMember.self) { crewMember in
                        AstronautView(astronaut: crewMember.astronaut)
                    }
                }
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
