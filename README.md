# llo_state_london_data

Processing of data for the State of London and London-level outcomes projects

## State of London / LLO indicators instructions

### Overview

I haven’t tried to incorporate my code into your repo yet. I thought it would be best to keep it simple and focus on getting the data ready for the SVG files, which is the most urgent task at hand, especially for the main LLO indicators. 

### Processing scripts

For these scripts, I have taken excel files from Barry and Sarah and reformatted the data to fit the same format as your data. I have then saved these files to your

### Build database

I have taken the csvs you put in your sharepoint directory and built up the database from there. All csvs should go in that directory.

I have also created a metadata.csv file that links to your csvs on the indicator field.

I link these two tables with a new primary key.

This is all done in the `build_llo_database.R` file. Should be stratightforward following how this works.

### Create svg charts

These can be created using either `r2d3` or `robservable`. *You run these from the other repo*, since we will need to keep the js files in that repo. 

#### R2D3

I have migrated as much as I can from observable to local .js files that can run locally and be called from R with the `r2d3` package.

The various d3 files call functions according to whether the x-axis is a regular date or quarterly. 

For bar charts, especially horizontal ones, there needs to be a different kind of x-axis again. So for now, this will need to come from observable.

We should eventually just use r2d3, but we should be able to do a wider array of charts using the existing code I have saved in observable.

This is a massive pain to feed in all the various parameters. So if it’s not immediately obvious how to do this, you can wait until I get back. 

I have included two examples of this.




