# How to run the quick checks (R)
1) Open R or RStudio in the repository folder
2) Run:
source("analysis/quick_checks.R")
The script reads:
data/sample_trajectory.csv and prints a few simple summaries:
- number of episodes per child
- average time to level 1
- re-engagement rate
- first vs last episode change
