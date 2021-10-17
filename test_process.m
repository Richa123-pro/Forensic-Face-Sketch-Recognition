function result=test_process(final_feature_poto,final_eig_tr)

final_test= final_feature_poto(:);

[rrl ccl]= size(final_test);


len=length(final_eig_tr)/2;

% for k3=1:cc1

test_data=final_test'*final_test;
[val loc]=min((abs(final_eig_tr-test_data)));

result=loc-len;