function final_eig_tr=proj_process(final_feature_poto,final_feature_sketch)

loc=find(isnan(final_feature_poto));
final_feature_poto(loc)=1;

loc=find(isnan(final_feature_sketch));
final_feature_sketch(loc)=1;

[rr1 cc1]=size(final_feature_poto);
[rr2 cc2]=size(final_feature_sketch);

rrval=min([rr1 rr2]);

final_feature_poto=final_feature_poto(1:rrval,:);
final_feature_sketch=final_feature_sketch(1:rrval,:);

tr=(final_feature_poto);
te=(final_feature_sketch);

final_tr_database=([tr te]);

final_eig_tr=diag(final_tr_database'*final_tr_database);