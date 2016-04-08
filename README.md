# Emotion dynamics during conflict discussions

This repo contains the code for the analyses presented in our journal article, "An exploratory analysis of emotion dynamics between mothers and adolescents during conflict discussions" (Main, Paxton, &amp; Dale, accepted, *Emotion*).

To accompany the code, we also provide de-identified data for two dyads (contained in the `data` folder). We include the emotion time series for one low-satisfaction dyad and for one high-satisfaction dyad.

***

## Overview

Key variables in the `Main_Paxton_Dale-all_analyses.Rmd` files are `a_target_emotion` and `p_target_emotion`, which specify the categories of emotion states to be used in the plotting and computations. These lists are then used in source files:

+ `globals-functions.R`: Prepares workspace by importing data, loading necessary libraries, and creating new functions
+ `get_rqa_measures.R`: Calculates cross-recurrence profiles on the target emotion categories
+ `lmer_stats.R`: Runs linear mixed-effects models for standardized and unstandardized time series for all dyads' data, by adolescent age, and by dyad satisfaction score
+ `plot_drps_age.R`: Plots recurrence results by adolescent age
+ `plot_drps_satisfaction.R`: Plots recurrence results by dyad satisfaction score

***

## Viewing recommendation

For best viewing in a *browser*, we recommend selecting the `Main_Paxton_Dale-all_analyses.md`, rather than the similarly named `.Rmd` file.  (Analyses should be run using the `.Rmd` file of the same name.)
