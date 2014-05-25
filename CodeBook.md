Codebook for UCI_Har_tidy.csv
-----------------------------

### Introduction

The **UCI_Har_tidy** dataset summarizes a subset of raw data according to [Tidy Data Principles](http://vita.had.co.nz/papers/tidy-data.pdf).  The raw data was sourced at the UCI Machine Learning Repository found here: [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) on 12 May 2014.

The raw data is well described at the link above.  Briefly, researchers carried out experiments with a group of 30 volunteers in which each person performed six activities (WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING, LAYING) while wearing a Samsung Galaxy SII smartphone on the waist. The smartphone's embedded accelerometer and gyroscope allowed the researchers to capture 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The researchers used video-recordings of the activities to label the data manually. They measured and/or generated 561 seperate "features" of the data for each subject over several repetitons of each activity.  They then randomly partitioned the data into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The instructions for tidying the data form the [Course Project](https://class.coursera.org/getdata-003/human_grading/view/courses/972136/assessments/3/submissions) for the Getting & Cleaning Data course, part of the Data Science Specialization from John Hopkins University on [Coursera](https://class.coursera.org/getdata-003).

### Sample data from UCI_Har_tidy

Code for accessing a sample a small sample of the tidy dataset and its output is shown below.


```r
setwd("~/Documents/Coursera/3_Getting and Cleaning Data/Assignment/UCI_HAR_Dataset")
tidy <- read.csv("UCI_Har_tidy.csv")
head(tidy[1:4], n = 12)
```

```
##    test_subject      activity_name tbodyacc_mean_x tbodyacc_mean_y
## 1             1             LAYING          0.2216       -0.040514
## 2             1            SITTING          0.2612       -0.001308
## 3             1           STANDING          0.2789       -0.016138
## 4             1            WALKING          0.2773       -0.017384
## 5             1 WALKING_DOWNSTAIRS          0.2892       -0.009919
## 6             1   WALKING_UPSTAIRS          0.2555       -0.023953
## 7             2             LAYING          0.2814       -0.018159
## 8             2            SITTING          0.2771       -0.015688
## 9             2           STANDING          0.2779       -0.018421
## 10            2            WALKING          0.2764       -0.018595
## 11            2 WALKING_DOWNSTAIRS          0.2776       -0.022661
## 12            2   WALKING_UPSTAIRS          0.2472       -0.021412
```


In reality, the UCI_Har_tidy dataset comprises 79 summary measurements for each activity performed by each subject, for a total of 81 variables.

### Details about UCI-Har_tidy

The data in the tidy datset is structured as shown in the following table. The variables in this dataset are reformatted from the original dataset according to the recommended safe naming conventions at [Advanced R by Hadley Wickham](http://adv-r.had.co.nz/Style.html).

**Only the mean and standard deviations of the time and frequency domain feature variables from the raw data are selected in this datatset, giving 79 total features, which are listed below the table.**

```
Variable Name     | Variable Type | Value         | Comments
__________________|_______________|_______________|__________________________________
test_subject      | integer       | 1-30          | represents a test subject
activity_name     | character     | *             | describes the activity undertaken               
tbodyacc_mean_x   | numeric       | normalized    | mean value of selected feature
                  |               | mean in the   |
                  |               | range -1 to 1 |
                  
* one of LAYING, SITTING, STANDING, WALKING, WALKING DOWNSTAIRS, WALKING UPSTAIRS

```
#### Activity features

A full list of the feature variables:
 
tbodyacc_mean_x  
tbodyacc_mean_y    	
tbodyacc_mean_z  
tbodyacc_std_x  		
tbodyacc_std_y  
tbodyacc_std_z  		
tgravityacc_mean_x  
tgravityacc_mean_y  		
tgravityacc_mean_z  
tgravityacc_std_x             
tgravityacc_std_y  
tgravityacc_std_z              
tbodyaccjerk_mean_x  
tbodyaccjerk_mean_y           
tbodyaccjerk_mean_z  
tbodyaccjerk_std_x             
tbodyaccjerk_std_y  
tbodyaccjerk_std_z           
tbodygyro_mean_x  
tbodygyro_mean_y  
tbodygyro_mean_z  
tbodygyro_std_x                
tbodygyro_std_y  
tbodygyro_std_z  
tbodygyrojerk_mean_x  
tbodygyrojerk_mean_y          
tbodygyrojerk_mean_z  
tbodygyrojerk_std_x          
tbodygyrojerk_std_y  
tbodygyrojerk_std_z           
tbodyaccmag_mean  
tbodyaccmag_std                
tgravityaccmag_mean  
tgravityaccmag_std           
tbodyaccjerkmag_mean  
tbodyaccjerkmag_std           
tbodygyromag_mean  
tbodygyromag_std              
tbodygyrojerkmag_mean  
tbodygyrojerkmag_std          
fbodyacc_mean_x  
fbodyacc_mean_y               
fbodyacc_mean_z  
fbodyacc_std_x                
fbodyacc_std_y  
fbodyacc_std_z                 
fbodyacc_meanfreq_x  
fbodyacc_meanfreq_y           
fbodyacc_meanfreq_z  
fbodyaccjerk_mean_x            
fbodyaccjerk_mean_y  
fbodyaccjerk_mean_z  
fbodyaccjerk_std_x  
fbodyaccjerk_std_y            
fbodyaccjerk_std_z  
fbodyaccjerk_meanfreq_x        
bodyaccjerk_meanfreq_y        
fbodyaccjerk_meanfreq_z     
fbodygyro_mean_x           
fbodygyro_mean_y              
fbodygyro_mean_z              
fbodygyro_std_x               
fbodygyro_std_y              
bodygyro_std_z            
fbodygyro_meanfreq_x        
bodygyro_meanfreq_y  
fbodygyro_meanfreq_z           
fbodyaccmag_mean              
fbodyaccmag_std               
fbodyaccmag_meanfreq         
fbodybodyaccjerkmag_mean        
fbodybodyaccjerkmag_std      
fbodybodyaccjerkmag_meanfreq   
fbodybodygyromag_mean         
fbodybodygyromag_std          
fbodybodygyromag_meanfreq      
fbodybodygyrojerkmag_mean       
fbodybodygyrojerkmag_std       
fbodybodygyrojerkmag_meanfreq  


