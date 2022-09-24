# clean, combine, and subset LEMAS data

# CONCERNS:
# 2007 data "NATHAW" contains other pacific islander, 2013 "PERS_FTS_HAW" only contains Hawaiian

# setup ###

library(expss)

# LEMAS locations
# 2000
.lemas_2000_loc = "./data/LEMAS/RAW/2000/DS0001/03565-0001-Data.tsv"
# 2003
.lemas_2003_loc = "./data/LEMAS/RAW/2003/DS0001/04411-0001-Data.por"
# 2007
.lemas_2007_loc = "./data/LEMAS/RAW/2007/31161-0001-Data.tsv"
# 2013
.lemas_2013_loc = "./data/LEMAS/RAW/2013/36164-0001-Data.tsv"
# 2016
.lemas_2016_loc = "./data/LEMAS/RAW/2016/37323-0001-Data.tsv"

# data load ####
lemas_2000 = read.csv(.lemas_2000_loc, sep = "\t", header = TRUE, stringsAsFactors = FALSE)
lemas_2003 = haven::read_por(.lemas_2003_loc)
lemas_2007 = read.csv(.lemas_2007_loc, sep = "\t", header = TRUE, stringsAsFactors = FALSE)
lemas_2013 = read.csv(.lemas_2013_loc, sep = "\t", header = TRUE, stringsAsFactors = FALSE)
lemas_2016 = read.csv(.lemas_2016_loc, sep = "\t", header = TRUE, stringsAsFactors = FALSE)

# clean 2000 data ####

# match dataframe with other years
lemas_2000 = data.frame('year' = 2000,
                        "AGENCY" = lemas_2000$V7,
                        "CITY" = lemas_2000$V8,
                        "STATE" = lemas_2000$V1,
                        "ZIP" = NA,
                        'TYPE' = lemas_2000$V13,
                        "COUNTY" = lemas_2000$V12,
                        'FTSWORN' = lemas_2000$V66,
                        'PTSWORN' = lemas_2000$V67,
                        'FTCIV'  = lemas_2000$V70,
                        'PTCIV' = lemas_2000$V71,
                        'FTDRUGOFF' = NA,
                        'PTDRUGOFF' = NA,
                        'IMPDRUGTASK' = NA,
                        'OPBUDGET' = lemas_2000$V82,
                        'OPBUDGEST' = NA,
                        'IMPBUDGET' = NA,
                        "ASSETFOR" = lemas_2000$V84,
                        'ASFOREST' = NA,
                        'WHITE' = lemas_2000$V108 + lemas_2000$V109,
                        'BLACK' = lemas_2000$V110 + lemas_2000$V111,
                        'HISPANIC' = lemas_2000$V112 + lemas_2000$V113,
                        'ASIAN' = lemas_2000$V116 + lemas_2000$V117,
                        'NATHAW' = lemas_2000$V118 + lemas_2000$V119,
                        'AMERIND' = lemas_2000$V114 + lemas_2000$V115,
                        'MULTRACE' = NA,
                        'UNKRACE' = NA,
                        'IMPRACE' = NA,
                        'MALE' = lemas_2000$V122,
                        'FEMALE' = lemas_2000$V123,
                        'IMPGENDER' = NA,
                        'CHIEFMIN' = lemas_2000$V132,
                        'IMPCHFMIN' = NA,
                        'CHIEFMAX' = lemas_2000$V133,
                        'IMPCHFMAX' = NA,
                        'SGTMIN' = lemas_2000$V134,
                        'IMPSGTMIN' = NA,
                        'SGTMAX' = lemas_2000$V135,
                        'IMPSGTMAX' = NA,
                        'ENTRYMIN' = lemas_2000$V136,
                        'IMPENTRYMIN' = NA,
                        'ENTRYMAX' = lemas_2000$V137,
                        'IMPENTRYMAX' = NA,
                        'BDGT_SRC_ASST' = NA,
                        'PERS_PDSW_MPT' = NA,
                        'PERS_PDSW_FPT' = NA,
                        stringsAsFactors = FALSE)

# subset only california
lemas_2000 = lemas_2000[lemas_2000$STATE == 5, ]
lemas_2000$STATE = "CA"

# rename agency types
# TYPE
lemas_2000$TYPE[lemas_2000$TYPE == 1] =  "Sheriff"
lemas_2000$TYPE[lemas_2000$TYPE == 3] =  "Local police"
lemas_2000$TYPE[lemas_2000$TYPE == 5] =  "State law enforcement agency"

# clean 2003 data ####

# subset only california
lemas_2003 = lemas_2003[lemas_2003$STATE == "CA", ]

# add year
lemas_2003$year = 2003

