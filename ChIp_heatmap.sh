computeMatrix reference-point -S Fra1_treat.bw Junb_treat.bw \
                              -R ../peaks/klf5_dependent.bed ../peaks/klf5_independent.bed ../peaks/klf5_repressed.bed \
                                 ../peaks/foxa2_dependent.bed ../peaks/foxa2_independent.bed ../peaks/foxa2_repressed.bed \
                              -b 3000 \
                              -a 3000 \
                              -o ../peaks/foxa2_klf5_fj.mat.gz \
                              -p 16 \
                              --referencePoint center \
                              --missingDataAsZero --skipZeros
                              
#plotHeatmap -m ../peaks/foxa2_dependent_h3k27.mat.gz -out ../peaks/foxa2_dependent_h3k27.pdf --colorList 'white,blue' -x "peaks distance" -y "Foxa2 dependent" --heatmapHeight 20 --heatmapWidth 5
plotProfile -m ../kras_dependent_new/kras_depend.mat.gz -out ../kras_dependent_new/kras_depend.pdf --outFileNameData ../kras_dependent_new/kras_depend.tab
