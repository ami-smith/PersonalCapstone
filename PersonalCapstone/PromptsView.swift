//
//  PromptsView.swift
//  PersonalCapstone
//
//  Created by Ami Smith on 3/14/23.
//

import SwiftUI

struct Prompt: Identifiable, Hashable {
    let id = UUID()
    let body: String
}


struct PromptsView: View {
    @State var prompts = [
        
        Prompt(body:"Journal a list of five things that upset you today and write down why."),
        
        Prompt(body:"Sit still for a moment and journal how your body is feeling at this moment in time, use as much description as possible."),
        
        Prompt(body:"What are you afraid to speak out loud but wish people knew about you?"),
        
        Prompt(body:"What was one thing you felt proud of yourself for today?"),
        Prompt(body: "What have you learned about yourself lately?"),

        Prompt(body:"What are you struggling to get over? How are you contributing to your own experience of this issue?"),

        Prompt(body:"What are you most grateful for in your life?"),

        Prompt(body: "What do you wish was different about your life? What steps can you take to get there?"),

        Prompt(body: "What do you appreciate about your body?"),

        Prompt(body: "Who do you most admire in your life? Why?"),

        Prompt(body: "How has the pandemic positively affected your life?"),

        Prompt(body: "What do you wish you could communicate to someone else about who you are that they don’t understand?"),

        Prompt(body: "What advice would you give someone else about what matters most in life?"),

        Prompt(body: "What is one difficult reality that you have overcome? How did you do it?")
        
        
    ]
    
        var randomPrompt: Prompt {
            return prompts.randomElement() ?? Prompt(body: "No prompt available")
        }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("updatedCream").ignoresSafeArea()
                ZStack {
                    VStack {
                        Spacer()
                        Image("feelingStuck")
                            .resizable()
                            .frame(width: 375, height: 260)
                            .padding(.top, 30)
                        VStack {
                            Spacer()
                            ScrollView(.horizontal) {
                                Spacer()
                                HStack {
                                    ForEach(prompts, id: \.self) { prompt in
                                        GeometryReader { geometry in
                                            Rectangle()
                                                .fill(Color( "dustyRose"))
                                                .cornerRadius(15)
                                                .shadow(color: .gray, radius: 7, x: 0, y: 5)
                                                .rotation3DEffect(Angle(degrees: (Double(geometry.frame(in: .global).minX) - 40) / -20
                                                ), axis: (x: 0, y: 10.0, z: 0)
                                                )
                                            Text(prompt.body)
                                                .frame(width: 280, height: 300)
                                                .foregroundColor(.white)
                                                .padding(7)
                                                .font(.title)
                                                .multilineTextAlignment(.center)
                                                .rotation3DEffect(Angle(degrees: (Double(geometry.frame(in: .global).minX) - 40) / -20
                                                                       ), axis: (x: 0, y: 10.0, z: 0)
                                                )
                                                
                                        }
                                        .frame(width: 300, height: 300)
                                        .padding()
                                    }
                                    
                                }
                                .padding(26)
                                Spacer()
                            }
                            Spacer()
                           
                        }
                    }
                }
                .background(Color("updatedCream").ignoresSafeArea())
                .scrollContentBackground(.hidden)
                
               // .navigationBarTitle(Text("Prompts"))
            }
        }
    }
}

struct IndividualPromptView: View {
    let prompt: Prompt
    var body: some View {
        NavigationView {
            Text(prompt.body)
                .font(.largeTitle)
        }
        .padding()
    }
}


struct PromptsView_Previews: PreviewProvider {
    static var previews: some View {
        PromptsView()
    }
}

