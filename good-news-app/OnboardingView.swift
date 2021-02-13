//
//  OnboardingView.swift
//  good-news-app
//
//  Created by Arpan Dhatt on 2/12/21.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        if viewModel.onboardingPage == "1"{
            OnboardingIntroView()
        }
        if viewModel.onboardingPage == "2"{
            withAnimation{
            OnboardingNameView()
            }
        }
        if viewModel.onboardingPage == "3"{
            OnboardingSourcesView()
        }
    }
}

struct OnboardingSourcesView: View{
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View{
        VStack{
            ScrollView{
            HStack{
                Text("Almost Done!").font(.title2).bold()
                Spacer()
            }.padding()
            
            VStack{
            HStack{
                Text("Selected Some Prefered News Networks").font(.title).bold().padding()
                Spacer()
            }
                Divider()
            StringListModifierView(choices: ["Default", "NY Times", "BBC", "Washington Post", "Time", "Aljazeera", "NPR", "LA Times"], choice: .sources)
            }.font(.headline).background(Color("purple1")).cornerRadius(10.0).foregroundColor(.white).padding()
            }
            
            HStack{
                Button(action: {
                    withAnimation{
                    viewModel.onboardingPage = "2"
                    }
                }){
                    HStack{
                    Image(systemName: "arrow.left").font(.body)
                    Text("Back").font(.body)
                    }.padding().background(Color("red1")).foregroundColor(Color.white).cornerRadius(5.0)
                }
                Spacer()
                Button(action: {
                    withAnimation {
                    viewModel.onboarding = false
                    viewModel.onboardingPage = "1"
                    }
                }){
                    HStack{
                    Text("Ready?").font(.body)
                        Image(systemName: "arrow.right").font(.body)
                    }.padding().background(Color("red1")).foregroundColor(Color.white).cornerRadius(5.0)
                }
                
            }.padding()
        }
    }
}

struct OnboardingNameView: View{
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View{
        VStack{
            HStack{
                Text("We Just Need a Bit of Information to Personalize Your Experience...").font(.title2)
                Spacer()
            }.padding()
            VStack{
                HStack{
                    Text("Name:").font(.title2).bold()
                    Spacer()
                    Image(systemName: "pencil.circle.fill").font(.title)
                }.padding([.top,.leading, .trailing])
                Divider()
                TextField("", text: $viewModel.user.name).padding([.bottom,.leading, .trailing])
                VStack{
                HStack{
                    Text("Select Categories").font(.title2).bold().padding()
                    Spacer()
                }
                    Divider()
                StringListModifierView(choices: ["World","Business","SciTech", "Sports"], choice: .categories)
                }.font(.headline).background(Color("yellow1")).cornerRadius(10.0).foregroundColor(.black).padding()
                
            }.background(Color("blue1")).cornerRadius(10.0).foregroundColor(.white).padding()
            
            HStack{
                Button(action: {
                    withAnimation {
                    viewModel.onboardingPage = "1"
                    }
                }){
                    HStack{
                    Image(systemName: "arrow.left").font(.body)
                    Text("Back").font(.body)
                    }.padding().background(Color("red1")).foregroundColor(Color.white).cornerRadius(5.0)
                }
                Spacer()
                Button(action: {
                    withAnimation {
                    viewModel.onboardingPage = "3"
                    }
                }){
                    HStack{
                    Text("Next").font(.body)
                        Image(systemName: "arrow.right").font(.body)
                    }.padding().background(Color("red1")).foregroundColor(Color.white).cornerRadius(5.0)
                }
                
            }.padding()
        }
    }
}

struct OnboardingIntroView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View{
        VStack{
            Spacer()
            HStack{
                Text("Welcome To GoodNewz").font(.title).bold()
                Spacer()
            }.padding(.vertical)
            HStack{
            Text("Most news is negative, which not only gives people a warped understanding of reality, but it also makes them sad and depressed").font(.headline).padding(.vertical)
                Spacer()
            }
            HStack{
            Text("Which is where GoodNews comes in...").font(.subheadline).padding(.vertical)
                Spacer()
            }
            HStack{
            Text("A personalized news site with the postive stories of the world").font(.headline).padding(.vertical)
                Spacer()
            }
            Spacer()
            HStack{
                Spacer()
                Button(action: {
                    withAnimation{
                    viewModel.onboardingPage = "2"
                    }
                }){
                    HStack{
                    Text("Get Started").font(.body)
                        Image(systemName: "arrow.right").font(.body)
                    }.padding().background(Color("red1")).foregroundColor(Color.white).cornerRadius(5.0)
                }
                
            }
            Spacer()
        }.padding()
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView().environmentObject(ViewModel())
    }
}
