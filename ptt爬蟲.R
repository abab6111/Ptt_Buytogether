library("httr")
library("RCurl")
library("XML")
library('xml2')
library("rvest")
library('sendmailR')
library('RDCOMClient')
library('lubridate')

# curl <- getCurlHandle()
# curlSetOpt(cookie="over18=1", followlocation = TRUE, curl=curl)
# #18歲驗證



## init com api
OutApp <- COMCreate("Outlook.Application")
## create an email 
outMail = OutApp$CreateItem(0)
## configure  email parameter 
outMail[["To"]] = "a4505ab@gmail.com"
outMail[["subject"]] = "Got it!!!!!!!"
outMail[["body"]] = "!!!!!!!!!!!!"
## send it                     
# outMail$Send()

Nosend <- 1

repeat{
url <- 'https://www.ptt.cc/bbs/BuyTogether/index.html'
xxxx <- content(GET(url,config=set_cookies("over18"="1")))
tag = 0
#18歲驗證

# i是從零點到現在共度過幾分鐘
i <- hour(Sys.time()) * 60 + minute(Sys.time())
# i不能被2整除的話，就休息一分鐘，每分鐘起來跑才不會漏
if (i %% 2 != 0){
  print('sleep 60 seconds')
  Sys.sleep(60)
}

title <- xxxx%>%html_nodes('div>a')%>%html_text(trim = T) #成功
title <- tolower(title)
title <- title[grepl('\\[',title)]
title <- title[!grepl('公告',title)]
title <- title[!grepl('無主',title)]
title <- title[!grepl('截止',title)]
got <- grepl('music',title)
print(title)
ifelse(got==TRUE, outMail$Send() && break , print(Nosend <- Nosend+1)) #判斷有沒有關鍵字,有就寄信。

# if(Nosend==5000){
#   Sys.sleep(300)
# }

}





# # i是從零點到現在共度過幾分鐘
# i <- hour(Sys.time()) * 60 + minute(Sys.time())
# # i不能被2整除的話，就休息一分鐘，每分鐘起來跑才不會漏
# if (i %% 2 != 0) Sys.sleep(60)
# # 直接取得資料，然後轉成data.table後直接寫出

#  sendmail_options(smtpServer="ASPMX.L.GOOGLE.COM")
#  mailControl=list(smtpServer="serverinfo")
# sendmail(from="<a4505@gmail.com>", to="<a4505ab@gmail.com>", subject="Send!!!!!!", msg="word!!!!!!!!!!!",control=list(smtpServer="ASPMX.L.GOOGLE.COM"))
# 
# try(sendmail(from="<a4505ab@uldcloud.cf>", to="<a4505ab@gmail.com>", subject="Send!!!!!!", msg="word!!!!!!!!!!!",control=list(smtpServer="ASPMX.L.GOOGLE.COM")),silent=T)
# 
# 
# send.mail(from = "a4505ab@gmail.com",
#           to = "a4505ab@gmail.com",
#           subject = "Subject of the email",
#           body = "Body of the email",
#           smtp = list(host.name = "smtp.gmail.com", port = 465, user.name = "tal.galili", passwd = "PASSWORD", ssl = TRUE),
#           authenticate = TRUE,                                              #"GMAIL_ACCCOUNT"
#           send = TRUE)
# 
# from <- sprintf("<a4505ab@gmail.com>", Sys.info()[4]) 
# to <- "<a4505ab@gmail.com>" 
# subject <- "Hello from R" 
# msg <- "my first email" 
# sendmail(from, to, subject, msg,control=list(smtpServer="ASPMX.L.GOOGLE.COM")) 
# 
# 
# 
# # url <- 'https://www.ptt.cc/bbs/BuyTogether/index.html'
# # html = htmlParse(getURL(url,curl=curl,ssl.verifypeer = FALSE, encoding="UTF-8"))
# # url.list = xpathSApply(html, "//div[@class='title']/a[@href]", xmlAttrs)
# # #抓取網頁網址
# 
# 
# # 
# # url.main <- 'https://www.ptt.cc/bbs/R_Language/index.html'
# # href.title <- html_nodes(read_html(url.main), ".title a")
# # R.hrefs <- html_attr(href.title, 'href')
# # 
# # html_nodes(read_html(url.main), ".title a")
# # 
# # 
# # R.article.data <- c()
# # for(i in 1:length(R.hrefs)){
# #    article.url <- paste0('https://www.ptt.cc', R.hrefs[i])
# #    article <- html_nodes(read_html(article.url), "#main-content")
# #    article.content <- html_text(article)
# #    article.utf8 <- iconv(article.content, 'utf8')
# #    R.article.data <- c(R.article.data, article.utf8)
# #    Sys.sleep(sample(3:5, 1))
# #    }
# # R.article.data