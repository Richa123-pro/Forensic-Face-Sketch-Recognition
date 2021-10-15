clc
clear all
close all
warning off;
delete databasemlbp.mat;

disp('******************');
disp('Forensic face sketch recognition');
disp('******************');
pause;


disp('-----------------');
disp('Executing training process');
disp('-----------------');
pause;

sketchDatabasePath=uigetdir(cd,'select sketch dataset images for training');
sketchfiles=dir(sketchDatabasePath);
no_of_fold=length(sketchfiles);

potoDatabasePathf=uigetdir(cd,'select forensic dataset images for training');
 potofilesf=dir(potoDatabasePathf);

 index=1;

 for k1=3:no_of_fold
    
     file_ske= sketchfiles(k1).name;
  file_poto=potofilesf(k1).name;

    if(~strcmp(file_ske,'Thumbs.db') & ~strcmp(file_poto,'Thumbs.db'));
        file_ske=strcat(sketchDatabasePath,'\',file_ske);
         file_poto=strcat(potoDatabasePathf,'\',file_poto);

         face_file{index}=file_poto;

         imag=imread(file_ske);
		
		            figure,imshow(imag);
title('Input-Sketch Images'),
            final_feature_sketch_img=pattern_bin_process(imag,2);
         len_siftg=length(final_feature_sketch_img(:));
            final_feature_sketch(1:len_siftg,index)=final_feature_sketch_img(:);
	        imagpo=rgb2gray(imread(file_poto));
	                    	figure,imshow(imagpo);
	    title('Input-Forensic Images');
	     [rr cc]=size(imagpo);
	    final_feature_poto_img=pattern_bin_process(imagpo,2);
	     len_siftg=length(final_feature_poto_img(:));
	     final_feature_poto(1:len_siftg,index)=final_feature_poto_img(:);

  index=index+1;
   end

end

 save databasemlbp.mat final_feature_poto final_feature_sketch face_file
close all;
pause;

load databasemlbp.mat

final_eig_tr=proj_process(final_feature_poto,final_feature_sketch);

sketchDatabasePath = uigetdir(cd,'Select sketch dataset images for testing');
sketchfiles=dir(sketchDatabasePath);
no_of_fold=length(sketchfiles);



index=1;
figure,
 for k1=3:no_of_fold
 
	file_ske= sketchfiles(k1).name;

	if(~strcmp(file_ske,'Thumbs.db'));

		file_ske=strcat(sketchDatabasePath,'\',file_ske);
		imag=imread(file_ske);
		final_feature_sketch_imgt=pattern_bin_process(imag,2);

		result=test_process(final_feature_sketch_imgt,final_eig_tr);

		subplot(1,2,1),imshow(imag);
		title('Query Image');
		file_res=face_file(result);
		subplot(1,2,2),imshow(imread(file_res));
		title('Matched Image');

		hold on;

		pause(0.1);
        close all
		end
        
end