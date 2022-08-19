//
//  ContentView.swift
//  FlagGG
//
//  Created by Mac on 15.11.2021.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var countries = ["Аргентина", "Австралія", "Бразилія", "Канада", "Греція", "Індія", "Казахстан", "Монголія", "Польща", "ПАР", "Южна Корея", "САЄ", "Україна", "США", "Китай", "Франція", "Нідерланди", "Румунія", "Німеччина", "Великобританія", "Австрія", "Італія"] .shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var instruction = false
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.green, .yellow]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 20){
                    HStack{
                        Text("обери прапорець")
                            .font(.title3)
                        Text(countries[correctAnswer])
                            .font(.title3)
                            .fontWeight(.black)
                    }
                    
                    
                    ForEach(0..<3) { number in
                        Button(action: {
                            self.flagTapped(number)
                            self.showingScore = true
                        }){
                            Image(self.countries[number])
                                .renderingMode(.original)
                                .frame(width: 250, height: 128)
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.black, lineWidth: 3))
                        }
                    }
                    
                    
                    HStack(spacing: 40) {
                        Text("Рахунок: \(score)")
                            .font(.largeTitle)
                            .fontWeight(.black)
                        
                        Button(action: {
                            self.downScore()
                        }){
                            Image("arefresh")
                        }
                    }
                    
                    Spacer()
                    
                    HStack{
                        Text("важкість")
                            .font(.largeTitle)
                            .fontWeight(.black)
                        NavigationLink(destination: MidLevel(), label: {
                            Image("alevelup")
                        })
                    }
                    
                    Divider()
                    
                    HStack{
                        Button(action: {
                            self.instruction = true
                        }) {
                            Text("Правила гри")
                                .font(.system(size: 30.0))
                                .fontWeight(.light)
                            
                        }.actionSheet(isPresented: $instruction) {
                            ActionSheet(title: Text("читай правила гри"), message: Text("Обирай правильну відповідь, залежно від правильності відповіді буде змінюватись рахунок  ||  залежно від рівня важкості, рахунок працює по різному та змінюється кількість варіантів  ||  на неймовірному рівні, окрім усього вищезазначеного є таймер -> при досягненні таймером 0, рахунок зменшується на 1"), buttons: [.default(Text("зрозумів(-ла)"))])
                        }
                        
                    }
                    
                    Spacer()
                    
                    
                    
                    
                    /*ScrollView(.horizontal, showsIndicators: false, content: {
                     HStack{
                     ForEach(0..<3) { number in
                     Button(action: {
                     
                     }){
                     Image(self.countries[number])
                     .renderingMode(.original)
                     .frame(width: 220, height: 128)
                     .clipShape(Capsule())
                     .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                     }
                     }
                     }
                     })*/
                    
                    /*
                   Image("Китай")
                        .renderingMode(.original)
                        .frame(width: 250, height: 128)
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(Color.black, lineWidth: 3))
                    */
                    
                    
                }
            } .alert(isPresented: $showingScore){
                Alert(title: Text(scoreTitle), message: Text("Рахунок: \(score)"), dismissButton: .default(Text("Далі")) {
                    self.askQuestion()
                })
            }.navigationBarTitle("ЛЕГКО", displayMode: .inline)
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Правильна відповідь"
            score += 2
        } else {
            scoreTitle = "Неправильно! Це флаг \(countries[number])"
            score -= 1
        }
    }
    
    func downScore(){
        score = 0
    }
    
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
