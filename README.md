# ImmunoMap
In order to run source code, open MATLAB and set working directory to the folder that the code was extracted to.
Run GUI by typing 'ImmunoMapQuant' into the command line of MATLAB. GUI should open and allow user to begin analyzing *tsv files created by the Adaptive ImmunoSeq Portal. If a user wants to use files that are not produced from the Adaptive ImmunoSeq Portal, one can create a tsv file with columns of Nucloetide, Amino Acid, and Counts. ImmunoMap does not require nucleotide sequences but the first column should still be present as a placeholder, however can be left emtpy.

In order to run ImmunoMap without a MATLAB installation, download .exe file dropbox link below and install. This will install the MATLAB runtime engine allowing you to run MATLAB compiled executables such as ImmunoMap.

***MATLAB/ImmunoMap requires a 64-bit architecture*** 

PC Version: 
https://www.dropbox.com/s/wsdyvd88zh4uiy0/ImmunoMap_GUI.exe?dl=0

Mac Version (beta):
https://www.dropbox.com/sh/ogsxjvwl7e111n6/AACGtE7djQhPRjXErMndXfcua?dl=0

Further inqueries, contact JSidhom1@jhmi.edu

Instructions for Use:

1)	User selects files for analysis by pressing the ‘Select Files’ button and importing tsv files of TCRSeq Data exported by Adaptive Biotechnologies. If one has a different source of TCRSeq, one can submit a tsv file with the first column being nucleotide sequences, the second column being amino acid sequence, and the third column being number of counts. 
2)	After importing the files, one can set a variety of ImmunoMap parameters including how much of the file to use, structural homology thresholds, cluster frequency thresholds as well as parameters such as the scoring matrix used and the gap penalty. 
  - For setting the variety of cuts in the file, there are four options (Frequency Cut (%), Fraction of Response, Number of Unique CDR3,       and Number of Reads. 
    - Frequency Cut (%) denotes the minimum frequency threshold for a CDR3 to have to be included in the analysis. For example, if one 
    wanted to only include CDR3's with greater than 1% frequency, one would enter the value = 1.
    - Fraction of Response denotes the fraction of the total sum of reads one wants to be included in the analysis. This is analagous to 
    in a sense sampling a fraction of T-cells from the analysis. For example, if one wanted to sample half the reads or half the T-cells, 
    one would enter the value = 0.5. 
    - Number of Unique CDR3's denotes the absolute number of CDR3's one wants to analyze. For example, if one wanted to analyze the top 
    100 frequent CDR3's, one would enter a value = 100.
    - Number of Reads denotes the minimum number of absolute reads for a given CDR3 to be included in the analysis. For example, if one 
    wanted to include all CDR3's with at least 10 reads or higher, one would enter the value = 10. 
  - The homology threshold denotes the maximum sequence similarity to call two sequences part of the same 'cluster'. A good starting value   for this is somewhere between 0.25 - 0.35 with a PAM10 scoring matrix and Gap Penalty of 30. By manually examining clusters, one can 
  tune this parameter for their analysis. 
  - The Cluster frequency threshold denotes the minimum contribution of a cluster to be counted as a 'dominant motif'. For example, if one
  only wanted to examine clusters that contributed more than 1% to the entire analysis, they would enter the value of 1. 
  - The Scoring matrices provided allow the user to select how they want to score the sequence alignment. Suggested matrices include the 
  PAM10 and BLOSUM62 marix. 
  - The Gap Penalty is a measure of how much one wants to impose sequences of similar lengths. Values between 8-30 are recommended. 
    
3)	After parameters have been set, one highlights the files under the ‘Select Files’ button they want to analyze at once. At this point, the user can press ‘Run Immunomap’ and get a table of all relevant ImmunoMap metrics for their respective files. For each file, they can view the multiple alignments of their dominant motifs by selecting the file and the motif in the window to the right and pressing ‘Visualize Dominant Motifs.’ Finally, one can save a csv file with all the summarized ImmunoMap metrics by pressing the ‘Save Table to CSV’ button. This file can be opened by Microsoft Excel using a comma as the delimiter. 
4)	If one desires to compare multiple files by visualizing them by the Weighted Repertoire Dendrograms, they can highlight the desired files for visualization in the window beneath the ‘Select Files’ button and press ‘View Weighted Repertoire Dendrogram.’ 
5)	Finally, if one desires to compare two repertoires by seeing the percent of structural overlap as well shared dominant motifs, one should select the two files they want to compare in the drop menu’s provided and press the ‘Compare Two Repertoires’ button. 

