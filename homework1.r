setwd("C:/Users/asus/Desktop/")
data<-read_excel("q.xlsx",col_names = T)
women<-data[(data$fe=="F"),]
men<-data[(data$fe=="M"),]
women_1<-women[(women$stu_year=="19"|women$stu_year=="20"|women$stu_year=="21"),]
women_2<-women[(women$stu_year=="22"|women$stu_year=="23"|women$stu_year=="24"),]
women_3<-women[(women$stu_year=="25"|women$stu_year=="26"|women$stu_year=="27"),]
women_4<-women[(women$stu_year=="28"|women$stu_year=="29"|women$stu_year=="30"|women$stu_year=="31"),]
men_1<-men[(men$stu_year=="19"|men$stu_year=="20"|men$stu_year=="21"),]
men_2<-men[(men$stu_year=="22"|men$stu_year=="23"|men$stu_year=="24"),]
men_3<-men[(men$stu_year=="25"|men$stu_year=="26"|men$stu_year=="27"),]
men_4<-men[(men$stu_year=="28"|men$stu_year=="29"|men$stu_year=="30"|men$stu_year=="31"),]
Group<-c(rep("women",139),rep("men",100))
Group <- factor(Group)
treatment <-c(rep("19-21",26),rep("22-24",104),rep("25-27",5),rep("28-31",4),
              rep("19-21",12),rep("22-24",83),rep("25-27",5),rep("28-31",0))
treatment<-factor(treatment)
Data_self<-data.frame(Group=Group,treatment=treatment,
                      value=c(women_1$predict_year,women_2$predict_year,women_3$predict_year,
                      women_4$predict_year,men_1$predict_year,men_2$predict_year,
                      men_3$predict_year,men_4$predict_year))

ggplot(Data_self, aes(x=Group, y=Data_self$value,fill=Group)) + 
  geom_boxplot(color="black",size=0.5,width=0.5) + 
  #scale_fill_manual(values = c("firebrick2", "palegreen3"))+ #设置填充的颜色
  theme_bw()+ #背景变为白色
  theme(axis.text.x=element_text(angle=15,hjust = 1,colour="black",family="Times",size=12), #设置x轴刻度标签的字体显示倾斜角度为15度，并向下调整1(hjust = 1)，字体簇为Times大小为20
        axis.text.y=element_text(family="Times",size=15,face="plain"), #设置y轴刻度标签的字体簇，字体大小，字体样式为plain
        axis.title.y=element_text(family="Times",size = 15,face="plain"), #设置y轴标题的字体属性
        axis.title.x=element_text(family="Times",size = 20,face="plain"),
        panel.border = element_blank(),axis.line = element_line(colour = "black",size=1), #去除默认填充的灰色，并将x=0轴和y=0轴加粗显示(size=1)
        legend.text=element_text(face="italic", family="Times", colour="black",  #设置图例的子标题的字体属性
                                 size=15),
        legend.title=element_text(face="italic", family="Times", colour="black", #设置图例的总标题的字体属性
                                  size=15),
        panel.grid.major = element_blank(),   #不显示网格线
        panel.grid.minor = element_blank())+  #不显示网格线
  ylab("predict teacher's age")+xlab("") #设置x轴和y轴的标题
t.test(women$predict_year,men$predict_year)
t.test(women_1$predict_year,women_3$predict_year)
t.test(men_1$predict_year,men_4$predict_year)
