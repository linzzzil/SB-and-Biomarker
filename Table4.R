library(dplyr)
library(readxl)
library(openxlsx)

input_folder <- "C:/Users/lli256/OneDrive - Emory University/PROJECTS/PREDIMED-Plus/Sedentary behavior and Biomarkers/3_Results/Table4/Iso_FU"
xlsx_files <- list.files(input_folder, pattern = "^ina.*\\.xlsx$", full.names = TRUE)

#time in bed
df_list <- list()

for (results in xlsx_files){
  df1 <-read_excel(results, sheet = "Mixed 10 - Solution for Fixe", range ="A15:K15", col_names = FALSE )
  
  df1 <- df1 %>% select(1,2,4,10,11) %>%
    mutate_if(is.numeric, round, digits=2)%>%
    mutate(model = 1)
  
  
  df2 <- read_excel(results, sheet = "Mixed 21 - Solution for Fixe", range ="A22:M22", col_names = FALSE )
  
  df2 <- df2 %>% select(1,2,6,12,13) %>%
    mutate_if(is.numeric, round, digits=2)%>%
    mutate(model = 2)
  
  df3 <-read_excel(results, sheet = "Mixed 32 - Solution for Fixe", range ="A34:Q34", col_names = FALSE )
  
  df3 <- df3 %>% select(1,2,10,16,17) %>%
    mutate_if(is.numeric, round, digits=2)%>%
    mutate(model = 3)
  
  df <- bind_rows(df1, df2, df3)
  
  name_part <- strsplit(basename(results), split = "log_")[[1]][2]
  
  # Add a new column with the Excel file name
  df <- df %>% mutate(ExcelFileName = name_part)
  
  # Store the data frame in the list
  df_list[[length(df_list) + 1]] <- df
}

# Combine all data frames into a single data frame
final_df <- bind_rows(df_list)

write.xlsx(final_df, "C:/Users/lli256/OneDrive - Emory University/PROJECTS/PREDIMED-Plus/Sedentary behavior and Biomarkers/3_Results/Table4_sleepv3_FU.xlsx")


#lpa
df_list <- list()

for (results in xlsx_files){
  df1 <-read_excel(results, sheet = "Mixed 10 - Solution for Fixe", range ="A18:K18", col_names = FALSE )
  
  df1 <- df1 %>% select(1,2,4,10,11) %>%
    mutate_if(is.numeric, round, digits=2)%>%
    mutate(model = 1)
  
  
  df2 <- read_excel(results, sheet = "Mixed 21 - Solution for Fixe", range ="A25:M25", col_names = FALSE )
  
  df2 <- df2 %>% select(1,2,6,12,13) %>%
    mutate_if(is.numeric, round, digits=2)%>%
    mutate(model = 2)
  
  df3 <-read_excel(results, sheet = "Mixed 32 - Solution for Fixe", range ="A37:Q37", col_names = FALSE )
  
  df3 <- df3 %>% select(1,2,10,16,17) %>%
    mutate_if(is.numeric, round, digits=2)%>%
    mutate(model = 3)
  
  df <- bind_rows(df1, df2, df3)
  
  name_part <- strsplit(basename(results), split = "log_")[[1]][2]
  
  # Add a new column with the Excel file name
  df <- df %>% mutate(ExcelFileName = name_part)
  
  # Store the data frame in the list
  df_list[[length(df_list) + 1]] <- df
}

# Combine all data frames into a single data frame
final_df <- bind_rows(df_list)

write.xlsx(final_df, "C:/Users/lli256/OneDrive - Emory University/PROJECTS/PREDIMED-Plus/Sedentary behavior and Biomarkers/3_Results/Table4_lpav3_FU.xlsx")


#mvpa
df_list <- list()

for (results in xlsx_files){
  df1 <-read_excel(results, sheet = "Mixed 10 - Solution for Fixe", range ="A21:K21", col_names = FALSE )
  
  df1 <- df1 %>% select(1,2,4,10,11) %>%
    mutate_if(is.numeric, round, digits=2)%>%
    mutate(model = 1)
  
  
  df2 <- read_excel(results, sheet = "Mixed 21 - Solution for Fixe", range ="A28:M28", col_names = FALSE )
  
  df2 <- df2 %>% select(1,2,6,12,13) %>%
    mutate_if(is.numeric, round, digits=2)%>%
    mutate(model = 2)
  
  df3 <-read_excel(results, sheet = "Mixed 32 - Solution for Fixe", range ="A40:Q40", col_names = FALSE )
  
  df3 <- df3 %>% select(1,2,10,16,17) %>%
    mutate_if(is.numeric, round, digits=2)%>%
    mutate(model = 3)
  
  df <- bind_rows(df1, df2, df3)
  
  name_part <- strsplit(basename(results), split = "log_")[[1]][2]
  
  # Add a new column with the Excel file name
  df <- df %>% mutate(ExcelFileName = name_part)
  
  # Store the data frame in the list
  df_list[[length(df_list) + 1]] <- df
}

# Combine all data frames into a single data frame
final_df <- bind_rows(df_list)

