using Printf

# Load X and y variable
using JLD
X = load("citiesSmall.jld","X")
y = load("citiesSmall.jld","y")
n = size(X,1)

trainErrors = []
testErrors = []


include("decisionTree_infoGain.jl")
# Train model from 1 to 15 depth
for depth in 1:15
    model = decisionTree_infoGain(X,y,depth)

    # Evaluate the training error
    yhat = model.predict(X)
    trainError = sum(yhat .!= y)/n
    # @printf("Train error with depth-%d decision tree: %.3f\n",depth,trainError)
    push!(trainErrors, trainError)

    # Evaluate the test error
    Xtest = load("citiesSmall.jld","Xtest")
    ytest = load("citiesSmall.jld","ytest")
    t = size(Xtest,1)
    yhat = model.predict(Xtest)
    testError = sum(yhat .!= ytest)/t
    # @printf("Test error with depth-%d decision tree: %.3f\n",depth,testError)
    push!(testErrors, testError)
end


using Plots
plot(1:15, trainErrors, label="Train Error")
plot!(1:15, testErrors, label="Test Error")
title!("Train and Test Error vs. Depth")
xlabel!("Depth")
ylabel!("Error")


# @show(trainErrors)
# @show(testErrors)

# # Train a depth-2 decision tree
# depth = 2
# include("decisionTree_infoGain.jl")
# model = decisionTree_infoGain(X,y,depth)

# # Evaluate the training error
# yhat = model.predict(X)
# trainError = sum(yhat .!= y)/n
# @printf("Train error with depth-%d decision tree: %.3f\n",depth,trainError)

# # Evaluate the test error
# Xtest = load("citiesSmall.jld","Xtest")
# ytest = load("citiesSmall.jld","ytest")
# t = size(Xtest,1)
# yhat = model.predict(Xtest)
# testError = sum(yhat .!= ytest)/t
# @printf("Test error with depth-%d decision tree: %.3f\n",depth,testError)