# match dataframe with other years
lemas_2003 = data.frame('year' = lemas_2003$year,
                        "AGENCY" = lemas_2003$AGENCYNA,
                        "CITY" = lemas_2003$CITY,
                        "STATE" = lemas_2003$STATE,
                        "ZIP" = lemas_2003$ZIP,
                        'TYPE' = as.numeric(lemas_2003$AGCYTYPE),
                        "COUNTY" = lemas_2003$COUNTY,
                        'FTSWORN' = lemas_2003$V42,
                        'PTSWORN' = lemas_2003$V43,
                        'FTCIV'  = lemas_2003$V48,
                        'PTCIV' = lemas_2003$V49,
                        'FTDRUGOFF' = NA,
                        'PTDRUGOFF' = NA,
                        'IMPDRUGTASK' = NA,
                        'OPBUDGET' = lemas_2003$V66,
                        'OPBUDGEST' = lemas_2003$V67,
                        'IMPBUDGET' = NA,
                        "ASSETFOR" = as.numeric(lemas_2003$V68),
                        'ASFOREST' = NA,
                        'WHITE' = lemas_2003$V111 + lemas_2003$V112,
                        'BLACK' = lemas_2003$V113 + lemas_2003$V114,
                        'HISPANIC' = lemas_2003$V115 + lemas_2003$V116,
                        'ASIAN' = lemas_2003$V119 + lemas_2003$V120,
                        'NATHAW' = lemas_2003$V121 + lemas_2003$V122,
                        'AMERIND' = lemas_2003$V117 + lemas_2003$V118,
                        'MULTRACE' = NA,
                        'UNKRACE' = NA,
                        'IMPRACE' = NA,
                        'MALE' = lemas_2003$V125,
                        'FEMALE' = lemas_2003$V126,
                        'IMPGENDER' = NA,
                        'CHIEFMIN' = lemas_2003$V137,
                        'IMPCHFMIN' = NA,
                        'CHIEFMAX' = lemas_2003$V138,
                        'IMPCHFMAX' = NA,
                        'SGTMIN' = lemas_2003$V139,
                        'IMPSGTMIN' = NA,
                        'SGTMAX' = lemas_2003$V140,
                        'IMPSGTMAX' = NA,
                        'ENTRYMIN' = lemas_2003$V141,
                        'IMPENTRYMIN' = NA,
                        'ENTRYMAX' = lemas_2003$V142,
                        'IMPENTRYMAX' = NA,
                        'BDGT_SRC_ASST' = NA,
                        'PERS_PDSW_MPT' = NA,
                        'PERS_PDSW_FPT' = NA,
                        stringsAsFactors = FALSE)

# rename agency types
# TYPE
lemas_2003$TYPE[lemas_2003$TYPE == 1] =  "Sheriff"
lemas_2003$TYPE[lemas_2003$TYPE == 3] =  "Local police"
lemas_2003$TYPE[lemas_2003$TYPE == 5] =  "State law enforcement agency"

# asset forfeiture
lemas_2003$ASSETFOR[lemas_2003$ASSETFOR == 99999999] = NA
lemas_2003$ASSETFOR[lemas_2003$ASSETFOR == 77777777] = NA
# this dosn't actually do anything as none of these special values showed up

lemas_2003$OPBUDGEST = as.logical(as.numeric(lemas_2003$OPBUDGEST))

# Clean 2007 Data ####

# subset only california
lemas_2007 = lemas_2007[lemas_2007$STATE == "CA", ]

# subset only varaibles of interest
lemas_2007 = lemas_2007[, c("ORI", "AGCYTYPE", "AGENCY", "CITY", "STATE", "ZIPCODE", "SWNFTEMP", "SWNPTEMP", "CIVFTEMP", "CIVPTEMP", "FTDRUGOFF", "PTDRUGOFF", "IMPDRUGTASK", "OPBUDGET", "OPBUDGEST", "IMPBUDGET", "DRUGFORF", "GAMBFORF", "OTHRFORF", "ASFOREST", "WHITE", "BLACK", "HISPANIC", "ASIAN", "NATHAW", "AMERIND", "MULTRACE", "UNKRACE", "IMPRACE", "MALE", "FEMALE", "IMPGENDER", "CHIEFMIN", "IMPCHFMIN", "CHIEFMAX", "IMPCHFMAX", "SGTMIN", "IMPSGTMIN", "SGTMAX", "IMPSGTMAX", "ENTRYMIN", "IMPENTRYMIN", "ENTRYMAX", "IMPENTRYMAX")]

# add year
lemas_2007$year = 2007

# rename agency types
lemas_2007$AGCYTYPE[lemas_2007$AGCYTYPE == 1] =  "Sheriff"
lemas_2007$AGCYTYPE[lemas_2007$AGCYTYPE == 3] =  "Local police"
lemas_2007$AGCYTYPE[lemas_2007$AGCYTYPE == 5] =  "State law enforcement agency"
lemas_2007$AGCYTYPE = as.factor(lemas_2007$AGCYTYPE)

# sworn actual full time
lemas_2007$SWNFTEMP[lemas_2007$SWNFTEMP == 888888 | lemas_2007$SWNFTEMP == 999999] = NA
# sworn actual part time
lemas_2007$SWNPTEMP[lemas_2007$SWNPTEMP == 888888 | lemas_2007$SWNPTEMP == 999999] = NA

