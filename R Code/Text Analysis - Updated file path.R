
#Install relevenat packages
install.packages("tm")
library(tm)

#Give some more information on the tm package
#??tm

#Read text file into R
TagLog_txt <- VCorpus(DirSource("H:/R/Text")) #Make sure you just read the folder path in (must only contain one text file)

#Convert to lower case
TagLog_txt2 <- tm_map(TagLog_txt, content_transformer(tolower))

#Remove punctuations
TagLog_txt3 <- tm_map(TagLog_txt2, removePunctuation)

#Remove stopwords
TagLog_txt4 <- tm_map(TagLog_txt3, removeWords, stopwords())


#Generate TF-IDF matrix
TagLog_dtm <- DocumentTermMatrix(TagLog_txt4)

#Inspect to TF-IDF
inspect(TagLog_dtm)

#Generate a frequency data frame
word_frequency <- sort(colSums(as.matrix(TagLog_dtm)),
                       decreasing=TRUE)
df_frequency<- data.frame(word = names(word_frequency),
                          freq=word_frequency)

head(df_frequency)


#--------------------------------------------------------------------------
#                  Displaying the Word Cloud
#--------------------------------------------------------------------------

#Install Relevant Pacakge
install.packages("wordcloud")
library(wordcloud)

#Simple wordcloud
wordcloud(df_frequency$word,
          df_frequency$freq)



#Top 10 words
wordcloud(df_frequency$word,
          df_frequency$freq,
          max.words=10, min.freq = 1)

#--------------------------------------------------------------------------
#                  Enhancing the Word Cloud
#--------------------------------------------------------------------------

#Choose a specific font and order
wordcloud(df_frequency$word,
          df_frequency$freq,
          max.words=10, min.freq = 1,
          random.order=FALSE,
          family = "Helvatica", font = 3)

#Using a color palatte

library(RColorBrewer)

word_pal <- brewer.pal(10,"Dark2")

wordcloud(df_frequency$word,
          df_frequency$freq,
          max.words=20, min.freq = 1,
          random.order=FALSE,
          colors=word_pal, font = 3)





