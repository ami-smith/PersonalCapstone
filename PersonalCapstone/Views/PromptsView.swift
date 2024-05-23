//
//  PromptsView.swift
//  PersonalCapstone
//
//  Created by Ami Smith on 3/14/23.
//

import SwiftUI
import CoreData

struct Prompt: Identifiable, Hashable {
    let id = UUID()
    let body: String
}


struct PromptsView: View {
    @State var prompts = [
        Prompt(body: "Write 5 affirmations for when you are feeling low."),
        Prompt(body: "What is the best book you have read recently?"),
        Prompt(body: "How have you grown this year?"),
        Prompt(body: "What are the most important life lessons you have learned?"),
        Prompt(body: "Have trouble sleeping? What’s keeping you up?"),
        Prompt(body: "What is the last dream you remember?"),
        Prompt(body: "Name the three biggest priorities in your life right now."),
        Prompt(body: "What are your biggest fears?"),
        Prompt(body: "Do you have a fear that is stopping you from achieving your goals?"),
        Prompt(body: "Name three challenges…. and three ways to overcome them."),
        Prompt(body: "Write down your ultimate way to relax."),
        Prompt(body: "What would you do if you were granted three wishes?"),
        Prompt(body: "Name three bad habits you would like to change."),
        Prompt(body: "What was the last show you went to?"),
        Prompt(body: "Do you have a secret talent you are hiding?"),
        Prompt(body: "Add some more items to your bucket list…if you don’t have a bucket list, start one."),
        Prompt(body: "What is your biggest regret?"),
        Prompt(body: "Think about someone you really love. Write about the person that came to mind."),
        Prompt(body: "List the best 10 moments of your life so far."),
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
        Prompt(body: "What is one difficult reality that you have overcome? How did you do it?"),
        Prompt(body: "Who is your best friend, and what do you love about them?"),
        Prompt(body: "When do you feel the happiest and most content?"),
        Prompt(body: "WWhat's your favorite thing about yourself?"),
        Prompt(body: "If you could improve your life in one way today, what would you do?")
    ]
    
        var randomPrompt: Prompt {
            return prompts.randomElement() ?? Prompt(body: "No prompt available")
        }
    let colors: [Color] = [Color("fuchsia"), Color("roseRed"), Color("dustyRose"), Color("lilac"), Color("purpleHaze")]
    
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
                                    ForEach(prompts.indices, id: \.self) { index in
                                        let colorIndex = index % colors.count
                                        let color = colors[colorIndex]
                                        GeometryReader { geometry in
                                            Rectangle()
                                                .fill(color)
                                                .cornerRadius(15)
                                                .shadow(color: .gray, radius: 7, x: 0, y: 5)
                                                .rotation3DEffect(Angle(degrees: (Double(geometry.frame(in: .global).minX) - 40) / -20), axis: (x: 0, y: 10.0, z: 0)
                                                                 )
                                            NavigationLink(destination: NewJournalEntryView()) {

                                                Text(prompts[index].body)
                                                    .frame(width: 280, height: 300)
                                                    .foregroundColor(.white)
                                                    .padding(7)
                                                    .font(.title)
                                                    .multilineTextAlignment(.center)
                                                    .rotation3DEffect(Angle(degrees: (Double(geometry.frame(in: .global).minX) - 40) / -20), axis: (x: 0, y: 10.0, z: 0)
                                                    )
                                            }
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

