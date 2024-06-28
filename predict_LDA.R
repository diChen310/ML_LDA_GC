library(purrr)
library(vctrs)
library(vctrs)
library(rlang)
library(tibble)
library(tidyselect)
library(caret)


setwd('~/GC')


####Read the best model
lda.mod = readRds('./bestLDA.Rds')
####The input features
input.items = colnames(lda.mod$trainingData)[-1]



####prediction for the other datasets, new.idt
#rownames(new.idt)=new.idt$name
#idt.data = new.idt[,c(-1,-2,-3,-4)]
####
idt.data = log2(as.matrix(idt.data))+5
idt.data = scale(idt.data)
ind.y = predict(lda.mod,idt.data[,input.items],type = 'prob')
table(factor(new.idt$sampleType),factor(ifelse(ind.y[,2]>0.5,'P','N')))
tt=table(factor(new.idt$sampleType),factor(ifelse(ind.y[,2]>0.5,'P','N')))
####ROC for the prediction results
roc.res.ind.3 = roc(response = new.idt$sampleType,
                    predictor = ind.y[,2],
                    levels = unique(new.idt$sampleType))


