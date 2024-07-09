import SwiftUI

struct HomeView: View {
    let viewFactory = ViewFactory(dependencies: Dependencies.shared)
    
    var viewModel: HomeViewModel
    
    @State private var isActionButtonDisabled = true
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
            VStack {
                List {
                    Section {
                        viewFactory.selectionView { type in
                            viewModel.startSimulation(for: type)
                        }
                    }
                }.frame(maxHeight: 44).padding(.all, 0).padding(.top, 16)
                
                VStack {
                    viewFactory.gridView()
                    Spacer()
                }
                Spacer()
                
                CustomToolBar(isActionButtonDisabled: isActionButtonDisabled,
                              startSimulation: { viewModel.startSimulation(for: viewModel.getType)
                },
                              clearSimulation: { viewModel.clearSimulation()
                },
                              clearGrid: {
                    viewModel.clearGrid()
                },
                              algorithm: viewModel.algorithm,
                              nodeSelection: viewModel.nodeSelection)
            }
            .navigationTitle("Grafo")
            .navigationBarItems(
                trailing: HStack {
                    Spacer()
                    AboutButton().padding(.horizontal, 12)
                    QuestionButton()
                }
            )
          //  .background(colorScheme == .light ? .secondary : .tertiary)
            .background(.background.secondary)
            .onChange(of: viewModel.getType, perform: { _ in
                isActionButtonDisabled = viewModel.getType == .none
            })
            .accentColor(.blue)
        }
}

#Preview {
    HomeView(viewModel: HomeViewModel(algorithm: AlgorithmModel(), nodeSelection: NodeSelection()))
}