# civ full time
lemas_2007$CIVFTEMP[lemas_2007$CIVFTEMP == 888888 | lemas_2007$CIVFTEMP == 999999] = NA
# civ part time
lemas_2007$CIVPTEMP[lemas_2007$CIVPTEMP == 888888 | lemas_2007$CIVPTEMP == 999999] = NA

# full time sworn assigned to drugs full time
lemas_2007$CIVPTEMP[lemas_2007$FTDRUGOFF == 999999] = NA
# full time sworn assigned to drugs part time
lemas_2007$CIVPTEMP[lemas_2007$PTDRUGOFF == 999999] = NA
# drug officers imputed
lemas_2007$IMPDRUGTASK = as.logical(lemas_2007$IMPDRUGTASK)

# operating budget
lemas_2007$OPBUDGET[lemas_2007$OPBUDGET == 99999999] = NA
# estimated operating budget
lemas_2007$OPBUDGEST[lemas_2007$OPBUDGEST == 0] = "FALSE"
lemas_2007$OPBUDGEST[lemas_2007$OPBUDGEST == 1] = "TRUE"
lemas_2007$OPBUDGEST[lemas_2007$OPBUDGEST == 8] = NA
lemas_2007$OPBUDGEST = as.logical(lemas_2007$OPBUDGEST)
# imputed budget
lemas_2007$IMPBUDGET = as.logical(lemas_2007$IMPBUDGET)

# money from drug forfeiture
lemas_2007$DRUGFORF[lemas_2007$DRUGFORF == 99999999] = NA
# money from gambling forfeiture
lemas_2007$GAMBFORF[lemas_2007$GAMBFORF == 99999999] = NA
# money from other forfeiture
lemas_2007$OTHRFORF[lemas_2007$OTHRFORF == 99999999] = NA
# estiamted total forfeiture
lemas_2007$ASFOREST[lemas_2007$ASFOREST == 99999999] = NA

# race of officers
lemas_2007$WHITE[lemas_2007$WHITE == 88888] = NA
lemas_2007$BLACK[lemas_2007$BLACK == 88888] = NA
lemas_2007$HISPANIC[lemas_2007$HISPANIC == 88888] = NA
lemas_2007$ASIAN[lemas_2007$ASIAN == 88888] = NA
lemas_2007$NATHAW[lemas_2007$NATHAW == 88888] = NA
lemas_2007$AMERIND[lemas_2007$AMERIND == 88888] = NA
lemas_2007$MULTRACE[lemas_2007$MULTRACE == 88888] = NA
lemas_2007$UNKRACE[lemas_2007$UNKRACE == 88888] = NA
lemas_2007$IMPRACE[lemas_2007$IMPRACE == 0] = "Not imputed"
lemas_2007$IMPRACE[lemas_2007$IMPRACE == 1] = "Imputed"
lemas_2007$IMPRACE[lemas_2007$IMPRACE == 2] = "Estimate based on reported data"

# officer gender
lemas_2007$MALE[lemas_2007$MALE == 88888| lemas_2007$MALE == 999999] = NA
lemas_2007$FEMALE[lemas_2007$FEMALE == 88888| lemas_2007$FEMALE == 999999] = NA
lemas_2007$IMPGENDER = as.logical(lemas_2007$IMPGENDER)

# chief pay
lemas_2007$CHIEFMIN[lemas_2007$CHIEFMIN == 999999] = NA
lemas_2007$CHIEFMAX[lemas_2007$CHIEFMAX == 999999] = NA
lemas_2007$IMPCHFMIN = as.logical(lemas_2007$IMPCHFMIN)
lemas_2007$IMPCHFMAX = as.logical(lemas_2007$IMPCHFMAX)

# sergent pay
lemas_2007$SGTMIN[lemas_2007$SGTMIN == 999999] = NA
lemas_2007$SGTMAX[lemas_2007$SGTMAX == 999999] = NA
lemas_2007$IMPSGTMIN = as.logical(lemas_2007$IMPSGTMIN)
lemas_2007$IMPSGTMAX = as.logical(lemas_2007$IMPSGTMAX)

# officer pay
lemas_2007$ENTRYMIN[lemas_2007$ENTRYMIN == 999999] = NA
lemas_2007$ENTRYMAX[lemas_2007$ENTRYMAX == 999999] = NA
lemas_2007$IMPENTRYMIN = as.logical(lemas_2007$IMPENTRYMIN)
lemas_2007$IMPENTRYMAX = as.logical(lemas_2007$IMPENTRYMAX)

# combine forfeiture sources
lemas_2007$ASSETFOR = lemas_2007$DRUGFORF + lemas_2007$GAMBFORF + lemas_2007$OTHRFORF

# Clean 2013 data ####

# subset only california
lemas_2013 = lemas_2013[lemas_2013$STATECODE == "CA", ]

