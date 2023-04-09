clear all; close all; clc;

cd 'E:\대학원\대학원 수업\2021-1 데이터마이닝\기말 프로젝트\blood_pressure'

%% train
load('tr_1.mat')
load('tr_2.mat')
load('tr_3.mat')
load('tr_4.mat')
load('tr_5.mat')

DBP = [DBP1;DBP2;DBP3;DBP4;DBP5];
SBP = [SBP1;SBP2;SBP3;SBP4;SBP5];
feature_AREA = [feature_AREA1;feature_AREA2;feature_AREA3;feature_AREA4;feature_AREA5];
feature_HEIGHT = [feature_HEIGHT1;feature_HEIGHT2;feature_HEIGHT3;feature_HEIGHT4;feature_HEIGHT5];
feature_WIDTH =[feature_WIDRH1;feature_WIDRH2;feature_WIDRH3;feature_WIDRH4;feature_WIDRH5];
feature_HR = [feature_HR1;feature_HR2;feature_HR3;feature_HR4;feature_HR5];
feature_STT = [feature_STT1;feature_STT2;feature_STT3;feature_STT4;feature_STT5];

save('train_data','SBP','DBP','feature_AREA','feature_HEIGHT','feature_WIDTH','feature_HR','feature_STT');

%% test
load('ts_1.mat')
load('ts_2.mat')

TS_DBP = [DBP6;DBP7];
TS_SBP = [SBP6;SBP7];
TS_feature_AREA = [feature_AREA6;feature_AREA7];
TS_feature_HEIGHT = [feature_HEIGHT6;feature_HEIGHT7];
TS_feature_WIDTH =[feature_WIDRH6;feature_WIDRH7'];
TS_feature_HR = [feature_HR6;feature_HR7'];
TS_feature_STT = [feature_STT6;feature_STT7];

save('test_data','TS_SBP','TS_DBP','TS_feature_AREA','TS_feature_HEIGHT','TS_feature_WIDTH','TS_feature_HR','TS_feature_STT');