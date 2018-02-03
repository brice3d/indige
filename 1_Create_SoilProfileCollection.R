# following https://r-forge.r-project.org/scm/viewvc.php/*checkout*/docs/aqp/aqp-intro.html?root=aqp
setwd("C:/Users/Brice/SWITCHdrive/PhD_Namibia/Publications/IndigenousSoilKnowledge/Supplement/Soils") ## in the office

data=read.csv("Results_soils.csv")

####################################################
######## Select profiles to use for general analysis of IK
######## remove uncultivated area

levels=levels(as.factor(data$Profile))

profile_sel=c("NDOB_01","NDOB_02","NDOB_03","NDOB_08","NDOB_12","NDOB_13","NDOB_14","NDOB_15",
              "NDOB_16","NDOB_17","NDOB_18","NDOB_19","NDOB_20","EFIDI_01","EFIDI_02","EFIDI_04",
              "EFIDI_05","EFIDI_06","ETOPE_01","OHNG_01",  "OILYA_01", "OILYA_02", "OILYA_04",
              "EKOL_01","NGYO_01","HNDIB_01","HNDIB_02","OMDI_01","OMDI_02","OMDI_03")

df=data.frame()
for(i in 1:length(profile_sel)){
        x=data[data$Profile==profile_sel[i]&!is.na(data$Profile),]
        df=rbind(df,x)
}

data<-df

# install.packages("aqp") ### install package in which function munsell2rgb() is found
library(aqp)

color <- munsell2rgb(the_hue=data$Color_hue, 
                     the_value=data$color_value, 
                     the_chroma=data$color_chroma, 
                     return_triplets=TRUE)

data=cbind(data,color)

################## Create Soil Profile collection
# following https://r-forge.r-project.org/scm/viewvc.php/*checkout*/docs/aqp/aqp-intro.html?root=aqp

# load required packages, you may have to install these if missing:
library(aqp)
library(Hmisc)
library(lattice)
library(MASS)
library(soilprofile)

depths(data) <- Profile ~ depth.min + depth.max
site(data)  # get or set site dataLab
data$thickness <- data$depth.max - data$depth.min # horizon-level
h <- horizons(data)
s <- site(data)
s$groups=c("Ehenene","Ehenge","Omutunda","Omutunda","Omutunda","Elondo","Omutunda",
           "Omufitu","Omufitu","Ehenene", "Omutunda","Omufitu","Omutunda",
           "Ehenge","Omutunda","Omutunda","Omutunda","Omutunda","Ehenene","Ehenge","Omufitu",
           "Omutunda","Elondo","Omutunda","Ehenge","Omutunda","Omutunda","Omutunda","Elondo")
s$area=c(rep("Ondobe",4),"Ekolola","Ondobe","Ekolola","Ekolola",rep("Ondobe",13),"Ekolola",rep("Ondobe",4),rep("Omhedi",3))
site(data) <- s