# subset only variables of interest
lemas_2013 = lemas_2013[ , c("ORI7", "ORI9", "TYPE", "CITY", "BJS_AGENCYNAME", "STATECODE", "ZIPCODE", "FTSWORN", "PTSWORN", "FTCIV", "PTCIV", "PERS_PDSW_MFT", "PERS_PDSW_MPT", "PERS_PDSW_FFT", "PERS_PDSW_FPT", "PERS_FTS_WHT", "PERS_FTS_BLK", "PERS_FTS_HSP", "PERS_FTS_IND", "PERS_FTS_ASN", "PERS_FTS_HAW", "PERS_FTS_TWO", "PERS_FTS_UNK", "PAY_SAL_EXC_MIN", "PAY_SAL_EXC_MAX", "PAY_SAL_SGT_MIN", "PAY_SAL_SGT_MAX", "PAY_SAL_OFCR_MIN", "PAY_SAL_OFCR_MAX", "BDGT_TTL", "BDGT_TTL_EST", "BDGT_SRC_ASST")]

# add year
lemas_2013$year = 2013

# add CHP ORI9 Number
lemas_2013[lemas_2013$BJS_AGENCYNAME == "California Highway Patrol", "ORI9"] = "CA0349900"

# agency type
lemas_2013$TYPE[lemas_2013$TYPE == 1] =  "Local police"
lemas_2013$TYPE[lemas_2013$TYPE == 2] =  "Sheriff"
lemas_2013$TYPE[lemas_2013$TYPE == 3] =  "State law enforcement agency"
lemas_2013$TYPE = as.factor(lemas_2013$TYPE)

# Budget estimation
lemas_2013$BDGT_TTL_EST[lemas_2013$BDGT_TTL_EST == 1] =  "TRUE"
lemas_2013$BDGT_TTL_EST[lemas_2013$BDGT_TTL_EST == 2] =  "FALSE"
lemas_2013$BDGT_TTL_EST = as.logical(lemas_2013$BDGT_TTL_EST)

# budget funded by asset forfeiture
lemas_2013$BDGT_SRC_ASST[lemas_2013$BDGT_SRC_ASST == 1] = "TRUE"
lemas_2013$BDGT_SRC_ASST[lemas_2013$BDGT_SRC_ASST == 2] = "FALSE"
lemas_2013$BDGT_SRC_ASST = as.logical(lemas_2013$BDGT_SRC_ASST)

# clean 2016 data ####

# subset only california
lemas_2016 = lemas_2016[lemas_2016$STATE == "CA", ]

# keep columns of interest
lemas_2016 = lemas_2016[, c("ORI9", "AGENCYNAME", "CITY", "STATE", "ZIPCODE", "AGENCYTYPE", "COUNTY", "FTSWORN", "PTSWORN", "FTNON", "PTNON", "OPBUDGET", "OPBUDGET_EST", "EDIT_OPBUDGET", "ASSETFOR", "ASSETFOR_EST", "PERS_MALE", "PERS_FEMALE", "PERS_WHITE_MALE", "PERS_WHITE_FEM", "PERS_BLACK_MALE", "PERS_BLACK_FEM", "PERS_HISP_MALE", "PERS_HISP_FEM", "PERS_AMIND_MALE", "PERS_AMIND_FEM", "PERS_ASIAN_MALE", "PERS_ASIAN_FEM", "PERS_HAWPI_MALE", "PERS_HAWPI_FEM", "PERS_MULTI_MALE", "PERS_MULTI_FEM", "PERS_UNK_MALE", "PERS_UNK_FEM")]

# add year
lemas_2016$year = 2016

