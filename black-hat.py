##importing necessary packages:
import pandas as pd
import os
import seaborn as sns ## importing data visualiztion package
import matplotlib.pyplot as plt
os.getcwd()
black= pd.read_csv("black-hat-data.csv")

## try first:
#sns.scatterplot(data=black, x="Year",y="Value")
#plt.show() ## successfully shown 1 plot

## then make a facet plot using data visualization packages:
grid = sns.FacetGrid(black,col ="Pollutant",hue = "Country",col_wrap=3 )
grid.map(sns.scatterplot,"Year","Value")
#grid.set_axis_labels(x_var="Percentage Depth", y_var="Number of Defects")

## change y label:
grid.set_axis_labels(y_var="Average value (in thousands)") ## hint: this is a misleading title(change total to average)
grid.fig.subplots_adjust(top = 0.9) ## adjust the figure in grid
grid.fig.suptitle("Polluntant Distribution in 50 Years for 4 countries") ## hint: this is a misleading label(change 30 years to 50 years)
grid.add_legend()

## save plot to black-hat-viz.png
plt.savefig('black-hat-viz.png')

plt.show()