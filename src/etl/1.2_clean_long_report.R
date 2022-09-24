# standardize data from the pdf reports

#### setup ####

clean_recipient_names = function(report){

#### Standardize names ####
# fix names that have slight variations causing them to appear as distinct

## General fixes
# replace non unicode with encoding with this dash
report$recipient = gsub("â€”", "-", report$recipient)

# trim white spaces
report$recipient = trimws(report$recipient)

## general name fixes
report$recipient = gsub("\\bCSU\\b", " CALIFORNIA STATE UNIVERSITY ", report$recipient)

## specific name fixes

# 15% - 11489
report$recipient[report$recipient == "15%- 11489"] = "15% - 11489"
report$recipient[report$recipient == "15% -11489"] = "15% - 11489"
report$recipient[report$recipient == "15%- 11489"] = "15% - 11489"
report$recipient[report$recipient == "15% - 1 1489"] = "15% - 11489"
report$recipient[report$recipient == "15% -1 1489"] = "15% - 11489"
report$recipient[report$recipient == "15%— 11489"] = "15% - 11489"
report$recipient[report$recipient == "15%-11489"] = "15% - 11489"
report$recipient[report$recipient == "15% — 11489"] = "15% - 11489"
report$recipient[report$recipient == "15% —11489"] = "15% - 11489"
report$recipient[report$recipient == "15%—11489"] = "15% - 11489"
report$recipient[report$recipient == "15%— 11489"] = "15% - 11489"
report$recipient[report$recipient == "15%-11489"] = "15% - 11489"
report$recipient[report$recipient == "15% - 11489(â€˜DA A"] = "15% - 11489"
report$recipient[report$recipient == "15% â€”11489"] = "15% - 11489"
report$recipient[report$recipient == "15%â€” 11489"] = "15% - 11489"
report$recipient[report$recipient == "15%â€”11489"] = "15% - 11489"
report$recipient[report$recipient == "5% - 11489"] = "15% - 11489"  

# ALAMEDA CO SO
report$recipient[report$recipient == "ALAMEDA CO SO7"] = "ALAMEDA CO SO" 
report$recipient[report$recipient == "ALAMEDA CO SO17"] = "ALAMEDA CO SO" 
report$recipient[report$recipient == "LAMEDA CO SO"] = "ALAMEDA CO SO" 

# ALCOHOL BEV. CONTROL
report$recipient[report$recipient == "ALCOHOL BEV.CONTROL"] = "ALCOHOL BEV. CONTROL" 

# BERKELEY PD
report$recipient[report$recipient == "ERKELEY PD"] = "BERKELEY PD" 
report$recipient[report$recipient == "BERKELEY PD7"] = "BERKELEY PD" 
report$recipient[report$recipient == "BERKELEY PD17"] = "BERKELEY PD" 

# BURBANK AIRPORT POLICE
report$recipient[report$recipient == "BURBANK AIRPORT PD"] = "BURBANK AIRPORT POLICE" 

# CA DOJ-BNE
report$recipient[report$recipient == "BNE-RIVERSIDE"] = "CA DOJ-BNE RIVERSIDE"
report$recipient[report$recipient == "BNE-SAN FRANCISCO"] = "CA DOJ-BNE SAN FRANCISCO"

# BUTTE CO SO
report$recipient[report$recipient == "BUTTE COSO"] = "BUTTE CO SO" 

# CA DEPT. OF CORRECTIONS
report$recipient[report$recipient == "CA DEPT. OF CORRECTIONS"] = "CA DEPT OF CORRECTIONS"
report$recipient[report$recipient == "DEPT OF CORRECTIONS"] = "CA DEPT OF CORRECTIONS"

# CA DOJ-BNE RIVERSIDE
report$recipient[report$recipient == "DOJ-BNE RIVERSIDE"] = "CA DOJ-BNE RIVERSIDE"

# CA DOJ-BNE LOS ANGELES
report$recipient[report$recipient == "DOJ-BNE LOS ANGELES"] = "CA DOJ-BNE LOS ANGELES"

# CA STATE PARKS
report$recipient[report$recipient == "CA ST PARKS"] = "CA STATE PARKS"

# CALIFORNIA HIGHWAY PATROL
report$recipient[report$recipient == "CALIFORNIA HIGHWAY PATROL"] = "CHP"

# CDAA
report$recipient[report$recipient == "DAA"] = "CDAA"
report$recipient[report$recipient == "AA"] = "CDAA"

# CENTRAL MARIN POLICE
report$recipient[report$recipient == "CENTRAL MARINPOLICE AUTHORITY"] = "CENTRAL MARIN POLICE"

# CHICO PD
report$recipient[report$recipient == "HICO PD"] = "CHICO PD"

# CONTRA COSTA
report$recipient = gsub("CONTM COSTA", " CONTRA COSTA ", report$recipient)

# CONTRA COSTA CASE
report$recipient[report$recipient == "CONTRA COSTACASE"] = "CONTRA COSTA CASE"

# CONTRA COSTA CO SO
report$recipient[report$recipient == "CONTRA COSTA CO so"] = "CONTRA COSTA CO SO"
report$recipient[report$recipient == "CONTRA COSTA co so"] = "CONTRA COSTA CO SO"
report$recipient[report$recipient == "CONTRA COSTA COSO"] = "CONTRA COSTA CO SO"

# DA OFFICE
report$recipient[report$recipient == "A OFFICE"] = "DA OFFICE"
report$recipient[report$recipient == "CA OFFICE"] = "DA OFFICE"

# DEL NORTE CO SO
report$recipient[report$recipient == "DEL NORTE COSO"] = "DEL NORTE CO SO"

# DOJ BNE SF
report$recipient[report$recipient == "DOJ BNE SF"] = "bureau of narcotic enforcement san francisco"

# DRUG ENFORCEMENT ADMIN
report$recipient[report$recipient == "DRUG ENFORCEMENT AD"] = "DRUG ENFORCEMENT ADMIN"

# FOUNTAIN VALLEY PD
report$recipient[report$recipient == "FOUNTAIN VALLEYPD"] = "FOUNTAIN VALLEY PD"

# FREMONT PD
report$recipient[report$recipient == "FREMONT PD7"] = "FREMONT PD"
report$recipient[report$recipient == "FREMONT PD17"] = "FREMONT PD"
report$recipient[report$recipient == "REMONT PD"] = "FREMONT PD"

# FRESNO CO SO
report$recipient[report$recipient == "FRESNO COSO"] = "FRESNO CO SO"

# FULTON & El CAMINO REC
report$recipient[report$recipient == "FULTON & E1 CAMINO REC &"] = "FULTON & El CAMINO REC"
report$recipient[report$recipient == "FULTON & El CAMINO REC &"] = "FULTON & El CAMINO REC"

# GANG/DRUG PREVENTION
report$recipient[report$recipient == "GANG/DRUGPREVENTION"] = "GANG/DRUG PREVENTION"
report$recipient[report$recipient == "GANG/DRUG"] = "GANG/DRUG PREVENTION"

# GENERAL FUND
report$recipient[report$recipient == "GENERAL FUND7"] = "GENERAL FUND"
report$recipient[report$recipient == "GENERALFUND"] = "GENERAL FUND"
report$recipient[report$recipient == "GENERAL FUND17"] = "GENERAL FUND"
report$recipient[report$recipient == "GENERAL FUND 17"] = "GENERAL FUND"
report$recipient[report$recipient == "ENERAL FUND"] = "GENERAL FUND"

# HESPERIA PD
report$recipient[report$recipient == "HESPERLA PD"] = "HESPERIA PD"

# HUMBOLDT CO DTF
report$recipient[report$recipient == "HUMBOLDT CO DTF-HCDTF"] = "HUMBOLDT CO DTF"
report$recipient[report$recipient == "TF HUMBOLDT CO DTF-HCDTF"] = "HUMBOLDT CO DTF"
report$recipient[report$recipient == "HUMBOLDT CO DTF- HCDTF"] = "HUMBOLDT CO DTF"
report$recipient[report$recipient == "HUMBOLDT CO DTF-HCDTF"] = "HUMBOLDT CO DTF"
report$recipient[report$recipient == "TF HUMBOLDT CO DTF-"] = "HUMBOLDT CO DTF"
report$recipient[report$recipient == "HUMBOLDT CO DTF-HCDTF NA"] = "HUMBOLDT CO DTF"
report$recipient[report$recipient == "HUMBOLDT CO DTF-HCDTF"] = "HUMBOLDT CO DTF"
report$recipient[report$recipient == "TF HUMBOLDT CO DTF-"] = "HUMBOLDT CO DTF"
report$recipient[report$recipient == "HUMBOLDT CO DTF-HCDTF"] = "HUMBOLDT CO DTF"

# HUNTINGTON BEACH PD
report$recipient[report$recipient == "HUNTINGTONBEACH PD"] = "HUNTINGTON BEACH PD"

# IRVINE PD
report$recipient[report$recipient == "IRVINE PD17"] = "IRVINE PD"
report$recipient[report$recipient == "IRVINE PD7"] = "IRVINE PD"

# IRNET
report$recipient[report$recipient == "I.R.N.E.T."] = "IRNET"
report$recipient[report$recipient == "TF IRNET"] = "IRNET"
report$recipient[report$recipient == "IF IRNET"] = "IRNET"

# KCSO/CAL-MMET
report$recipient[report$recipient == "KCSO/CAL—MMET"] = "KCSO/CAL-MMET"
report$recipient[report$recipient == "KCSO/CALâ€”MMET"] = "KCSO/CAL-MMET"

# KERN CO DA
report$recipient[report$recipient == "KERN CO DA17"] = "KERN CO DA"

# KERN CO PROBATION
report$recipient[report$recipient == "KERN COPROBATION"] = "KERN CO PROBATION"

# KINGS CO SO
report$recipient[report$recipient == "KINGS COSO"] = "KINGS CO SO"

# KINGS CO SPECIAL FUND
report$recipient[report$recipient == "KINGS CO SPECIALFUND"] = "KINGS CO SPECIAL FUND"

# LA IMPACT
report$recipient[report$recipient == "LA IMPACT - GROUP 1"] = "LA IMPACT"
report$recipient[report$recipient == "LA IMPACT - GROUP1"] = "LA IMPACT"
report$recipient[report$recipient == "LA IMPACT â€” GROUP 1"] = "LA IMPACT"
report$recipient[report$recipient == "LA IMPACT - GROUP 2"] = "LA IMPACT"
report$recipient[report$recipient == "LA IMPACT — GROUP 2"] = "LA IMPACT"
report$recipient[report$recipient == "LA IMPACT â€” GROUP 2"] = "LA IMPACT"
report$recipient[report$recipient == "LA IMPACT - GROUP 3"] = "LA IMPACT"
report$recipient[report$recipient == "LA IMPACT - GROUP 4"] = "LA IMPACT"
report$recipient[report$recipient == "LA IMPACT — GROUP 4"] = "LA IMPACT"
report$recipient[report$recipient == "LA IMPACT â€” GROUP 4"] = "LA IMPACT"
report$recipient[report$recipient == "LA IMPACT - GROUP 7"] = "LA IMPACT"
report$recipient[report$recipient == "LA IMPACT - GROUP 12"] = "LA IMPACT"
report$recipient[report$recipient == "LA IMPACT - GROUP18"] = "LA IMPACT"
report$recipient[report$recipient == "LA IMPACT NA"] = "LA IMPACT"
report$recipient[report$recipient == "TF LOS ANGELES-LA IMPACT"] = "LA IMPACT"
report$recipient[report$recipient == "TF L A IMPACT GROUP 3"] = "LA IMPACT"
report$recipient[report$recipient == "TF L A IMPACT GROUP 2"] = "LA IMPACT"

# LA MESA PD
report$recipient[report$recipient == "LA MESA PD7"] = "LA MESA PD"
report$recipient[report$recipient == "LA MESA PD17"] = "LA MESA PD"

# LAPA
report$recipient[report$recipient == "LAPA17"] = "LAPA"
report$recipient[report$recipient == "LAPA7"] = "LAPA"

# LODI PD
report$recipient[report$recipient == "LODI PD NA"] = "LODI PD"

# LONG BEACH PD
report$recipient[report$recipient == "LONG BEACH PD7"] = "LONG BEACH PD"
report$recipient[report$recipient == "LONG BEACH PD17"] = "LONG BEACH PD"

# LOS ANGELES CO SO
report$recipient[report$recipient == "LOS ANGELES COSO"] = "LOS ANGELES CO SO"
report$recipient[report$recipient == "LOS ANGELES CO SD"] = "LOS ANGELES CO SO"
report$recipient[report$recipient == "LOS ANGELES CO SO17"] = "LOS ANGELES CO SO"
report$recipient[report$recipient == "LOS ANGELES CO SD NA"] = "LOS ANGELES CO SO"
report$recipient[report$recipient == "LOS ANGELES CO SD"] = "LOS ANGELES CO SO"

# LOS ANGELES PD
report$recipient[report$recipient == "LOS ANGELES PD7"] = "LOS ANGELES PD"
report$recipient[report$recipient == "LOS ANGELES PD17"] = "LOS ANGELES PD"
report$recipient[report$recipient == "LOS ANGELES PD NA"] = "LOS ANGELES PD"

# MANTECA PD
report$recipient[report$recipient == "MANTECA PD7"] = "MANTECA PD"
report$recipient[report$recipient == "MANTECA PD17"] = "MANTECA PD"

# MENDOCINO CO COMMET
report$recipient[report$recipient == "MENDOCINO COCOMMET"] = "MENDOCINO CO COMMET"
report$recipient[report$recipient == "MENDOCINO CO"] = "MENDOCINO CO COMMET"

# MENDOCINO CO SO
report$recipient[report$recipient == "MENDOCINO CO so"] = "MENDOCINO CO SO"

# MERCED CO SO
report$recipient[report$recipient == "MERCED COSO"] = "MERCED CO SO"

# METRO
report$recipient[report$recipient == "METRO17"] = "METRO"
report$recipient[report$recipient == "METRO7"] = "METRO"

# MODESTO PF 
report$recipient[report$recipient == "MODESTO PD NA"] = "MODESTO PD"

# MORONGO SHERIFF
report$recipient[report$recipient == "MORONGO SHERIFF STATION"] = "MORONGO SHERIFF"

# NEWPORT BEACH PD
report$recipient[report$recipient == "NEWPORT BEACHPD"] = "NEWPORT BEACH PD"

# NSICAL-MMET
report$recipient[report$recipient == "NSICALMMET"] = "NSICAL-MMET"

# OAKLAND PD
report$recipient[report$recipient == "OAKLAND PD7"] = "OAKLAND PD"
report$recipient[report$recipient == "OAKLAND PD17"] = "OAKLAND PD"
report$recipient[report$recipient == "AKLAND PD"] = "OAKLAND PD"

# ONTARIO PD
report$recipient[report$recipient == "ONTARIO PD NA"] = "ONTARIO PD"
report$recipient[report$recipient == "ONTARIO POLICE DEPARTMENT"] = "ONTARIO PD"

# ORANGE CO SO
report$recipient[report$recipient == "ORANGE CO SO17"] = "ORANGE CO SO"
report$recipient[report$recipient == "ORANGE CO SO7"] = "ORANGE CO SO"
report$recipient[report$recipient == "ORANGE CO SD"] = "ORANGE CO SO"
report$recipient[report$recipient == "OMNGE CO SO"] = "ORANGE CO SO"

# ORANGE PD
report$recipient[report$recipient == "ORANGE PD17"] = "ORANGE PD"
report$recipient[report$recipient == "ORANGE PD7"] = "ORANGE PD"
report$recipient[report$recipient == "OMNGE PD"] = "ORANGE PD"
report$recipient[report$recipient == "ORANGE POLICE DEPARTMENT"] = "ORANGE PD"

# ORANGE CO RNSP
report$recipient[report$recipient == "ORANGE CO RNSP NA"] = "ORANGE CO RNSP"
report$recipient[report$recipient == "TF ORANGE CO RNSP"] = "ORANGE CO RNSP"

# OROVILLE PD
report$recipient[report$recipient == "OROVILLE PD17"] = "OROVILLE PD"
report$recipient[report$recipient == "OROVILLE PD7"] = "OROVILLE PD"

# OXNARD PD
report$recipient[report$recipient == "XNARD PD"] = "OXNARD PD"
report$recipient[report$recipient == "OXNARD PD7"] = "OXNARD PD"
report$recipient[report$recipient == "OXNARD PD17"] = "OXNARD PD"

# PASADENA PD
report$recipient[report$recipient == "PASADENA PD17"] = "PASADENA PD"
report$recipient[report$recipient == "PASADENA PD7"] = "PASADENA PD"

# PLACER CO SIU
report$recipient[report$recipient == "PLACER CO SIU7"] = "PLACER CO SIU"
report$recipient[report$recipient == "PLACER CO SIU17"] = "PLACER CO SIU"

# PLACER CO SO
report$recipient[report$recipient == "PLACER COSO"] = "PLACER CO SO"

# POMONA PD
report$recipient[report$recipient == "POMONA PD7"] = "POMONA PD"

# RANCHO CORDOVA PD
report$recipient[report$recipient == "RANCHO CORDOVAPD"] = "RANCHO CORDOVA PD"

# REDDING PD
report$recipient[report$recipient == "REDDING PD7"] = "REDDING PD"
report$recipient[report$recipient == "REDDING PD17"] = "REDDING PD"

# RICHMOND PD
report$recipient[report$recipient == "RICHMOND PD7"] = "RICHMOND PD"

# RIVERSIDE CO DA
report$recipient[report$recipient == "RIVERSIDE CO DA7"] = "RIVERSIDE CO DA"

# RIVERSIDE CO SO
report$recipient[report$recipient == "RIVERSIDE COSO"] = "RIVERSIDE CO SO"
report$recipient[report$recipient == "RIVERSIDE CO SO7"] = "RIVERSIDE CO SO"
report$recipient[report$recipient == "RIVERSIDE CO SO17"] = "RIVERSIDE CO SO"

# RIVERSIDE PD
report$recipient[report$recipient == "RIVERSIDE PD17"] = "RIVERSIDE PD"
report$recipient[report$recipient == "RIVERSIDE PD7"] = "RIVERSIDE PD"

# ROSEVILLE PD
report$recipient[report$recipient == "ROSEVILLE PD7"] = "ROSEVILLE PD"

# SACMCTF
report$recipient[report$recipient == "ACMCTF"] = "SACMCTF"

# SACRAMENTO CO SO
report$recipient[report$recipient == "SACRAMENTO CO SO7"] = "SACRAMENTO CO SO"
report$recipient[report$recipient == "SACRAMENTO COSO"] = "SACRAMENTO CO SO"
report$recipient[report$recipient == "SACRAMENTO CO SO7"] = "SACRAMENTO CO SO"
report$recipient[report$recipient == "SACRAMENTO CO SO 17"] = "SACRAMENTO CO SO"
report$recipient[report$recipient == "SACRAMENTO COSD"] = "SACRAMENTO CO SO"
report$recipient[report$recipient == "SACRAMENTO CO SO17"] = "SACRAMENTO CO SO"
report$recipient[report$recipient == "SACRA1Vfl3NTO CO SO"] = "SACRAMENTO CO SO"
report$recipient[report$recipient == "SACRAIVHENTO CO SO"] = "SACRAMENTO CO SO"

# SACRAMENTO PD
report$recipient[report$recipient == "SACRAMENTO PD7"] = "SACRAMENTO PD"
report$recipient[report$recipient == "SACRAMENTO PD17"] = "SACRAMENTO PD"
report$recipient[report$recipient == "SACRAMENTO PD NA"] = "SACRAMENTO PD"
report$recipient[report$recipient == "SACRA1Vfl3NTO PD"] = "SACRAMENTO PD"
report$recipient[report$recipient == "SACRAIVHENTO PD"] = "SACRAMENTO PD"

# SACRAMENTO PROBATION
report$recipient[report$recipient == "SACRAMENTOPROBATION"] = "SACRAMENTO PROBATION"
report$recipient[report$recipient == "SACRAMENTO PROBATION 17"] = "SACRAMENTO PROBATION"
report$recipient[report$recipient == "SACRAMENTO PROBATION17"] = "SACRAMENTO PROBATION"

# SAFE STREETS TASK FORCE
report$recipient[report$recipient == "SAFE STREETS TASKFORCE"] = "SAFE STREETS TASK FORCE"
report$recipient[report$recipient == "SAFE STREETS TASK FORCE7"] = "SAFE STREETS TASK FORCE"

# SAN BERNARDINO PD
report$recipient[report$recipient == "SAN BERNARDINO PD7"] = "SAN BERNARDINO PD"
report$recipient[report$recipient == "SAN BERNARDINOPD"] = "SAN BERNARDINO PD"

# SAN BERNARDINO PROB
report$recipient[report$recipient == "SAN BERNARDINO CO PROB"] = "SAN BERNARDINO PROB"

# SAN BERNARDINO SO
report$recipient[report$recipient == "SAN BERNARDINOCO SO"] = "SAN BERNARDINO SO"
report$recipient[report$recipient == "SAN BERNARDINO COSO"] = "SAN BERNARDINO SO"

# SAN JOSE PD
report$recipient[report$recipient == "SAN JO SE PD"] = "SAN JOSE PD"

# SANTA BARBARA CO SO
report$recipient[report$recipient == "SANTA BARBARACO SO"] = "SANTA BARBARA CO SO"

# SANTA BARBARA PD
report$recipient[report$recipient == "SANTA BARBARAPD"] = "SANTA BARBARA PD"
report$recipient[report$recipient == "SANTA BARBARA PD7"] = "SANTA BARBARA PD"
report$recipient[report$recipient == "SANTA BARBARA PD17"] = "SANTA BARBARA PD"

# SANTA CLARA CO SO
report$recipient[report$recipient == "SANTA CLARA COSO"] = "SANTA CLARA CO SO"

# SANTA CRUZ CO SO
report$recipient[report$recipient == "SANTA CRUZ COSO"] = "SANTA CRUZ CO SO"

# SAN BERNARDINO CO PROB
report$recipient[report$recipient == "SAN BERNARDINOCO PROB"] = "SAN BERNARDINO CO PROB"

# SAN DIEGO PD
report$recipient[report$recipient == "SAN DIEGO PD7"] = "SAN DIEGO PD"

# SAN DIEGO CO SO
report$recipient[report$recipient == "SAN DIEGO CO SO7"] = "SAN DIEGO CO SO"

# SAN FRANCISCO PD
report$recipient[report$recipient == "SAN FRANCISCO PD7"] = "SAN FRANCISCO PD"
report$recipient[report$recipient == "SAN FRANCISCO PD17"] = "SAN FRANCISCO PD"

# SAN LEANDRO PD
report$recipient[report$recipient == "AN LEANDRO PD"] = "SAN LEANDRO PD"

# SAN LUIS OBISPO CO DA
report$recipient[report$recipient == "SAN LUIS OBISPBO CO DA"] = "SAN LUIS OBISPO CO DA"

# SAN LUIS OBISPO CO SO
report$recipient[report$recipient == "SAN LUIS OBISPO COSO"] = "SAN LUIS OBISPO CO SO"

# SAN RAMON PD
report$recipient[report$recipient == "SAN RAMON PD17"] = "SAN RAMON PD"
report$recipient[report$recipient == "SAN RAMON PD7"] = "SAN RAMON PD"

# SANTA ANA PD
report$recipient[report$recipient == "SANTA ANA PD17"] = "SANTA ANA PD"

# SANTA MONICA PD
report$recipient[report$recipient == "SANTA MONICA PD NA"] = "SANTA MONICA PD"
report$recipient[report$recipient == "SANTA MONICA PD7"] = "SANTA MONICA PD"

# SC CO SPEC FUND
report$recipient[report$recipient == "sc co SPEC FUND"] = "SC CO SPEC FUND"

# SFPD SPECIAL FUND
report$recipient[report$recipient == "SFPD SPECIAL FUND NA"] = "SFPD SPECIAL FUND"

# SHASTA CO SO
report$recipient[report$recipient == "8HA8TA CO 80"] = "SHASTA CO SO"
report$recipient[report$recipient == "SHASTA CO 80"] = "SHASTA CO SO"
report$recipient[report$recipient == "SHASTA CO SO7"] = "SHASTA CO SO"
report$recipient[report$recipient == "SPLASTA CO SO"] = "SHASTA CO SO"
report$recipient[report$recipient == "SPLASTA CO 80"] = "SHASTA CO SO"

# SISKIYOU CO DRUG / GANG
report$recipient[report$recipient == "SISKIYOU CO DRUG/ GANG"] = "SISKIYOU CO DRUG / GANG"
report$recipient[report$recipient == "Siskiyou CO Drug / Gang"] = "SISKIYOU CO DRUG / GANG"

# SOLANO CO SO 
report$recipient[report$recipient == "SOLANO COSO"] = "SOLANO CO SO"

# SONOMA CO SO
report$recipient[report$recipient == "SONOMA COSO"] = "SONOMA CO SO"

# SOUTH LAKETAHOE PD
report$recipient[report$recipient == "SOUTH LAKETAHOE PD"] = "SOUTH LAKE TAHOE PD"

# SOUTH SAN FRANCISCO PD
report$recipient[report$recipient == "SOUTH SANFRANCISCO PD"] = "SOUTH SAN FRANCISCO PD"

# STANISLAUS CAL-MMET
report$recipient[report$recipient == "STANISLAUS CAL—MMET"] = "STANISLAUS CAL-MMET"
report$recipient[report$recipient == "STANISLAUS CALâ€”MMET"] = "STANISLAUS CAL-MMET"

# STANISLAUS CO SO
report$recipient[report$recipient == "STANISLAUS COSO"] = "STANISLAUS CO SO"
report$recipient[report$recipient == "STANISLAUS CO SD NA"] = "STANISLAUS CO SO"
report$recipient[report$recipient == "STANISLAUS CO SD"] = "STANISLAUS CO SO"

# STOCKTON PD
report$recipient[report$recipient == "STOCKTON PD17"] = "STOCKTON PD"
report$recipient[report$recipient == "STOCKTON PD7"] = "STOCKTON PD"

# TEHAMA CO SO
report$recipient[report$recipient == "TEHAMA COSO"] = "TEHAMA CO SO"

# TF ALAMEDA CO
report$recipient[report$recipient == "TF ALAMEDA co"] = "TF ALAMEDA CO"

# TF ALAMEDA CO NTF
report$recipient[report$recipient == "TF ALAMEDA CONTF"] = "TF ALAMEDA CO NTF"

# TF BINTF
report$recipient[report$recipient == "F BINTF"] = "TF BINTF"

# TF BUTTE INTERAGY NET
report$recipient[report$recipient == "TF BUTTE INTERAGY NET7"] = "TF BUTTE INTERAGY NET"
report$recipient[report$recipient == "TF BUTTE INTERAGY NET17"] = "TF BUTTE INTERAGY NET"

# TF CAL MMET
report$recipient[report$recipient == "TF CAL MMET17"] = "TF CAL MMET"

# TF CENTRAL CC NET-CCCNET
report$recipient[report$recipient == "TF CENTRAL CC NET—CCCNET"] = "TF CENTRAL CC NET-CCCNET"
report$recipient[report$recipient == "TF CENTRAL CC NET-"] = "TF CENTRAL CC NET-CCCNET"
report$recipient[report$recipient == "TF CENTRAL CC NETâ€”CCCNET"] = "TF CENTRAL CC NET-CCCNET"
report$recipient[report$recipient == "TF CENTRAL CC"] = "TF CENTRAL CC NET-CCCNET"

# TF CVNTF
report$recipient[report$recipient == "TF CVNTF17"] = "TF CVNTF"

# TF GLINTF
report$recipient[report$recipient == "TF GLINTF7"] = "TF GLINTF"

# TF KINGS CO NTF
report$recipient[report$recipient == "TF KINGS CO NTF-KCNTF"] = "TF KINGS CO NTF"
report$recipient[report$recipient == "TF KINGS co NTF-KCNTF"] = "TF KINGS CO NTF"

# TF MAVMIT
report$recipient[report$recipient == "TF MAVMIT7"] = "TF MAVMIT"
report$recipient[report$recipient == "TF MAVMIT17"] = "TF MAVMIT"

# TF MENDOCINO MAJOR CRIME
report$recipient[report$recipient == "TF MENDOCINOMAJOR CRIME"] = "TF MENDOCINO MAJOR CRIME"
report$recipient[report$recipient == "TF MENDOCINO MAJOR"] = "TF MENDOCINO MAJOR CRIME"
report$recipient[report$recipient == "TF MENDOCINO MAJOR7"] = "TF MENDOCINO MAJOR CRIME"
report$recipient[report$recipient == "TF MENDOCINO MAJOR17"] = "TF MENDOCINO MAJOR CRIME"

# TF MERCED/M NTF-MMNTF
report$recipient[report$recipient == "TF MERCED/M NTF—MMNTF"] = "TF MERCED/M NTF-MMNTF"
report$recipient[report$recipient == "TF MERCED/M NTFâ€”MMNTF"] = "TF MERCED/M NTF-MMNTF"

# TF NAPA SPECIAL IB-NSIB
report$recipient[report$recipient == "TF NAPA SPECIAL IB-NSIBCDAA"] = "TF NAPA SPECIAL IB-NSIB"
report$recipient[report$recipient == "TF NAPA SPECIALIB-NSIB"] = "TF NAPA SPECIAL IB-NSIB"

# TF PALO VERDE VALLEY NTF
report$recipient[report$recipient == "TF PALO VERDE VALLEY"] = "TF PALO VERDE VALLEY NTF"

# TF RIVERSIDE CO GANG TF
report$recipient[report$recipient == "TF RIVERSIDE CO GANG TF7"] = "TF RIVERSIDE CO GANG TF"
report$recipient[report$recipient == "TF RIVERSIDE CO GANG TF17"] = "TF RIVERSIDE CO GANG TF"
report$recipient[report$recipient == "TF RIVERSIDE COGTF"] = "TF RIVERSIDE CO GANG TF"

# TF SAN MATEO CO NTF
report$recipient[report$recipient == "TF SAN MATEO CONTF"] = "TF SAN MATEO CO NTF"

# TF SANTA BARBARA
report$recipient[report$recipient == "TF SANTA BARBARA-"] = "TF SANTA BARBARA"
report$recipient[report$recipient == "TF SANTA BARBARA-17"] = "TF SANTA BARBARA"
report$recipient[report$recipient == "TF SANTA BARBARA-SBRNET"] = "TF SANTA BARBARA"

# TF SANTA CRUZ CO ACT
report$recipient[report$recipient == "TF SANTA CRUZ COACT"] = "TF SANTA CRUZ CO ACT"

# TF SHASTA INTERAGCY NTF
report$recipient[report$recipient == "TF SHASTAINTERAGCY NTF"] = "TF SHASTA INTERAGCY NTF"
report$recipient[report$recipient == "TF SHASTA INTERAGCY NTF7"] = "TF SHASTA INTERAGCY NTF"
report$recipient[report$recipient == "TF SHASTA INTERAGCY NTF NA"] = "TF SHASTA INTERAGCY NTF"
report$recipient[report$recipient == "TF SHASTA"] = "TF SHASTA INTERAGCY NTF"

# TF SISKIYOU CO
report$recipient[report$recipient == "TF SISKIYOU CO NA"] = "TF SISKIYOU CO"

# TF SISKIYOU CO INTF
report$recipient[report$recipient == "TF SISKIYOU CO INTF NA"] = "TF SISKIYOU CO INTF"

# TF SOUTHWEST CNTF
report$recipient[report$recipient == "TF SOUTH WEST CNTF"] = "TF SOUTHWEST CNTF"
report$recipient[report$recipient == "TF SOUTHWESTCNTF"] = "TF SOUTHWEST CNTF"
report$recipient[report$recipient == "TF SOUTHWEST NTF"] = "TF SOUTHWEST CNTF"

# TF TIDE
report$recipient[report$recipient == "TF TIDE17"] = "TF TIDE"
report$recipient[report$recipient == "TF TIDE7"] = "TF TIDE"

# TF TRIDENT
report$recipient[report$recipient == "TF TRIDENT17"] = "TF TRIDENT"
report$recipient[report$recipient == "TF TRIDENT7"] = "TF TRIDENT"
report$recipient[report$recipient == "TRIDENT"] = "TF TRIDENT"

# TF YOLO NET-YONET
report$recipient[report$recipient == "TF YOLO NET—YONET"] = "TF YOLO NET-YONET"
report$recipient[report$recipient == "TF YOLO NETâ€”YONET"] = "TF YOLO NET-YONET"

# TF YUBA/SUTTER NET-NET-S
report$recipient[report$recipient == "TF YUBA/SUTTER NET-NET-57"] = "TF YUBA/SUTTER NET-NET-S"
report$recipient[report$recipient == "TF YUBA/SUTTER NET-NET-5"] = "TF YUBA/SUTTER NET-NET-S"

# US MARSHALS SERVICE
report$recipient[report$recipient == "US MARSHALS"] = "US MARSHALS SERVICE"

# TORRANCE PD
report$recipient[report$recipient == "TORRANCE PD7"] = "TORRANCE PD"

# TRACY PD
report$recipient[report$recipient == "TRACY PD7"] = "TRACY PD"

# TRINITY CO SO
report$recipient[report$recipient == "TRINITY CO SO17"] = "TRINITY CO SO"
report$recipient[report$recipient == "TRINITY COSO"] = "TRINITY CO SO"
report$recipient[report$recipient == "TRINITY CO SO NA"] = "TRINITY CO SO"

# TULARE PD
report$recipient[report$recipient == "TULARE PD17"] = "TULARE PD"
report$recipient[report$recipient == "TULARE PD7"] = "TULARE PD"

# TULARE CO SO
report$recipient[report$recipient == "TULARE CO SO7"] = "TULARE CO SO"
report$recipient[report$recipient == "TULARE CO SO17"] = "TULARE CO SO"

# TUSTIN PD
report$recipient[report$recipient == "TUSTIN PD17"] = "TUSTIN PD"

# VACAVILLE PD
report$recipient[report$recipient == "VACAVILLE PD7"] = "VACAVILLE PD"

# VALLEJO PD
report$recipient[report$recipient == "VALLEJO PD7"] = "VALLEJO PD"
report$recipient[report$recipient == "VALLEJO PD17"] = "VALLEJO PD"

# VENTURA CO SO
report$recipient[report$recipient == "ENTURA CO SO"] = "VENTURA CO SO"

# VISALIA PD
report$recipient[report$recipient == "VISALIA PD7"] = "VISALIA PD"

# WILLITS PD
report$recipient[report$recipient == "WILLITS PD7"] = "WILLITS PD"
report$recipient[report$recipient == "VVILLITS PD"] = "WILLITS PD"

# WSIN
report$recipient[report$recipient == "WSIN7"] = "WSIN"

# YUBA CO SO
report$recipient[report$recipient == "YUBA CO SO7"] = "YUBA CO SO"

# YUCAIPA SHERIFF
report$recipient[report$recipient == "YUCAIPA SHERIFF STATION"] = "YUCAIPA SHERIFF"

# YOLO NARC ENF TEAM
report$recipient[report$recipient == "YOLO NARC ENF TEAM"] = "yolo co narcotics enforcement team woodland"

# Clear white spaces ####

report$recipient = gsub("\\s+", " ", report$recipient)
report$recipient = trimws(report$recipient)

#### return ####
return(report)
}














