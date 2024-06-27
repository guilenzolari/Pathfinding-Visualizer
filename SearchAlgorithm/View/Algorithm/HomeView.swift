import SwiftUI

struct HomeView: View {
    let viewFactory = ViewFactory(dependencies: Dependencies.shared)
    
    var viewModel: HomeViewModel
    
    @State private var isActionButtonDisabled = true
    
    var body: some View {
        VStack {
            List {
                Section {
                    viewFactory.selectionView()
                }
                Section {
                        viewFactory.gridView()
                }
            }.navigationTitle("Grafo")
                .navigationBarItems(
                leading: AboutButton(),
                trailing: QuestionButton()
                )
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        Button(action: {
                        }) {
                            Image(systemName: "play.circle")
                                .frame(width: 26, height: 22)
                        }.disabled(isActionButtonDisabled)
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.clearSimulation()
                        }) {
                            Image(systemName: "eraser")
                                .frame(width: 26, height: 22)
                        }.disabled(isActionButtonDisabled)
                    }
                    
                }
        }.toolbarBackground(.red)
        .background(.background.secondary)
        .onChange(of: viewModel.getType, {
            isActionButtonDisabled = viewModel.getType == .none
        })
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(algorithm: AlgorithmModel()))
}
