# Introduction

Generate a top-view annotation of cortical regions (n=43). For some specific applications, such as registration of cortex-wide calcium imaging data, it can be used to localize the cortical regions of pixels.

# Description of files

In the result folder, two versions of annotation files were provided.

-   Version 1

    -   anno_cortex.tif: 3D annotation file of cortical regions with each region encoded by its StructureID.

    -   anno_cortex_topview.tif: 2D top-view file

-   Version 2

    -   anno_fake_StructureID.tif: Each region is encoded by the ordering in the StructureID_Acronym.csv.

    -   anno_fake_StructureID_topview.tif: 2D top-view file
