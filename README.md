# Emotion dynamics during conflict discussions

This repo contains the code for the analyses presented in our journal article, "An exploratory analysis of emotion dynamics between mothers and adolescents during conflict discussions" (Main, Paxton, &amp; Dale, accepted, *Emotion*).

To accompany the code, we also provide de-identified data for two dyads (contained in the `data` folder). We include the emotion time series for one low-satisfaction dyad and for one high-satisfaction dyad.

Key variables in the `Main_Paxton_Dale-all_analyses.md files` are `a_target_emotion` and `p_target_emotion`, which specify the categories of emotion states to be used in the plotting and computations. These lists are then used in source files, such as `get_rqa_measures.R`, which calculates cross-recurrence profiles on those categories, and plotting scripts, which make use of the recurrence results. 

**Note**: For best viewing in a *browser*, we recommend selecting the `Main_Paxton_Dale-all_analyses.md`, rather than the similarly named `.Rmd` file.