write.xlsx(final_df, "C:/Users/lli256/OneDrive - Emory University/PROJECTS/PREDIMED-Plus/Sedentary behavior and Biomarkers/3_Results/Table4_mvpav3_FU.xlsx")


##############
#visit 5
##############
#time in bed
df_list <- list()

for (results in xlsx_files){
  df1 <-read_excel(results, sheet = "Mixed 10 - Solution for Fixe", range ="A16:K16", col_names = FALSE )
  
  df1 <- df1 %>% select(1,2,4,10,11) %>%
    mutate_if(is.numeric, round, digits=2)%>%
    mutate(model = 1)
  
  
  df2 <- read_excel(results, sheet = "Mixed 21 - Solution for Fixe", range ="A23:M23", col_names = FALSE )
  
  df2 <- df2 %>% select(1,2,6,12,13) %>%
    mutate_if(is.numeric, round, digits=2)%>%
    mutate(model = 2)
  
  df3 <-read_excel(results, sheet = "Mixed 32 - Solution for Fixe", range ="A35:Q35", col_names = FALSE )
  
  df3 <- df3 %>% select(1,2,10,16,17) %>%
    mutate_if(is.numeric, round, digits=2)%>%
    mutate(model = 3)
  
  df <- bind_rows(df1, df2, df3)
  
  name_part <- strsplit(basename(results), split = "log_")[[1]][2]
  
  # Add a new column with the Excel file name
  df <- df %>% mutate(ExcelFileName = name_part)
  
  # Store the data frame in the list
  df_list[[length(df_list) + 1]] <- df
}

# Combine all data frames into a single data frame
final_df <- bind_rows(df_list)

write.xlsx(final_df, "C:/Users/lli256/OneDrive - Emory University/PROJECTS/PREDIMED-Plus/Sedentary behavior and Biomarkers/3_Results/Table4_sleepv5_FU.xlsx")


#lpa
df_list <- list()

for (results in xlsx_files){
  df1 <-read_excel(results, sheet = "Mixed 10 - Solution for Fixe", range ="A19:K19", col_names = FALSE )
  
  df1 <- df1 %>% select(1,2,4,10,11) %>%
    mutate_if(is.numeric, round, digits=2)%>%
    mutate(model = 1)
  
  
  df2 <- read_excel(results, sheet = "Mixed 21 - Solution for Fixe", range ="A26:M26", col_names = FALSE )
  
  df2 <- df2 %>% select(1,2,6,12,13) %>%
    mutate_if(is.numeric, round, digits=2)%>%
    mutate(model = 2)
  
  df3 <-read_excel(results, sheet = "Mixed 32 - Solution for Fixe", range ="A38:Q38", col_names = FALSE )
  
  df3 <- df3 %>% select(1,2,10,16,17) %>%
    mutate_if(is.numeric, round, digits=2)%>%
    mutate(model = 3)
  
  df <- bind_rows(df1, df2, df3)
  
  name_part <- strsplit(basename(results), split = "log_")[[1]][2]
  
  # Add a new column with the Excel file name
  df <- df %>% mutate(ExcelFileName = name_part)
  
  # Store the data frame in the list
  df_list[[length(df_list) + 1]] <- df
}

# Combine all data frames into a single data frame
final_df <- bind_rows(df_list)

write.xlsx(final_df, "C:/Users/lli256/OneDrive - Emory University/PROJECTS/PREDIMED-Plus/Sedentary behavior and Biomarkers/3_Results/Table4_lpav5_FU.xlsx")


#mvpa
df_list <- list()

for (results in xlsx_files){
  df1 <-read_excel(results, sheet = "Mixed 10 - Solution for Fixe", range ="A22:k22", col_names = FALSE )
  
  df1 <- df1 %>% select(1,2,4,10,11) %>%
    mutate_if(is.numeric, round, digits=2)%>%
    mutate(model = 1)
  
  
  df2 <- read_excel(results, sheet = "Mixed 21 - Solution for Fixe", range ="A29:M29", col_names = FALSE )
  
  df2 <- df2 %>% select(1,2,6,12,13) %>%
    mutate_if(is.numeric, round, digits=2)%>%
    mutate(model = 2)
  
  df3 <-read_excel(results, sheet = "Mixed 32 - Solution for Fixe", range ="A41:Q41", col_names = FALSE )
  
  df3 <- df3 %>% select(1,2,10,16,17) %>%
    mutate_if(is.numeric, round, digits=2)%>%
    mutate(model = 3)
  
  df <- bind_rows(df1, df2, df3)
  
  name_part <- strsplit(basename(results), split = "log_")[[1]][2]
  
  # Add a new column with the Excel file name
  df <- df %>% mutate(ExcelFileName = name_part)
  
  # Store the data frame in the list
  df_list[[length(df_list) + 1]] <- df
}

# Combine all data frames into a single data frame
final_df <- bind_rows(df_list)

write.xlsx(final_df, "C:/Users/lli256/OneDrive - Emory University/PROJECTS/PREDIMED-Plus/Sedentary behavior and Biomarkers/3_Results/Table4_mvpav5_FU.xlsx")