# replace missing values with NAs
lemas_2016$FTSWORN[lemas_2016$FTSWORN == -9] = NA
lemas_2016$FTNON[lemas_2016$FTNON == -9] = NA
lemas_2016$PTSWORN[lemas_2016$PTSWORN == -9] = NA
lemas_2016$PTNON[lemas_2016$PTNON == -9] = NA
lemas_2016$OPBUDGET[lemas_2016$OPBUDGET == -9] = NA
lemas_2016$OPBUDGET_EST[lemas_2016$OPBUDGET_EST == -9] = NA 
lemas_2016$ASSETFOR[lemas_2016$ASSETFOR == -9] = NA 
lemas_2016$ASSETFOR_EST[lemas_2016$ASSETFOR_EST == -9] = NA 
lemas_2016$PERS_WHITE_MALE[lemas_2016$PERS_WHITE_MALE == -9 | lemas_2016$PERS_WHITE_MALE == -8] = NA
lemas_2016$PERS_BLACK_MALE[lemas_2016$PERS_BLACK_MALE == -9 | lemas_2016$PERS_BLACK_MALE == -8] = NA
lemas_2016$PERS_HISP_MALE[lemas_2016$PERS_HISP_MALE == -9 | lemas_2016$PERS_HISP_MALE == -8] = NA  
lemas_2016$PERS_AMIND_MALE[lemas_2016$PERS_AMIND_MALE == -9 | lemas_2016$PERS_AMIND_MALE == -8] = NA  
lemas_2016$PERS_ASIAN_MALE[lemas_2016$PERS_ASIAN_MALE == -9 | lemas_2016$PERS_ASIAN_MALE == -8] = NA  
lemas_2016$PERS_HAWPI_MALE[lemas_2016$PERS_HAWPI_MALE == -9 | lemas_2016$PERS_HAWPI_MALE == -8] = NA 
lemas_2016$PERS_MULTI_MALE[lemas_2016$PERS_MULTI_MALE == -9 | lemas_2016$PERS_MULTI_MALE == -8] = NA 
lemas_2016$PERS_UNK_MALE[lemas_2016$PERS_UNK_MALE == -9 | lemas_2016$PERS_UNK_MALE == -8] = NA 
lemas_2016$PERS_MALE[lemas_2016$PERS_MALE == -9 | lemas_2016$PERS_MALE == -8] = NA 
lemas_2016$PERS_WHITE_FEM[lemas_2016$PERS_WHITE_FEM == -9 | lemas_2016$PERS_WHITE_FEM == -8] = NA
lemas_2016$PERS_BLACK_FEM[lemas_2016$PERS_BLACK_FEM == -9 | lemas_2016$PERS_BLACK_FEM == -8] = NA
lemas_2016$PERS_HISP_FEM[lemas_2016$PERS_HISP_FEM == -9 | lemas_2016$PERS_HISP_FEM == -8] = NA  
lemas_2016$PERS_AMIND_FEM[lemas_2016$PERS_AMIND_FEM == -9 | lemas_2016$PERS_AMIND_FEM == -8] = NA  
lemas_2016$PERS_ASIAN_FEM[lemas_2016$PERS_ASIAN_FEM == -9 | lemas_2016$PERS_ASIAN_FEM == -8] = NA  
lemas_2016$PERS_HAWPI_FEM[lemas_2016$PERS_HAWPI_FEM == -9 | lemas_2016$PERS_HAWPI_FEM == -8] = NA 
lemas_2016$PERS_MULTI_FEM[lemas_2016$PERS_MULTI_FEM == -9 | lemas_2016$PERS_MULTI_FEM == -8] = NA 
lemas_2016$PERS_UNK_FEM[lemas_2016$PERS_UNK_FEM == -9 | lemas_2016$PERS_UNK_FEM == -8] = NA 
lemas_2016$PERS_FEMALE[lemas_2016$PERS_FEMALE == -9 | lemas_2016$PERS_FEMALE == -8] = NA 

# match dataframe with previous years
lemas_2016 = data.frame("ORI9" = lemas_2016$ORI9,
                        'year' = lemas_2016$year,
                        "AGENCY" = lemas_2016$AGENCYNAME,
                        "CITY" = lemas_2016$CITY,
                        "STATE" = lemas_2016$STATE,
                        "ZIP" = lemas_2016$ZIPCODE,
                        'TYPE' = lemas_2016$AGENCYTYPE,
                        "COUNTY" = lemas_2016$COUNTY,
                        'FTSWORN' = lemas_2016$FTSWORN,
                        'PTSWORN' = lemas_2016$PTSWORN,
                        'FTCIV'  = lemas_2016$FTNON,
                        'PTCIV' = lemas_2016$PTNON,
                        'FTDRUGOFF' = NA,
                        'PTDRUGOFF' = NA,
                        'IMPDRUGTASK' = NA,
                        'OPBUDGET' = lemas_2016$OPBUDGET,
                        'OPBUDGEST' = lemas_2016$OPBUDGET_EST,
                        'IMPBUDGET' = lemas_2016$EDIT_OPBUDGET,
                        "ASSETFOR" = lemas_2016$ASSETFOR,
                        'ASFOREST' = lemas_2016$ASSETFOR_EST,
                        'WHITE' = lemas_2016$PERS_WHITE_MALE + lemas_2016$PERS_WHITE_FEM,
                        'BLACK' = lemas_2016$PERS_BLACK_MALE + lemas_2016$PERS_BLACK_FEM,
                        'HISPANIC' = lemas_2016$PERS_HISP_MALE + lemas_2016$PERS_HISP_FEM,
                        'ASIAN' = lemas_2016$PERS_ASIAN_MALE + lemas_2016$PERS_ASIAN_FEM,
                        'NATHAW' = lemas_2016$PERS_HAWPI_MALE + lemas_2016$PERS_HAWPI_FEM,
                        'AMERIND' = lemas_2016$PERS_AMIND_MALE + lemas_2016$PERS_AMIND_FEM,
                        'MULTRACE' = lemas_2016$PERS_MULTI_MALE + lemas_2016$PERS_MULTI_FEM,
                        'UNKRACE' = lemas_2016$PERS_UNK_MALE + lemas_2016$PERS_UNK_FEM,
                        'IMPRACE' = NA,
                        'MALE' = lemas_2016$PERS_MALE,
                        'FEMALE' = lemas_2016$PERS_FEMALE,
                        'IMPGENDER' = NA,
                        'CHIEFMIN' = NA,
                        'IMPCHFMIN' = NA,
                        'CHIEFMAX' = NA,
                        'IMPCHFMAX' = NA,
                        'SGTMIN' = NA,
                        'IMPSGTMIN' = NA,
                        'SGTMAX' = NA,
                        'IMPSGTMAX' = NA,
                        'ENTRYMIN' = NA,
                        'IMPENTRYMIN' = NA,
                        'ENTRYMAX' = NA,
                        'IMPENTRYMAX' = NA,
                        'BDGT_SRC_ASST' = NA,
                        'PERS_PDSW_MPT' = NA,
                        'PERS_PDSW_FPT' = NA,
  stringsAsFactors = FALSE)

