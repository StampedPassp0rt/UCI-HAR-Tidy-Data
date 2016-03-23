The tidy data here is transformed data from UCI where they had 30 volunteers with Samsung Galaxys submit wearable fitness data for six activities.

More information about this is here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Transformations Done to the Data:

As detailed in the Readme, since the data was split up, I merged the Activity Codes and Subjects to the testing and training data, and then merged them all together.

As the training and test data all had the same number of columns, I used rbind to merge the two together.

As the rows for the training and test data corresponded to the Activity Code and Subject training and test data, I used cbind to merge these to the data set.

From there, to extract the means and standard deviations already calculated for the 3-axial signals in the X, Y, and Z directions,
I used dplyr and the select function. I used "contains" within select to subset out "mean()" and "std()" calculations for the variables.

After created the extracted data set, I labelled each activity appropriately and made the extracted mean and std variables more readable. I used gsub for this.

Finally, I used chaining to calculate the mean of each column, grouped by subject and activity.

Variables:

Subject: This is an integer variable from 1 to 30, with each integer denoting the volunteer for the smartphone data (there were 30 volunteers)
Activity: A six factor variable. The factors describe the Activity measured by the Smartphone, in this order:
  1) Walking
  2) Walking_Upstairs
  3) Walking_Downstairs
  4) Sitting
  5) Standing
  6) Laying
  
Extracted variables from the original 561-feature vector describing each activity (copying and pasting description from original data set for context):

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals, and that were extracted were:

mean(): Mean value
std(): Standard deviation

Essentially, we took those variables, and made them a little more descriptive:

 [3] "Time Body Accelerator Mean X"                                
 [4] "Time Body Accelerator Mean Y"                                
 [5] "Time Body Accelerator Mean Z"                                
 [6] "Time Gravity Accelerator Mean X"                             
 [7] "Time Gravity Accelerator Mean Y"                             
 [8] "Time Gravity Accelerator Mean Z"                             
 [9] "Time Body Accelerator Jerk Mean X"                           
[10] "Time Body Accelerator Jerk Mean Y"                           
[11] "Time Body Accelerator Jerk Mean Z"                           
[12] "Time Body Gyroscope Mean X"                                  
[13] "Time Body Gyroscope Mean Y"                                  
[14] "Time Body Gyroscope Mean Z"                                  
[15] "Time Body Gyroscope Jerk Mean X"                             
[16] "Time Body Gyroscope Jerk Mean Y"                             
[17] "Time Body Gyroscope Jerk Mean Z"                             
[18] "Time Body Accelerator Magnitude Mean"                        
[19] "Time Gravity Accelerator Magnitude Mean"                     
[20] "Time Body Accelerator Jerk Magnitude Mean"                   
[21] "Time Body Gyroscope Magnitude Mean"                          
[22] "Time Body Gyroscope Jerk Magnitude Mean"                     
[23] "Frequency Body Accelerator Mean X"                           
[24] "Frequency Body Accelerator Mean Y"                           
[25] "Frequency Body Accelerator Mean Z"                           
[26] "Frequency Body Accelerator Jerk Mean X"                      
[27] "Frequency Body Accelerator Jerk Mean Y"                      
[28] "Frequency Body Accelerator Jerk Mean Z"                      
[29] "Frequency Body Gyroscope Mean X"                             
[30] "Frequency Body Gyroscope Mean Y"                             
[31] "Frequency Body Gyroscope Mean Z"                             
[32] "Frequency Body Accelerator Magnitude Mean"                   
[33] "Frequency Body Accelerator Jerk Magnitude Mean"              
[34] "Frequency Body Gyroscope Magnitude Mean"                     
[35] "Frequency Body Gyroscope Jerk Magnitude Mean"                
[36] "Time Body Accelerator Standard Deviation X"                  
[37] "Time Body Accelerator Standard Deviation Y"                  
[38] "Time Body Accelerator Standard Deviation Z"                  
[39] "Time Gravity Accelerator Standard Deviation X"               
[40] "Time Gravity Accelerator Standard Deviation Y"               
[41] "Time Gravity Accelerator Standard Deviation Z"               
[42] "Time Body Accelerator Jerk Standard Deviation X"             
[43] "Time Body Accelerator Jerk Standard Deviation Y"             
[44] "Time Body Accelerator Jerk Standard Deviation Z"             
[45] "Time Body Gyroscope Standard Deviation X"                    
[46] "Time Body Gyroscope Standard Deviation Y"                    
[47] "Time Body Gyroscope Standard Deviation Z"                    
[48] "Time Body Gyroscope Jerk Standard Deviation X"               
[49] "Time Body Gyroscope Jerk Standard Deviation Y"               
[50] "Time Body Gyroscope Jerk Standard Deviation Z"               
[51] "Time Body Accelerator Magnitude Standard Deviation"          
[52] "Time Gravity Accelerator Magnitude Standard Deviation"       
[53] "Time Body Accelerator Jerk Magnitude Standard Deviation"     
[54] "Time Body Gyroscope Magnitude Standard Deviation"            
[55] "Time Body Gyroscope Jerk Magnitude Standard Deviation"       
[56] "Frequency Body Accelerator Standard Deviation X"             
[57] "Frequency Body Accelerator Standard Deviation Y"             
[58] "Frequency Body Accelerator Standard Deviation Z"             
[59] "Frequency Body Accelerator Jerk Standard Deviation X"        
[60] "Frequency Body Accelerator Jerk Standard Deviation Y"        
[61] "Frequency Body Accelerator Jerk Standard Deviation Z"        
[62] "Frequency Body Gyroscope Standard Deviation X"               
[63] "Frequency Body Gyroscope Standard Deviation Y"               
[64] "Frequency Body Gyroscope Standard Deviation Z"               
[65] "Frequency Body Accelerator Magnitude Standard Deviation"     
[66] "Frequency Body Accelerator Jerk Magnitude Standard Deviation"
[67] "Frequency Body Gyroscope Magnitude Standard Deviation"       
[68] "Frequency Body Gyroscope Jerk Magnitude Standard Deviation" 
