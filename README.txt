Supplemenatary R codes and data for  
"A semiparametric kernel independence test with application to mutational signatures"
#########################################################################################################################

This folder contains 15 files, 
1) this README.txt
2) SKIT_Supplementary.pdf
3) Tables and Figures.Rmd
4) Tables-and-Figures.html
5) TCGA_WES_sigProfiler_SBS_signatures_in_samples.csv
6) Reduced_ColoRect-AdenoCa.csv
7) Reduced_Eso-AdenoCa.csv
8) Reduced_Stomach-AdenoCa.csv
9) SKIT_Result_ColoRect-AdenoCa.csv
10) SKIT_Result_Eso-AdenoCa.csv
11) SKIT_Result_Stomach-AdenoCa.csv
12) SKIT_0.0.2.zip
13) SKIT_0.0.2.tar.gz
14) SKIT-manual.pdf
15) cir.corr.R

SKIT_Supplementary.pdf presents proofs and additional simulation/data analysis results.

Tables and Figures.Rmd is a R markdown file containing contains code to reproduce results for TCGA data analysis. 
A compiled html version Tables-and-Figures.html describes a detailed workflow to generate the main results 
in Table 2, Figure S.3 and Figure 4. 
In order to create Figure 4, the source code cir.corr.R and the R package ‘circlize’ will be required.

TCGA_WES_sigProfiler_SBS_signatures_in_samples.csv contains signatures and individual loading counts across 32 cancer types and
can be downloaded from https://www.synapse.org/#!Synapse:syn11801497.

Reduced_ColoRect-AdenoCa.csv, Reduced_Eso-AdenoCa.csv and Reduced_Stomach-AdenoCa.csv contain signature loadings 
with active signatures for colorectal, esophageal and stomach adenocarcinomas, respectively. 
A detailed description of these .csv files can be found in Section 1 of Tables-and-Figures.html.

Due to computation time, test results for all signature combinations are provided in the following .csv files:
SKIT_Result_ColoRect-AdenoCa.csv, SKIT_Result_Eso-AdenoCa.csv and SKIT_Result_Stomach-AdenoCa.csv. 
A detailed description of these .csv files can be found in Section 2 of Tables-and-Figures.html.

SKIT_0.0.2.zip is for Windows installment and SKIT_0.0.2.tar.gz is for Unix installment.
Relating manual is provided in SKIT-manual.pdf and a detailed example can also be found in Tables-and-Figures.html.

#########################################################################################################################
For compiling Tables and Figures.Rmd on your own computer, 
the first step is to install the package SKIT using the following command in Rstudio

### For Windows,
install.packages("SKIT_0.0.2.zip", repos = NULL)
or
install.packages("SKIT_0.0.2.tar.gz", repos = NULL, type = "source")

### For UNIX,
install.packages("SKIT_0.0.2.tar.gz", repos = NULL)

Next, open the Tables and Figures.Rmd file in Rstudio, and compile it using knit. 