# replace values
lemas_2016$TYPE[lemas_2016$TYPE == 1] =  "Local police"
lemas_2016$TYPE[lemas_2016$TYPE == 2] =  "Sheriff"
lemas_2016$TYPE[lemas_2016$TYPE == 3] =  "State law enforcement agency"

lemas_2016$OPBUDGEST = as.logical(lemas_2016$OPBUDGEST)
lemas_2016$IMPBUDGET = as.logical(lemas_2016$IMPBUDGET)
lemas_2016$ASFOREST = as.logical(lemas_2016$ASFOREST)

# combine ####

# standardize names
# 2007
colnames(lemas_2007)[colnames(lemas_2007) == "ORI"] = "ORI7"
colnames(lemas_2007)[colnames(lemas_2007) == "AGCYTYPE"] = "TYPE"
colnames(lemas_2007)[colnames(lemas_2007) == "SWNFTEMP"] = "FTSWORN"
colnames(lemas_2007)[colnames(lemas_2007) == "SWNPTEMP"] = "PTSWORN"
colnames(lemas_2007)[colnames(lemas_2007) == "CIVFTEMP"] = "FTCIV"
colnames(lemas_2007)[colnames(lemas_2007) == "CIVPTEMP"] = "PTCIV"
colnames(lemas_2007)[colnames(lemas_2007) == "ZIPCODE"] = "ZIP"
# 2013
colnames(lemas_2013)[colnames(lemas_2013) == "BJS_AGENCYNAME"] = "AGENCY"
colnames(lemas_2013)[colnames(lemas_2013) == "STATECODE"] = "STATE"
colnames(lemas_2013)[colnames(lemas_2013) == "PERS_FTS_WHT"] = "WHITE"
colnames(lemas_2013)[colnames(lemas_2013) == "PERS_FTS_BLK"] = "BLACK"
colnames(lemas_2013)[colnames(lemas_2013) == "PERS_FTS_HSP"] = "HISPANIC"
colnames(lemas_2013)[colnames(lemas_2013) == "PERS_FTS_IND"] = "AMERIND"
colnames(lemas_2013)[colnames(lemas_2013) == "PERS_FTS_ASN"] = "ASIAN"
colnames(lemas_2013)[colnames(lemas_2013) == "PERS_FTS_HAW"] = "NATHAW"
colnames(lemas_2013)[colnames(lemas_2013) == "PERS_FTS_TWO"] = "MULTRACE"
colnames(lemas_2013)[colnames(lemas_2013) == "PERS_FTS_UNK"] = "UNKRACE"
colnames(lemas_2013)[colnames(lemas_2013) == "BDGT_TTL"] = "OPBUDGET"
colnames(lemas_2013)[colnames(lemas_2013) == "BDGT_TTL_EST"] = "OPBUDGEST"
colnames(lemas_2013)[colnames(lemas_2013) == "PERS_PDSW_MFT"] = "MALE"
colnames(lemas_2013)[colnames(lemas_2013) == "PERS_PDSW_FFT"] = "FEMALE"
colnames(lemas_2013)[colnames(lemas_2013) == "PAY_SAL_EXC_MIN"] = "CHIEFMIN"
colnames(lemas_2013)[colnames(lemas_2013) == "PAY_SAL_EXC_MAX"] = "CHIEFMAX"
colnames(lemas_2013)[colnames(lemas_2013) == "PAY_SAL_SGT_MIN"] = "SGTMIN"
colnames(lemas_2013)[colnames(lemas_2013) == "PAY_SAL_SGT_MAX"] = "SGTMAX"
colnames(lemas_2013)[colnames(lemas_2013) == "PAY_SAL_OFCR_MIN"] = "ENTRYMIN"
colnames(lemas_2013)[colnames(lemas_2013) == "PAY_SAL_OFCR_MAX"] = "ENTRYMAX"
colnames(lemas_2013)[colnames(lemas_2013) == "ZIPCODE"] = "ZIP"

# generate columns missing from waves if possible
# was asset forfeiture a source of operating budget for 2007 (2007 has exact numbers)
lemas_2007$BDGT_SRC_ASST = (lemas_2007$DRUGFORF > 0 | lemas_2007$GAMBFORF > 0 | lemas_2007$OTHRFORF > 0)