############
#Continuous visit#
############
xlsx_files <- list.files(input_folder, pattern = "^cont_ina.*\\.xlsx$", full.names = TRUE)

#time in bed
df_list <- list()

for (results in xlsx_files){
  df1 <-read_excel(results, sheet = "Mixed 10 - Solution for Fixe", range ="A13:J13", col_names = FALSE )
  
  df1 <- df1 %>% select(1,3,9,10) %>%
    mutate_if(is.numeric, round, digits=2)%>%
    mutate(model = 1)
  
  
  df2 <- read_excel(results, sheet = "Mixed 21 - Solution for Fixe", range ="A20:L20", col_names = FALSE )
  
  df2 <- df2 %>% select(1,5,11,12) %>%
    mutate_if(is.numeric, round, digits=2)%>%
    mutate(model = 2)
  
  df3 <-read_excel(results, sheet = "Mixed 32 - Solution for Fixe", range ="A32:P32", col_names = FALSE )
  
  df3 <- df3 %>% select(1,9,15,16) %>%
    mutate_if(is.numeric, round, digits=2)%>%
    mutate(model = 3)
  
  df <- bind_rows(df1, df2, df3)
  
  name_part <- strsplit(basename(results), split = "log_")[[1]][2]
  
  # Add a new column with the Excel file name
  df <- df %>% mutate(ExcelFileName = name_part)
  
  # Store the data frame in the list
  df_list[[length(df_list) + 1]] <- df
}

# Combine all data frames into a single data frame
final_df <- bind_rows(df_list)

write.xlsx(final_df, "C:/Users/lli256/OneDrive - Emory University/PROJECTS/PREDIMED-Plus/Sedentary behavior and Biomarkers/3_Results/Table4_sleep_cont_FU.xlsx")


#lpa
df_list <- list()

for (results in xlsx_files){
  df1 <-read_excel(results, sheet = "Mixed 10 - Solution for Fixe", range ="A14:J14", col_names = FALSE )
  
  df1 <- df1 %>% select(1,3,9,10) %>%
    mutate_if(is.numeric, round, digits=2)%>%
    mutate(model = 1)
  
  
  df2 <- read_excel(results, sheet = "Mixed 21 - Solution for Fixe", range ="A21:L21", col_names = FALSE )
  
  df2 <- df2 %>% select(1,5,11,12) %>%
    mutate_if(is.numeric, round, digits=2)%>%
    mutate(model = 2)
  
  df3 <-read_excel(results, sheet = "Mixed 32 - Solution for Fixe", range ="A33:P33", col_names = FALSE )
  
  df3 <- df3 %>% select(1,9,15,16) %>%
    mutate_if(is.numeric, round, digits=2)%>%
    mutate(model = 3)
  
  df <- bind_rows(df1, df2, df3)
  
  name_part <- strsplit(basename(results), split = "log_")[[1]][2]
  
  # Add a new column with the Excel file name
  df <- df %>% mutate(ExcelFileName = name_part)
  
  # Store the data frame in the list
  df_list[[length(df_list) + 1]] <- df
}

# Combine all data frames into a single data frame
final_df <- bind_rows(df_list)

write.xlsx(final_df, "C:/Users/lli256/OneDrive - Emory University/PROJECTS/PREDIMED-Plus/Sedentary behavior and Biomarkers/3_Results/Table4_lpa_cont_FU.xlsx")


#mvpa
df_list <- list()

for (results in xlsx_files){
  df1 <-read_excel(results, sheet = "Mixed 10 - Solution for Fixe", range ="A15:J15", col_names = FALSE )
  
  df1 <- df1 %>% select(1,3,9,10) %>%
    mutate_if(is.numeric, round, digits=2)%>%
    mutate(model = 1)
  
  
  df2 <- read_excel(results, sheet = "Mixed 21 - Solution for Fixe", range ="A22:L22", col_names = FALSE )
  
  df2 <- df2 %>% select(1,5,11,12) %>%
    mutate_if(is.numeric, round, digits=2)%>%
    mutate(model = 2)
  
  df3 <-read_excel(results, sheet = "Mixed 32 - Solution for Fixe", range ="A34:P34", col_names = FALSE )
  
  df3 <- df3 %>% select(1,9,15,16) %>%
    mutate_if(is.numeric, round, digits=2)%>%
    mutate(model = 3)
  
  df <- bind_rows(df1, df2, df3)
  
  name_part <- strsplit(basename(results), split = "log_")[[1]][2]
  
  # Add a new column with the Excel file name
  df <- df %>% mutate(ExcelFileName = name_part)
  
  # Store the data frame in the list
  df_list[[length(df_list) + 1]] <- df
}

# Combine all data frames into a single data frame
final_df <- bind_rows(df_list)

write.xlsx(final_df, "C:/Users/lli256/OneDrive - Emory University/PROJECTS/PREDIMED-Plus/Sedentary behavior and Biomarkers/3_Results/Table4_mvpa_cont_FU.xlsx")

