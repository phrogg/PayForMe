//
//  OnboardingView.swift
//  iWontPayAnyway
//
//  Created by Max Tharr on 21.01.20.
//  Copyright © 2020 Mayflower GmbH. All rights reserved.
//

import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject
    var serversModel: ServerManager
    
    @State
    var serverAddress = "https://mynextcloud.org"
    
    @State
    var projectName = ""
    
    @State
    var projectPassword = ""
    
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 10) {
                Text("Hi, to get you going, please add a project").font(.headline)
                Text("Server Address")
                TextField("Enter server address", text: $serverAddress).autocapitalization(.none)
                Text("Project Name")
                TextField("Enter project name", text: $projectName).autocapitalization(.none)
                Text("Project password")
                TextField("Enter project password", text: $projectPassword).autocapitalization(.none)
                Button(action: addButton) {
                    Text("Add project")
                }
            }
            .multilineTextAlignment(.center)
            Spacer()
        }.padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
    }
    
    func addButton() {
        let project = Project(name: self.projectName, password: self.projectPassword, url: self.serverAddress)
        CospendNetworkService.instance.getMembers(project: project) {
            successful in
            if successful {
                self.serversModel.addProject(newProject: project)
            } else {
                print("Server wrong")
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView().environmentObject(ServerManager())
    }
}