# combine!
lemas_comb = plyr::rbind.fill(lemas_2000, lemas_2003, lemas_2007, lemas_2013, lemas_2016)

# add ORI9s for older data ####

ori_key = lemas_2013[, c("ORI7", "ORI9")]
lemas_comb$ORI9 = ori_key$ORI9[match(lemas_comb$ORI7, ori_key$ORI7)]

# clean and unify data ####

# keep only columns of interest
lemas_comb = lemas_comb[, c("ORI7", "ORI9", "year", "AGENCY", "TYPE", "CITY", "STATE", "ZIP", "FTSWORN", "PTSWORN", "FTCIV", "PTCIV", "FTDRUGOFF", "PTDRUGOFF", "OPBUDGET", "ASSETFOR", "WHITE", "BLACK", "HISPANIC", "ASIAN", "NATHAW", "AMERIND", "MULTRACE", "UNKRACE", "MALE", "FEMALE", "CHIEFMIN", "CHIEFMAX", "SGTMIN", "SGTMAX", "ENTRYMIN", "ENTRYMAX")]

# to lower all
lemas_comb$AGENCY = tolower(lemas_comb$AGENCY)

# fix sheriff's possessive
lemas_comb$AGENCY = gsub("\\bsheriff's\\b", " sheriff ", lemas_comb$AGENCY)
lemas_comb$AGENCY = gsub("\\bsheriffs\\b", " sheriff ", lemas_comb$AGENCY)
lemas_comb$AGENCY = gsub("\\bsheriff s\\b", " sheriff ", lemas_comb$AGENCY)
lemas_comb$AGENCY = gsub("sheriff /coroner", " sheriff ", lemas_comb$AGENCY)
lemas_comb$AGENCY = gsub("sheriff/coroner's", " sheriff ", lemas_comb$AGENCY)
lemas_comb$AGENCY = gsub("sd coroner", " sheriff ", lemas_comb$AGENCY)

# change "of public safety" to police
lemas_comb$AGENCY = gsub(" of public safety ?", " police ", lemas_comb$AGENCY)

# remove department and office
lemas_comb$AGENCY = gsub("\\bdept\\b", " ", lemas_comb$AGENCY)
lemas_comb$AGENCY = gsub("\\bdepartment\\b", " ", lemas_comb$AGENCY)
lemas_comb$AGENCY = gsub("\\boffice\\b", " ", lemas_comb$AGENCY)

# remove county
lemas_comb$AGENCY = gsub("\\bcounty\\b", " ", lemas_comb$AGENCY)

# replace dashes with spaces
lemas_comb$AGENCY = gsub("-", " ", lemas_comb$AGENCY)

# convert spaces and trim
lemas_comb$AGENCY = gsub("\\s+", " ", lemas_comb$AGENCY)
lemas_comb$AGENCY = trimws(lemas_comb$AGENCY)

## specific names ####

# contra costa county sheriff
lemas_comb$AGENCY[lemas_comb$AGENCY == "contra costa county sheriff /coroner"] = "contra costa county sheriff"

# cypress police
lemas_comb$AGENCY[lemas_comb$AGENCY == "cypness police"] = "cypress police"

# orange county sheriff
lemas_comb$AGENCY[lemas_comb$AGENCY == "orange county sheriff coroner"] = "orange county sheriff"

# placer county sheriff
lemas_comb$AGENCY[lemas_comb$AGENCY == "placer county sheriff /coroner"] = "placer county sheriff"

# salinas police department
lemas_comb$AGENCY[lemas_comb$AGENCY == "salinas poilce"] = "salinas police"

# san luis obispo sheriff
lemas_comb$AGENCY[lemas_comb$AGENCY == "san luis obispo county sheriff 's"] = "san luis obispo sheriff"

# san mateo county sheriff
lemas_comb$AGENCY[lemas_comb$AGENCY == "sheriff san mateo county"] = "san mateo county sheriff"

# solano county sheriff
lemas_comb$AGENCY[lemas_comb$AGENCY == "solano ocunty sheriff"] = "solano county sheriff"

# stanislaus county
lemas_comb$AGENCY[lemas_comb$AGENCY == "stanislaus county"] = "stanislaus county sheriff"

# ventura police
lemas_comb$AGENCY[lemas_comb$AGENCY == "ventura police buenaventura"] = "ventura police"

# visalia police
lemas_comb$AGENCY[lemas_comb$AGENCY == "visalia of public safety"] = "visalia police"

# carlsbad police
lemas_comb$AGENCY[lemas_comb$AGENCY == "carslbad police"] = "carlsbad police"

# write out ####

write.csv(lemas_comb, "./data/LEMAS/lemas_comb.csv", row.names = FALSE)

# column meanings ####
# discarded as couldn't save as CSV with

