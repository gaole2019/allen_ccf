# allen ccf
# build a top-view annotation of cortical regions (n=43)


TargetBrainRegion <- c("FRP",
                      "MOp", "MOs",
                      "SSp-n", "SSp-bfd", "SSp-ll",
                      "SSp-m", "SSp-ul", "SSp-tr",
                      "SSp-un", "SSs",
                      "GU",
                      "VISC",
                      "AUDd", "AUDp", "AUDpo", "AUDv",
                      "VISal", "VISam", "VISl", "VISp", "VISpl",
                      "VISpm", "VISli", "VISpor",
                      "ACAd", "ACAv",
                      "PL",
                      "ILA",
                      "ORBl", "ORBm", "ORBvl",
                      "AId", "AIp", "AIv",
                      "RSPagl", "RSPd", "RSPv",
                      "VISa", "VISrl",
                      "TEa",
                      "PERI",
                      "ECT")

StructureID <-
  snp::shared_allen_anno$CurrentID[match(TargetBrainRegion,
                                         snp::shared_allen_anno$Acronym)]

NumRegion <- length(StructureID)


for (iRegion in 1:NumRegion) {
  tmpURL <-
    paste0("http://download.alleninstitute.org/informatics-archive/current-release/mouse_ccf/annotation/ccf_2017/structure_masks/structure_masks_25/structure_",
           StructureID[iRegion], ".nrrd")

  tmpPath <-
    paste0("./result/anno_cortex/",
           "structure_",
           StructureID[iRegion], "_", TargetBrainRegion[iRegion], "_25um.nrrd")

  download.file(tmpURL, tmpPath, "curl")
}






