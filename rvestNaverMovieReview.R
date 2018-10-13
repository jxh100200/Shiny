install.packages("rvest")
install.packages("stringi")
install.packages("XML")
install.packages("Rcpp")
install.packages("yaml")
install.packages("xml2")

library(rvest)
library(stringi)
library(XML)
library(Rcpp)
library(yaml)
library(xml2)

if("rJava" %in% installed.packages("rJava") == FALSE)install.packages("rJava")
library(rJava)
if("memoise" %in% installed.packages("memoise") == FALSE)install.packages("memoise")
library(memoise)
if("KoNLP" %in% installed.packages("KoNLP") == FALSE)install.packages("KoNLP")
library(KoNLP)
if("tm" %in% installed.packages("tm") == FALSE)install.packages("tm")
library(tm)
if("wordcloud" %in% installed.packages("wordcloud") == FALSE)install.packages("wordcloud")
library(wordcloud)
if("dplyr" %in% installed.packages("dplyr") == FALSE)install.packages("dplyr")
library(dplyr)
if("stringr" %in% installed.packages("stringr") == FALSE)install.packages("stringr")
library(stringr)
KoNLP::useSejongDic()
install.packages("wordcloud")
library(wordcloud)
library(RColorBrewer)

url_base <- "https://movie.naver.com/movie/point/af/list.nhn?st=mcode&sword=136315&target=after&page="
all.reviews <- c()
for(page in 1:20){
  url <- paste(
    url_base,
    page,
    sep = "",
    Encoding="euc-kr"
  )
  htxt <- read_html(url)
  table <- html_nodes(htxt,".list_netizen") #.을 찍는 것은 class의 의미 
  content <- html_nodes(table,".title")
  reviews <- html_text(content)
  if(length(reviews)==0){
    break;
  }

all.reviews <- c(all.reviews,reviews)
cat("\n 검색한 페이지:",page)
}

write.table(all.reviews,"review.txt")
t1 <- readLines("review.txt")
t2 <- table(t1)
t3 <- head(sort(t2,decreasing = T),30)
t3

## step 1. 데이터를 로딩한다 
txt <- readLines("review.txt")
head(txt)
## step2: 특수문자 제거 
txt <- stringr::str_replace_all(txt,"\\W"," ")
head(txt)
txt <- stringr::str_replace_all(txt,"[^[:alpha:]]"," ")

## step3: 명사만 추출 
nouns <- KoNLP::extractNoun(txt)
nouns <- sapply(txt,extractNoun,USE.NAMES = F)
class(nouns)
nouns

## step4: 단어별 빈도표 작성 
wordcount <- table(unlist(nouns))
wordcount

## step5: 데이터프레임으로 변경 
df_word <- as.data.frame(wordcount,stringsAsFactors = F)
class(df_word)

## step6: 변수명 변경 
names(df_word)
df_word <- rename(df_word,word=Var1,freg=Freq)

## step7: 두글자 이상 단어 추출 
df_word <- dplyr::filter(df_word,nchar(word)>=2)

## step8: 빈도순 정렬 후 상위 20단어만 추출 
top_20 <- df_word %>% 
  arrange(desc(freg)) %>% 
  head(20)
top_20
top_20$freg
set.seed(1234)
# gsub(찾을 것, 바꿀 것, 열 지정)


wordcloud(words = df_word$word,#단어 
          freq = df_word$freg, #빈도 
          min.freq = 20,        # 최소 단어 빈도 
          max.words = 200,     # 표현 단어 수 
          random.color = T,
          random.order = F, # 고빈도 단어 중앙 배치 
          rot.per = .1,     # 회전 잔어 비율 
          scale = c(10,0.1), # 단어 크기 범위 
          colors = brewer.pal(8,"Dark2"))     # 색상 목록 




