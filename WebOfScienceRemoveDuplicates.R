closeAllConnections()
rm(list=ls())
graphics.off()

setwd("C:/Users/sacha/OneDrive - University of Victoria/GroMoPo/WebOfScience_Results") #Set the working directory


library(readxl)

# List all files
files = dir(pattern = "savedrecs*")

#Loop through files and concatenate the rows
allResults = data.frame()
for (it in 1:length(files)){
  res<-read_excel(files[it])
  allResults<-rbind(allResults,res)
}

#Subset the columns of interest
allResults<-allResults[,c("Publication Type","Authors","Article Title",
                          "Source Title","Language","Cited Reference Count",
                          "Times Cited, WoS Core","Times Cited, All Databases",
                          "Since 2013 Usage Count","Journal ISO Abbreviation",
                          "Publication Date","Publication Year","Volume",
                          "Issue","Start Page","End Page","Number of Pages", 
                          "Article Number", "DOI","Book DOI","Addresses")]

# Make a DOI link
allResults$Link<-paste("https://doi.org/",allResults$DOI,sep="")

#Exclude results without a DOI
allResults<-allResults[!is.na(allResults$DOI),]

#Remove duplicated results
allResults<-allResults[!duplicated(allResults$DOI),]

#Write a csv file
write.csv(allResults,file="Unique Files.csv")
