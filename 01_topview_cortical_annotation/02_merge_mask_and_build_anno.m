
p = genpath('/home/admin/Documents/YanLab/Task_Local/Matlab_shared');
addpath(p);

cd('/run/media/admin/LeGAO2/allen_ccf/01_topview_cortical_annotation/')

fid = fopen('./result/anno_cortex/StructureID_Acronym.csv');
StructureID_Acronym = textscan(fid, '%u32, %s');
fclose(fid);

StructureID = StructureID_Acronym{1};
Acronym = StructureID_Acronym{2};

%% 
NumRegion = size(StructureID, 1);

anno = zeros([320, 528, 456], 'uint32');

for iRegion = 1:1:NumRegion
    tmpMask = nrrdread(strcat('./result/anno_cortex/mask/structure_', ...
        num2str(StructureID(iRegion,1)), '_', Acronym{iRegion,1},...
        '_25um.nrrd'));
    anno = anno + uint32(tmpMask) * StructureID(iRegion,1);
    iRegion
end

func_matrix2tiff(anno, 32, './result/anno_cortex/anno_cortex.tif');



%% top view
anno_top = zeros([528,456], 'uint32');
for iColumn = 1:1:528
    for iSlice = 1:1:456
        tmp_anno_line = anno(:,iColumn,iSlice);
        tmp_anno_index = find(tmp_anno_line > 0, 1,'first');
        if(isempty(tmp_anno_index))
            anno_top(iColumn, iSlice) = 0;
        else
            anno_top(iColumn, iSlice) = tmp_anno_line(tmp_anno_index);
        end
    end
end

func_matrix2tiff(anno_top, 32, './result/anno_cortex/anno_cortex_topview.tif');




%% do not use the structureID directly
% StructureID of some regions are of a very large value, causing the anno_cortex.tif poorly visualized in FIJI. 
% By the way, it is noted that FIJI parsed 32-bit images in an inprecise way for these large value. Here, 
% I just assign the regions a value based on the ordering in the StructureID_Acronym.csv.

anno_fake_structureID = zeros([320, 528, 456], 'uint32');

for iRegion = 1:1:NumRegion
    tmpMask = nrrdread(strcat('./result/anno_cortex/mask/structure_', ...
        num2str(StructureID(iRegion,1)), '_', Acronym{iRegion,1},...
        '_25um.nrrd'));
    anno_fake_structureID = anno_fake_structureID + uint32(tmpMask) * iRegion;
    iRegion
end

func_matrix2tiff(anno_fake_structureID, 32, ...
    './result/anno_cortex/anno_fake_structureID.tif');




%% top view
anno_top = zeros([528,456], 'uint8');
for iColumn = 1:1:528
    for iSlice = 1:1:456
        tmp_anno_line = anno_fake_structureID(:,iColumn,iSlice);
        tmp_anno_index = find(tmp_anno_line > 0, 1,'first');
        if(isempty(tmp_anno_index))
            anno_top(iColumn, iSlice) = 0;
        else
            anno_top(iColumn, iSlice) = tmp_anno_line(tmp_anno_index);
        end
    end
end

func_matrix2tiff(anno_top, 8, './result/anno_cortex/anno_fake_structureID_topview.tif');