#lemas_comb = apply_labels(lemas_comb,
#                          'ORI7' = "ORI7 NUMBER ASSIGNED BY FBI",
#                          'ORI9' = "ORI9 NUMBER ASSIGNED BY FBI",
#                          'TYPE' = "TYPE OF AGENCY",
#                          'AGENCY'  = "NAME OF AGENCY",
#                          'CITY' = "CITY",
#                          'STATE' = "STATE ABBREVIATION",
#                          'FTSWORN' = "FULL-TIME SWORN PERSONNEL",
#                          'PTSWORN' = "PART-TIME SWORN PERSONNEL",
#                          'FTCIV'  = "FULL-TIME NONSWORN",
#                          'PTCIV' = "PART-TIME NONSWORN",
#                          'FTDRUGOFF' = "FULL-TIME SWORN PERSONNEL ASSIGNED TO MULTI-AGENCY TASK FORCES - DRUGS",
#                          'PTDRUGOFF' = "PART-TIME SWORN PERSONNEL ASSIGNED TO MULTI-AGENCY TASK FORCES - DRUGS",
#                          'IMPDRUGTASK' = "IMPUTED VALUE - DRUG TASK FORCE OFFICERS",
#                          'OPBUDGET' = "TOTAL OPERATING BUDGET FOR THE 12-MONTH PERIOD THAT INCLUDES SEPTEMBER 30, 2007",
#                          'OPBUDGEST' = "ESTIMATED TOTAL OPERATING BUDGET FOR THE 12-MONTH PERIOD THAT INCLUDES SEPTEMBER 30, 2007",
#                          'IMPBUDGET' = "IMPUTED VALUE - OPERATING BUDGET",
#                          "ASSETFOR" = "TOTAL ESTIMATED VALUE OF MONEY, GOODS, AND PROPERTY RECEIVED",
#                          'ASFOREST' = "TOTAL ESTIMATED VALUE OF MONEY, GOODS, AND PROPERTY RECEIVED DURING 2006 - AN ESTIMATION",
#                          'WHITE' = "FULL-TIME SWORN - WHITE, NOT OF HISPANIC ORIGIN",
#                          'BLACK' = "FULL-TIME SWORN - BLACK OR AFRICAN-AMERICAN, HISPANIC ORIGIN",
#                          'HISPANIC' = "FULL-TIME SWORN - HISPANIC OR LATINO",
#                          'ASIAN' = "FULL-TIME SWORN - ASIAN",
#                          'NATHAW' = "FULL-TIME SWORN - NATIVE HAWAIIAN OR OTHER PACIFIC ISLANDER",
#                          'AMERIND' = "FULL-TIME SWORN - AMERICAN INDIAN OR ALASKA NATIVE",
#                          'MULTRACE' = "FULL-TIME SWORN - TWO OR MORE RACES",
#                          'UNKRACE' = "FULL-TIME SWORN - NO INFORMATION AVAILABLE",
#                          'IMPRACE' = "IMPUTED VALUE - SWORN PERSONNEL BY RACE",
#                          'MALE' = "FULL-TIME SWORN PERSONNEL - MALE",
#                          'FEMALE' = "FULL-TIME SWORN PERSONNEL - FEMALE",
#                          'IMPGENDER' = "IMPUTED VALUE - SWORN PERSONNEL BY GENDER",
#                          'CHIEFMIN' = "CHIEF EXECUTIVE MINIMUM SALARY",
#                          'IMPCHFMIN' = "IMPUTED VALUE - CHIEF SALARY MINIMUM",
#                          'CHIEFMAX' = "CHIEF EXECUTIVE MAXIMUM SALARY",
#                          'IMPCHFMAX' = "IMPUTED VALUE - CHIEF SALARY MAXIMUM",
#                          'SGTMIN' = "SERGEANT OR EQUIVALENT MINIMUM SALARY",
#                          'IMPSGTMIN' = "IMPUTED VALUE - SGT SALARY MINIMUM",
#                          'SGTMAX' = "SERGEANT OR EQUIVALENT MAXIMUM SALARY",
#                          'IMPSGTMAX' = "IMPUTED VALUE - SGT SALARY MAXIMUM",
#                          'ENTRYMIN' = "ENTRY-LEVEL OFFICER OR DEPUTY MINIMUM SALARY",
#                          'IMPENTRYMIN' = "IMPUTED VALUE - ENTRY-LEVEL SALARY MINIMUM",
#                          'ENTRYMAX' = "ENTRY-LEVEL OFFICER OR DEPUTY MAXIMUM SALARY",
#                          'IMPENTRYMAX' = "IMPUTED VALUE - ENTRY-LEVEL SALARY MAXIMUM",
#                          'year' = "DATA YEAR",
#                          'BDGT_SRC_ASST' = "BUDGET INCLUDED ASSET FORFEITURE PROGRAM",
#                          'PERS_PDSW_MPT' = "MALE SWORN PERSONNEL - PART TIME",
#                          'PERS_PDSW_FPT' = "FEMALE SWORN PERSONNEL - PART TIME"
#)













