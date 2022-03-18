# Making-Data-Tidy

First i read in the test and training data from a text file. Then i merged the test data and train data covariates with bind_rows function and called this x_full. This table had no descriptive column names, albeit these names were stored in a seperate text file. To go around this, i downloaded x_full using write.csv. Then i read in the variable name text file using the fread function in data.table. Then i used the fread function again to load the x_full file back into R while taking advantage of the col.names from the first fread function.

Next i binded rows for outcome variable y for both train and test data. Finally i binded columns for y and x_full to get the full data set with column names.

Then i renamed the outcome variable to reflect the labels, used group_by to group the data into these label categories and finally used summarize_at to find the mean for all variables except the y variable. Then i exported the table using write.table.
